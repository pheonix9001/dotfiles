l: s:
with s;
with builtins; {
  # Home directory of the user
  home = "/home/default";
  # List of packages in the user environment
  env.pkgs = [ ];
  # List of symlinks to create
  env.syms = { };

  # Script to switch from the configuration
  switch-from-script = l.set.mapToValues (n: v: "rm ${n}") env.syms;

  # Script to switch to the configuration
  switch-to-script = l.set.mapToValues (n: v: "ln -sf  ${v} ${n}") env.syms;

  # The derivation of the dotfiles
  outputs.dotfiles = let
    switch-to = pkgs.writeShellScriptBin "switch-to-config"
      (concatStringsSep "\n" switch-to-script);
    switch-from = pkgs.writeShellScriptBin "switch-from-config"
      (concatStringsSep "\n" switch-from-script);

    # A version of the configuration in json
    cfg = removeAttrs s [ "pkgs" "deps" "outputs" ];
    json-cfg = pkgs.writeTextFile {
      name = "json-config";
      text = toJSON cfg;
      destination = "/config.json";
    };
  in s.pkgs.buildEnv {
    name = "dotfiles";
    paths = [ switch-to switch-from json-cfg ] ++ s.env.pkgs;
  };
  outputs.default = s.outputs.dotfiles;
}
