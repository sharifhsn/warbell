use std::sync::Arc;

use wgpu::{Deko3dWgslArtifactProvider, Deko3dWgslArtifactRequest, Deko3dWgslArtifactStage};

const SOURCE_SHA256: [u8; 32] = [
    0x72, 0x6f, 0x7d, 0x5d, 0x89, 0x4c, 0x4a, 0x68, 0x16, 0x2b, 0xe9, 0x20, 0x1f, 0xa5, 0x0b, 0x5b,
    0x46, 0xf4, 0x1a, 0x48, 0x29, 0xf8, 0xb2, 0x92, 0x22, 0x70, 0x16, 0xa9, 0x15, 0x65, 0xeb, 0xbe,
];
const FULLSCREEN_VERTEX_SHA256: [u8; 32] = [
    0x3e, 0x90, 0x0e, 0x4e, 0x70, 0xcd, 0x96, 0x36, 0xa4, 0xdd, 0xad, 0xd4, 0x99, 0x9b, 0xf0, 0x0d,
    0x79, 0x19, 0x4d, 0xde, 0xbe, 0x7d, 0x29, 0xc1, 0x66, 0xa1, 0x19, 0x5a, 0x5a, 0xf2, 0x60, 0x16,
];
const COPY_DEFERRED_FRAGMENT_SHA256: [u8; 32] = [
    0xff, 0x7d, 0xdb, 0xcf, 0x42, 0x89, 0xe0, 0xa9, 0x49, 0x4f, 0xdb, 0xc9, 0xf6, 0x49, 0x5a, 0xef,
    0xb7, 0x35, 0xa8, 0x2d, 0xab, 0xf5, 0x53, 0x08, 0x8b, 0x18, 0x09, 0xc9, 0xf0, 0x03, 0xfe, 0x18,
];
const COPY_FRAGMENT_SHA256: [u8; 32] = [
    0x14, 0x09, 0x6a, 0x18, 0xbe, 0xba, 0xbe, 0xb3, 0xc1, 0x53, 0x20, 0x7a, 0x5f, 0x6b, 0x8a, 0x15,
    0xae, 0x4c, 0x09, 0xc4, 0xeb, 0x09, 0x41, 0x84, 0x79, 0xdb, 0x5b, 0x24, 0xd6, 0x82, 0xc2, 0xa2,
];
const TONEMAPPING_FRAGMENT_SHA256: [u8; 32] = [
    0xfc, 0xc3, 0x15, 0x21, 0x61, 0x11, 0xbe, 0x51, 0xae, 0x38, 0x83, 0xd4, 0xd7, 0xbe, 0x4e, 0x01,
    0xbb, 0x3c, 0x63, 0xda, 0x00, 0x2a, 0x3b, 0xb9, 0xbd, 0x4d, 0xa0, 0x95, 0x1e, 0x6e, 0x46, 0x40,
];
const PBR_FRAGMENT_SHA256: [u8; 32] = [
    0x2b, 0x57, 0x1a, 0x36, 0xa4, 0x51, 0x33, 0x87, 0x13, 0x28, 0xad, 0x19, 0xc3, 0xaa, 0x30, 0xfe,
    0x79, 0xf2, 0x9a, 0xce, 0x18, 0xb6, 0xd9, 0xc1, 0xb2, 0xdf, 0x85, 0xc6, 0xe4, 0x3a, 0xca, 0x19,
];
const FULL_PBR_FRAGMENT_SHA256: [u8; 32] = [
    0xce, 0x0c, 0xe7, 0x98, 0x00, 0xd4, 0xfe, 0xe2, 0x9f, 0x8e, 0x18, 0xbe, 0x68, 0xe4, 0xad, 0xf0,
    0xf2, 0x8b, 0x56, 0xf9, 0x0d, 0xeb, 0xb2, 0xe9, 0x93, 0x88, 0x1e, 0x77, 0xbc, 0x30, 0xf7, 0x41,
];
const FULL_PBR_TEXTURED_FRAGMENT_SHA256: [u8; 32] = [
    0xc1, 0x13, 0xe5, 0x9a, 0xb1, 0x7b, 0x30, 0xd5, 0x28, 0xb9, 0x9b, 0xf5, 0x3e, 0xeb, 0xb1, 0x1e,
    0xcb, 0xc1, 0x63, 0xb4, 0x1c, 0x0a, 0x2f, 0x2f, 0xd7, 0xb7, 0x27, 0x26, 0x2a, 0xbc, 0xfa, 0xfc,
];
const WARBELL_PBR_FRAGMENT_SHA256: [u8; 32] = [
    0x6a, 0x4d, 0xf6, 0x09, 0xaa, 0x00, 0xf6, 0x1c, 0x5f, 0x99, 0xff, 0x31, 0x2d, 0x0a, 0x1a, 0x24,
    0x1c, 0xcf, 0x11, 0xd2, 0x6b, 0x30, 0x64, 0x5f, 0x10, 0xac, 0x53, 0xc0, 0x0b, 0xc4, 0x96, 0x47,
];
const WARBELL_TONEMAPPING_FRAGMENT_SHA256: [u8; 32] = [
    0x5c, 0x87, 0x5e, 0xaf, 0x29, 0xd6, 0xd1, 0x9d, 0x8c, 0x30, 0xba, 0x7e, 0xd6, 0xb4, 0x3e, 0x60,
    0x1d, 0x89, 0xd7, 0xdd, 0x84, 0x36, 0x54, 0xeb, 0x2d, 0x60, 0xaf, 0x83, 0x45, 0xa9, 0x2f, 0x6a,
];
const FULL_GAME_TONEMAPPING_FRAGMENT_SHA256: [u8; 32] = [
    0x0d, 0x13, 0xa4, 0xba, 0x69, 0x41, 0x52, 0x42, 0xb7, 0x8a, 0x59, 0x9b, 0x16, 0x18, 0x33, 0xe6,
    0xa7, 0x5b, 0xf8, 0x88, 0x50, 0x8e, 0xcc, 0x5e, 0x65, 0xa5, 0x67, 0xc9, 0x42, 0x8d, 0x6e, 0xe8,
];
const PBR_VERTEX_SHA256: [u8; 32] = [
    0xb9, 0x3a, 0x61, 0xc6, 0x5d, 0x7a, 0x8a, 0x25, 0x47, 0x14, 0xe9, 0xe3, 0xd2, 0xd2, 0x9f, 0xad,
    0x50, 0x8c, 0xcc, 0xf1, 0x46, 0x7c, 0x09, 0x7b, 0xb3, 0xb5, 0xb2, 0x1a, 0xf9, 0xbd, 0xbf, 0x6a,
];
const MESH_VERTEX_SHA256: [u8; 32] = [
    0x08, 0x33, 0xc5, 0xbf, 0x33, 0x79, 0x26, 0x93, 0x76, 0xd2, 0x67, 0x9c, 0x36, 0x73, 0xca, 0x06,
    0xcb, 0xd1, 0xac, 0x5e, 0xbe, 0xf8, 0x4c, 0x61, 0x46, 0xa6, 0xc6, 0x7e, 0xca, 0x2f, 0x32, 0x74,
];
const MESH_FRAGMENT_SHA256: [u8; 32] = [
    0x77, 0xe3, 0x91, 0x2b, 0x09, 0x16, 0xa7, 0x44, 0xaf, 0x9a, 0x95, 0xe4, 0x4f, 0x83, 0xc9, 0x11,
    0x3b, 0x04, 0x7f, 0xd4, 0xc6, 0x1c, 0x74, 0xb0, 0x03, 0xcc, 0xe0, 0xf2, 0x28, 0x87, 0x5a, 0x03,
];
const MESH_COLOR_SHA256: [u8; 32] = [
    0x39, 0x02, 0x72, 0x9b, 0x73, 0xc9, 0xbf, 0xbe, 0x4a, 0x00, 0xdc, 0xdf, 0xb6, 0xe4, 0x53, 0x79,
    0x2f, 0x77, 0xd8, 0x0f, 0x93, 0x11, 0xd1, 0x2d, 0x38, 0xf3, 0xb3, 0xd5, 0x8e, 0xf0, 0xaf, 0xaa,
];
const MESH_COLOR_FRAGMENT_SHA256: [u8; 32] = [
    0x08, 0xb0, 0xc2, 0x48, 0xe5, 0x6e, 0xe7, 0xc4, 0x4a, 0x6f, 0xc4, 0xa5, 0x40, 0xef, 0x4e, 0xb3,
    0xed, 0xba, 0xf0, 0xaa, 0x33, 0xf1, 0x4b, 0x37, 0x8c, 0xd0, 0x5b, 0x72, 0x18, 0xd5, 0xce, 0xa6,
];
const MESH_VERTEX_COLOR_SHA256: [u8; 32] = [
    0xe8, 0xe7, 0x6a, 0xad, 0xb9, 0x7c, 0x9c, 0x0e, 0x74, 0xa8, 0xa9, 0xc6, 0xec, 0x56, 0xbc, 0xc1,
    0xee, 0x95, 0x58, 0x63, 0xe7, 0x6c, 0xaf, 0xc6, 0x5c, 0xf1, 0x86, 0x8b, 0x77, 0x10, 0x10, 0x7a,
];
const CREATURE_VERTEX_SHA256: [u8; 32] = [
    0xe3, 0xb5, 0x34, 0xfc, 0x23, 0x9e, 0x81, 0xe5, 0xfe, 0x3f, 0x6f, 0xae, 0x77, 0xe5, 0xbe, 0x5a,
    0xa5, 0x1e, 0x0c, 0x3a, 0x2a, 0x03, 0x97, 0x8a, 0xb6, 0x23, 0x86, 0xee, 0xeb, 0x5f, 0xe1, 0x36,
];
const CREATURE_FRAGMENT_SHA256: [u8; 32] = [
    0xf1, 0x2b, 0xbe, 0x2a, 0xa3, 0x2c, 0x89, 0x58, 0x6e, 0xbb, 0xf6, 0x1e, 0x6d, 0xad, 0x65, 0x5b,
    0xe7, 0xc6, 0xaf, 0xff, 0x31, 0x77, 0x49, 0xb4, 0x80, 0x3a, 0x96, 0xc9, 0xe5, 0x03, 0xd2, 0x2c,
];
const POST_PROCESS_FRAGMENT_SHA256: [u8; 32] = [
    0xf0, 0xa1, 0x9f, 0x98, 0xc1, 0x4d, 0x68, 0x01, 0x95, 0x2b, 0x1c, 0x48, 0x0e, 0x8f, 0x8e, 0x50,
    0x4c, 0xaf, 0xdc, 0x10, 0x74, 0x68, 0xe5, 0xb7, 0x8d, 0x33, 0x0a, 0x99, 0x79, 0x1a, 0x39, 0x43,
];
const UI_SHA256: [u8; 32] = [
    0x05, 0xa5, 0x04, 0x65, 0xc7, 0x54, 0x20, 0x2d, 0x98, 0x48, 0x3d, 0xe2, 0x31, 0x57, 0x1a, 0xae,
    0x38, 0x81, 0xb8, 0x9e, 0xed, 0x3e, 0x0e, 0x20, 0x96, 0xf0, 0x0f, 0x27, 0x33, 0x5c, 0xe2, 0x36,
];
const UI_SHADOW_SHA256: [u8; 32] = [
    0xbd, 0x46, 0x1c, 0xf1, 0x9f, 0xc3, 0xf8, 0xe7, 0xb1, 0xf7, 0x83, 0x5d, 0xda, 0x0f, 0x78, 0xdd,
    0xf2, 0x75, 0x35, 0x6a, 0xa4, 0x87, 0x91, 0x10, 0xa0, 0x00, 0xb5, 0xe1, 0x3b, 0x38, 0x2a, 0x9a,
];
const UI_GRADIENT_SHA256: [u8; 32] = [
    0xaa, 0xac, 0xc5, 0xbb, 0xf2, 0xd2, 0x75, 0x07, 0xa1, 0x7d, 0x19, 0xf6, 0xe3, 0x7c, 0xd3, 0x2d,
    0xaf, 0x17, 0x20, 0xf7, 0xdc, 0xab, 0x1e, 0x7a, 0x22, 0xd4, 0xeb, 0xc3, 0x25, 0x5c, 0x7c, 0xdf,
];

