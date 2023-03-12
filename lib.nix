{ lib }:
with lib; {
  # The Y combinator
  Y = f: f (Y f);

  # A set that is empty unless cond is true
  only_if = cond: set: if cond then set else { };

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
  y_ext = x: y: s: recursiveUpdate (x s) y;

  # Extend a yset with another yset
  y_add = x: y: s: recursiveUpdate (x s) (y s);

  # Fold a list of ysets into one
  y_fold = l: foldl' y_add (s: {}) l;
}
