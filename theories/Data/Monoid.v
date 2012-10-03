Require List.
Require Import ExtLib.Decidables.Decidable.

Set Implicit Arguments.
Set Maximal Implicit Insertion.

Section Monoid.
  Variable S : Type.

  Record Monoid (S : Type) : Type :=
  { monoid_plus : S -> S -> S
  ; monoid_unit : S
  }.

End Monoid.

(** Some Standard Instances **)
Definition Monoid_list_app T : Monoid (list T) :=
{| monoid_plus := @List.app _ 
 ; monoid_unit := @nil _
 |}.

Definition Monoid_list_union T (R : RelDec (@eq T)) : Monoid (list T) :=
{| monoid_plus := fix rec x y : list T :=
  match x with
    | nil => y
    | cons x xs =>
      if List.existsb (eq_dec x) y then rec xs y else rec xs (cons x y)
  end
 ; monoid_unit := @nil _
 |}.

Definition Monoid_nat_plus : Monoid nat :=
{| monoid_plus := plus
 ; monoid_unit := 0
 |}.

Definition Monoid_nat_mult : Monoid nat :=
{| monoid_plus := mult
 ; monoid_unit := 1
 |}.