pub struct WarbellDeko3dProvider;

impl Deko3dWgslArtifactProvider for WarbellDeko3dProvider {
    fn resolve(&self, request: Deko3dWgslArtifactRequest<'_>) -> Result<Arc<[u8]>, String> {
        if let Some(artifact) = load_shader_override(&request)? {
            return Ok(artifact);
        }
        if request.wgsl_sha256 == FULLSCREEN_VERTEX_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "fullscreen_vertex_shader"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/3e900e4e-fullscreen.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == COPY_DEFERRED_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/ff7ddbcf-copy-deferred.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == COPY_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/14096a18-copy.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == TONEMAPPING_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/fcc31521-tonemapping.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == PBR_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/2b571a36-pbr.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == FULL_PBR_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/ce0ce798-pbr.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == FULL_PBR_TEXTURED_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/c113e59a-pbr.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == WARBELL_PBR_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/6a4df609-pbr.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == WARBELL_TONEMAPPING_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/5c875eaf-tonemapping.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == FULL_GAME_TONEMAPPING_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/0d13a4ba-tonemapping.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == PBR_VERTEX_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/b93a61c6-pbr.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == MESH_VERTEX_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/0833c5bf-mesh.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == MESH_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/77e3912b-mesh.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == MESH_COLOR_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/3902729b-mesh-color.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == MESH_COLOR_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/08b0c248-mesh-color.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == MESH_VERTEX_COLOR_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/e8e76aad-mesh-color.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == CREATURE_VERTEX_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/e3b534fc-creature.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == CREATURE_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/f12bbe2a-creature.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == POST_PROCESS_FRAGMENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/f0a19f98-post-process.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/05a50465-ui.vert.dksh").as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_SHADOW_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/bd461cf1-ui-shadow.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_GRADIENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Vertex
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/aaacc5bb-ui-gradient.vert.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_GRADIENT_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/aaacc5bb-ui-gradient.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_SHADOW_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/bd461cf1-ui-shadow.frag.dksh")
                    .as_slice(),
            ));
        }
        if request.wgsl_sha256 == UI_SHA256
            && request.stage == Deko3dWgslArtifactStage::Fragment
            && request.entry_point == "main"
        {
            return Ok(Arc::from(
                include_bytes!("../assets/shaders/deko3d-runtime/05a50465-ui.frag.dksh").as_slice(),
            ));
        }
        if request.wgsl_sha256 != SOURCE_SHA256 {
            capture_runtime_shader(&request);
            eprintln!(
                "[warbell-switch] proof_artifact_lookup miss stage={:?} entry={} reason=wgsl_hash",
                request.stage, request.entry_point
            );
            #[cfg(target_os = "horizon")]
            wgpu_hal::deko3d::dump_debug_trace("shader_provider_wgsl_hash_miss");
            return Err("no Warbell proof DKSH artifact for this WGSL hash".to_string());
        }
        match (request.stage, request.entry_point) {
            (Deko3dWgslArtifactStage::Vertex, "vs_main") => {
                println!(
                    "[warbell-switch] proof_artifact_lookup hit stage=vertex entry=vs_main path=embedded:assets/shaders/deko3d-proof/proof_vsh.dksh"
                );
                Ok(Arc::from(
                    include_bytes!("../assets/shaders/deko3d-proof/proof_vsh.dksh").as_slice(),
                ))
            }
            (Deko3dWgslArtifactStage::Fragment, "fs_main") => {
                println!(
                    "[warbell-switch] proof_artifact_lookup hit stage=fragment entry=fs_main path=embedded:assets/shaders/deko3d-proof/proof_fsh.dksh"
                );
                Ok(Arc::from(
                    include_bytes!("../assets/shaders/deko3d-proof/proof_fsh.dksh").as_slice(),
                ))
            }
            _ => {
                eprintln!(
                    "[warbell-switch] proof_artifact_lookup miss stage={:?} entry={} reason=entry",
                    request.stage, request.entry_point
                );
                #[cfg(target_os = "horizon")]
                wgpu_hal::deko3d::dump_debug_trace("shader_provider_entry_miss");
                Err(format!(
                    "no Warbell proof DKSH artifact for {:?} entry {}",
                    request.stage, request.entry_point
                ))
            }
        }
    }
}

