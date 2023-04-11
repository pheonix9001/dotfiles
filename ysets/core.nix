l: s:
with s;
with builtins;
let
  getAttrByPath = path: set:
    if length path == 0 then
      set
    else
      getAttrByPath (tail path) set.${elemAt path 0};
  getAttrByStrPath = path:
    getAttrByPath (filter (v: !(isList v)) (split "\\." path));
  listToShortStr = list:
    let longstr = concatStringsSep " " (map (v: toString v) list);
    in if stringLength longstr <= 80 then
      "[${longstr}]"
    else
      "[${substring 0 80 longstr}...]";

  genDocElem = { name, value, docstr }:
    if typeOf value == "set" then ''
      # ${name}
      elements: ${listToShortStr (attrNames value)}
      ${docstr}
    '' else if typeOf value == "list" then ''
      # ${name}: list ${
        if length value == 0 then "" else typeOf (elemAt value 0)
      }
      value: ${listToShortStr value}
      ${docstr}
    '' else ''
      # ${name}: ${typeOf value}
      value: ${value}
      ${docstr}
    '';
  genDocs = doc: cfg:
    concatStringsSep "\n" (l.set.mapToValues (n: v:
      genDocElem {
        value = getAttrByStrPath n cfg;
        name = n;
        docstr = v;
      }) doc);
in {
  doc.home = "Home directory of the user";
  home = "/home/default";

  doc.env = "The environment that is generated";
  doc."env.pkgs" = "The list of packages in the environment";
  env.pkgs = [ ];
  doc."env.syms" = "List of symlinks to create";
  env.syms = { };

  doc."switch-from-script" = "Script to switch from the configuration";
  switch-from-script = l.set.mapToValues (n: v: "rm ${n}") env.syms;

  doc."switch-to-script" = "Script to switch to the configuration";
  switch-to-script = l.set.mapToValues (n: v: "ln -sf ${v} ${n}") env.syms;

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
    cfg-doc = pkgs.writeTextFile {
      name = "config-docs";
      text = genDocs s.doc cfg;
      destination = "/config.md";
    };
  in s.pkgs.buildEnv {
    name = "dotfiles";
    paths = [ switch-to switch-from json-cfg cfg-doc ] ++ s.env.pkgs;
  };
  outputs.default = s.outputs.dotfiles;
}
