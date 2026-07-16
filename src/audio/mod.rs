#[cfg(feature = "switch")]
mod horizon;
#[cfg(feature = "switch")]
pub use horizon::*;

#[cfg(not(feature = "switch"))]
mod desktop;
#[cfg(not(feature = "switch"))]
pub use desktop::*;
