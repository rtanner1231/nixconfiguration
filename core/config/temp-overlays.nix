{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # 1. Disable checkPhase on mockery to bypass Go export data version mismatch
      go-mockery = prev.go-mockery.overrideAttrs (_: {
        doCheck = false;
      });

      mockery = prev.mockery.overrideAttrs (_: {
        doCheck = false;
      });

      # 2. Update fixed-output derivation hash for pnpm dependencies
      typescript-language-server = prev.typescript-language-server.overrideAttrs (oldAttrs: {
        pnpmDeps = oldAttrs.pnpmDeps.overrideAttrs (_: {
          outputHash = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
        });
      });
    })
  ];
}
