use std::sync::Arc;

use wgpu::{Deko3dWgslArtifactProvider, Deko3dWgslArtifactRequest, Deko3dWgslArtifactStage};

const SOURCE_SHA256: [u8; 32] = [
    0x53, 0xf1, 0x11, 0x94, 0x75, 0xcf, 0x01, 0xec, 0x2e, 0x8c, 0x0c, 0xe3, 0x2e, 0xd9, 0x55, 0x0d,
    0x8d, 0x12, 0x8c, 0x5a, 0x9d, 0xf9, 0x52, 0x2a, 0x08, 0x4a, 0xe5, 0xd3, 0x91, 0x21, 0x46, 0x05,
];

pub struct WarbellProofProvider;

impl Deko3dWgslArtifactProvider for WarbellProofProvider {
    fn resolve(&self, request: Deko3dWgslArtifactRequest<'_>) -> Result<Arc<[u8]>, String> {
        if request.wgsl_sha256 != SOURCE_SHA256 {
            eprintln!(
                "[warbell-switch] proof_artifact_lookup miss stage={:?} entry={} reason=wgsl_hash",
                request.stage, request.entry_point
            );
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
                Err(format!(
                    "no Warbell proof DKSH artifact for {:?} entry {}",
                    request.stage, request.entry_point
                ))
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn request(stage: Deko3dWgslArtifactStage, entry_point: &str) -> Deko3dWgslArtifactRequest<'_> {
        Deko3dWgslArtifactRequest {
            wgsl: b"",
            wgsl_sha256: SOURCE_SHA256,
            stage,
            entry_point,
        }
    }

    #[test]
    fn resolves_both_proof_stages_and_rejects_misses() {
        let provider = WarbellProofProvider;
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
}
