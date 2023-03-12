l: s:
with s; {
  # Home directory of the user
  home = "/home/default";
  # List of packages in the user environment
  env.pkgs = { };
  # List of symlinks to create
  env.syms = { };

  # Script to switch from the configuration
  switch-from-script = l.foldl' (a: v: ''
    ${a}
    rm -rf ${v}
  '') "" (l.attrNames env.syms);

  # Script to switch to the configuration
  switch-to-script = l.foldl' (v: a: ''
    ${v}
    ${a}
  '') "" (l.mapAttrsToList (n: v: "ln -sf ${v} ${n}") env.syms);

  # The derivation of the dotfiles
  dotfiles-drv = let
    switch-to = pkgs.writeShellScriptBin "switch-to-config" switch-to-script;
    switch-from =
      pkgs.writeShellScriptBin "switch-from-config" switch-from-script;
    env-pkgs-list = l.attrValues env.pkgs;
    # A version of the configuration in json
    cfg = builtins.removeAttrs s [ "pkgs" "deps" "dotfiles-drv" ];
    json-cfg = pkgs.writeTextFile {
      name = "json-config";
      text = builtins.toJSON cfg;
      destination = "/config.json";
    };
  in s.pkgs.buildEnv {
    name = "dotfiles";
    paths = [ switch-to switch-from json-cfg ] ++ env-pkgs-list;
  };
}