#[cfg(all(target_os = "horizon", feature = "switch-emulator"))]
fn load_shader_override(
    request: &Deko3dWgslArtifactRequest<'_>,
) -> Result<Option<Arc<[u8]>>, String> {
    use serde::Deserialize;
    use sha2::{Digest, Sha256};
    use std::{fmt::Write as _, fs, io::ErrorKind, path::PathBuf};

    #[derive(Deserialize)]
    struct OverrideManifest {
        request_sha256: String,
        artifact_sha256: String,
        stage: String,
        request_entry: String,
        designation: String,
    }

    let mut digest = String::with_capacity(64);
    for byte in request.wgsl_sha256 {
        let _ = write!(digest, "{byte:02x}");
    }
    let stage = match request.stage {
        Deko3dWgslArtifactStage::Vertex => "vertex",
        Deko3dWgslArtifactStage::Fragment => "fragment",
        Deko3dWgslArtifactStage::Compute => "compute",
    };
    let entry_point: String = request
        .entry_point
        .chars()
        .map(|character| {
            if character.is_ascii_alphanumeric() || character == '_' {
                character
            } else {
                '_'
            }
        })
        .collect();
    let path = PathBuf::from("sdmc:/switch/warbell-shader-overrides")
        .join(format!("{digest}-{stage}-{entry_point}.dksh"));
    match fs::read(&path) {
        Ok(bytes) => {
            let manifest_path = path.with_extension("json");
            let manifest: OverrideManifest =
                serde_json::from_slice(&fs::read(&manifest_path).map_err(|error| {
                    format!(
                        "shader override {} has no readable manifest: {error}",
                        path.display()
                    )
                })?)
                .map_err(|error| {
                    format!(
                        "shader override {} has an invalid manifest: {error}",
                        path.display()
                    )
                })?;
            if manifest.request_sha256 != digest
                || manifest.stage != stage
                || manifest.request_entry != request.entry_point
            {
                return Err(format!(
                    "shader override {} manifest does not match the request",
                    path.display()
                ));
            }
            if manifest.designation == "diagnostic"
                && !PathBuf::from("sdmc:/switch/warbell-shader-overrides/ALLOW_DIAGNOSTIC")
                    .is_file()
            {
                return Err(format!(
                    "diagnostic shader override {} requires ALLOW_DIAGNOSTIC",
                    path.display()
                ));
            }
            if manifest.designation != "diagnostic" && manifest.designation != "production" {
                return Err(format!(
                    "shader override {} has an invalid designation",
                    path.display()
                ));
            }
            let artifact_sha256 = format!("{:x}", Sha256::digest(&bytes));
            if artifact_sha256 != manifest.artifact_sha256 {
                return Err(format!(
                    "shader override {} failed artifact integrity validation",
                    path.display()
                ));
            }
            eprintln!(
                "[warbell-switch] shader_override hit path={} bytes={}",
                path.display(),
                bytes.len()
            );
            Ok(Some(Arc::from(bytes)))
        }
        Err(error) if error.kind() == ErrorKind::NotFound => Ok(None),
        Err(error) => Err(format!(
            "failed to read Deko3D shader override {}: {error}",
            path.display()
        )),
    }
}

