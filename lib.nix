{ lib }:
with lib; rec {
  # The Y combinator
  Y = f: f (Y f);

  # Recursive merge
  #
  # If x and y are attrs, do a recursive update
  # If x and y are lists, concatenate them
  # Else pick y
  recMerge = with builtins;
    x: y:
    if all isAttrs [ x y ] then
      zipAttrsWith (name: foldl' recMerge null) [ x y ]
    else if all isList [ x y ] then
      x ++ y
    else
      y;

  # A yset is a set defined with the Y combinator. Thus it can refer to itself
  #
  # eg = s: {a = s.b + 12; b = 12;}
  #
  # To evaluate a yset, you pass it into the Y combinator
  #
  # Y eg
  # -> {a = 24; b = 12;}

  mkY = x: s: x;

  # Extend a yset with a normal set
  y_ext = x: y: s: recMerge (x s) y;

  # Extend a yset with another yset
  y_add = x: y: s: recMerge (x s) (y s);

  # Fold a list of ysets into one
  y_fold = l: builtins.foldl' y_add (s: { }) l;
}
