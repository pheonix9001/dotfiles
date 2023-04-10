l: s: {
  scripts-drv = builtins.derivation {
    name = "dotfile-scripts";
    system = s.system;
    src = ./.;
    builder = "${s.pkgs.dash}/bin/dash";
    args = [./builder.sh];

	busybox = [s.pkgs.busybox];
    keyboards = "";
  };
  env.syms."~/.scripts" = s.scripts-drv;
}