#[cfg(not(all(target_os = "horizon", feature = "switch-emulator")))]
fn load_shader_override(_: &Deko3dWgslArtifactRequest<'_>) -> Result<Option<Arc<[u8]>>, String> {
    Ok(None)
}

#[cfg(target_os = "horizon")]
fn capture_runtime_shader(request: &Deko3dWgslArtifactRequest<'_>) {
    use std::{fmt::Write as _, fs, path::PathBuf};

    let mut digest = String::with_capacity(64);
    for byte in request.wgsl_sha256 {
        let _ = write!(digest, "{byte:02x}");
    }
    let stage = match request.stage {
        Deko3dWgslArtifactStage::Vertex => "vertex",
        Deko3dWgslArtifactStage::Fragment => "fragment",
        Deko3dWgslArtifactStage::Compute => "compute",
    };
    let entry_point: String = request
        .entry_point
        .chars()
        .map(|character| {
            if character.is_ascii_alphanumeric() || character == '_' {
                character
            } else {
                '_'
            }
        })
        .collect();
    let directory = PathBuf::from("sdmc:/switch/warbell-shaders");
    let path = directory.join(format!("{digest}-{stage}-{entry_point}.wgsl"));
    let result = fs::create_dir_all(&directory).and_then(|()| fs::write(&path, request.wgsl));
    eprintln!(
        "[warbell-switch] shader_capture path={} bytes={} result={result:?}",
        path.display(),
        request.wgsl.len()
    );
}

