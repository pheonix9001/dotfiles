{
  nixpkgs,
  crane-lib,
}: {
  lemonbar-config = crane-lib.buildPackage {
    src = ./.;
    doCheck = false;
    cargoArtifacts = crane-lib.buildDepsOnly {
      src = ./.;
    };
  };
}
