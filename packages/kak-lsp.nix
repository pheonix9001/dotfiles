{
  nixpkgs,
  crane-lib,
  kak-lsp,
}: {
  kak-lsp = crane-lib.buildPackage {
    src = kak-lsp;
    doCheck = false;
  };
}