#[cfg(not(target_os = "horizon"))]
fn capture_runtime_shader(_: &Deko3dWgslArtifactRequest<'_>) {}

#[cfg(test)]
mod tests {
    use super::*;

    fn request(stage: Deko3dWgslArtifactStage, entry_point: &str) -> Deko3dWgslArtifactRequest<'_> {
        request_with_hash(SOURCE_SHA256, stage, entry_point)
    }

    fn request_with_hash(
        wgsl_sha256: [u8; 32],
        stage: Deko3dWgslArtifactStage,
        entry_point: &str,
    ) -> Deko3dWgslArtifactRequest<'_> {
        Deko3dWgslArtifactRequest {
            wgsl: b"",
            wgsl_sha256,
            stage,
            entry_point,
        }
    }

    #[test]
    fn resolves_both_proof_stages_and_rejects_misses() {
        let provider = WarbellDeko3dProvider;
        assert!(
            provider
                .resolve(request(Deko3dWgslArtifactStage::Vertex, "vs_main"))
                .unwrap()
                .starts_with(b"DKSH")
        );
        assert!(
            provider
                .resolve(request(Deko3dWgslArtifactStage::Fragment, "fs_main"))
                .unwrap()
                .starts_with(b"DKSH")
        );
        assert!(
            provider
                .resolve(request(Deko3dWgslArtifactStage::Fragment, "missing"))
                .is_err()
        );
        assert!(
            provider
                .resolve(Deko3dWgslArtifactRequest {
                    wgsl: b"",
                    wgsl_sha256: [0; 32],
                    stage: Deko3dWgslArtifactStage::Vertex,
                    entry_point: "vs_main"
                })
                .is_err()
        );
    }

    #[test]
    fn resolves_native_full_pbr_fragments() {
        let provider = WarbellDeko3dProvider;
        let tone_mapping = provider
            .resolve(request_with_hash(
                PBR_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "fragment",
            ))
            .unwrap();
        let full_pbr = provider
            .resolve(request_with_hash(
                FULL_PBR_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();
        let warbell_pbr = provider
            .resolve(request_with_hash(
                WARBELL_PBR_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();
        let warbell_tonemapping = provider
            .resolve(request_with_hash(
                WARBELL_TONEMAPPING_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();
        let full_game_tonemapping = provider
            .resolve(request_with_hash(
                FULL_GAME_TONEMAPPING_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();

        assert!(tone_mapping.starts_with(b"DKSH"));
        assert!(full_pbr.starts_with(b"DKSH"));
        assert!(warbell_pbr.starts_with(b"DKSH"));
        assert!(warbell_tonemapping.starts_with(b"DKSH"));
        assert!(full_game_tonemapping.starts_with(b"DKSH"));
        assert_eq!(
            tone_mapping.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/2b571a36-pbr.frag.dksh")
        );
        assert_eq!(
            full_pbr.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/ce0ce798-pbr.frag.dksh")
        );
        assert_eq!(
            warbell_pbr.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/6a4df609-pbr.frag.dksh")
        );
        assert_eq!(
            warbell_tonemapping.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/5c875eaf-tonemapping.frag.dksh")
        );
        assert_eq!(
            full_game_tonemapping.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/0d13a4ba-tonemapping.frag.dksh")
        );
    }

    #[test]
    fn resolves_full_game_mesh_pipeline() {
        let vertex = WarbellDeko3dProvider
            .resolve(request_with_hash(
                MESH_VERTEX_SHA256,
                Deko3dWgslArtifactStage::Vertex,
                "main",
            ))
            .unwrap();
        let fragment = WarbellDeko3dProvider
            .resolve(request_with_hash(
                MESH_FRAGMENT_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();

        assert!(vertex.starts_with(b"DKSH"));
        assert!(fragment.starts_with(b"DKSH"));
        assert_eq!(
            vertex.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/0833c5bf-mesh.vert.dksh")
        );
        assert_eq!(
            fragment.as_ref(),
            include_bytes!("../assets/shaders/deko3d-runtime/77e3912b-mesh.frag.dksh")
        );
    }

    #[test]
    fn resolves_ui_shadow_pipeline() {
        let provider = WarbellDeko3dProvider;
        let vertex = provider
            .resolve(request_with_hash(
                UI_SHADOW_SHA256,
                Deko3dWgslArtifactStage::Vertex,
                "main",
            ))
            .unwrap();
        let fragment = provider
            .resolve(request_with_hash(
                UI_SHADOW_SHA256,
                Deko3dWgslArtifactStage::Fragment,
                "main",
            ))
            .unwrap();

        assert!(vertex.starts_with(b"DKSH"));
        assert!(fragment.starts_with(b"DKSH"));
    }
}
