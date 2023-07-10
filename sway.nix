{ callPackage
, makeOverridable
, sway-unwrapped
, sway
}:
let wlroots_0_16 = makeOverridable (args: (callPackage (import ./wlroots.nix) args).wlroots_0_16) { enableXWayland = false; }; 
in sway.override {
  sway-unwrapped = sway-unwrapped.override {
    inherit wlroots_0_16;
  };
}
