open! Base
open Hardcaml

module I : sig
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; valid : 'a
    }
  [@@deriving hardcaml]
end

module O : sig
  type 'a t = { count : 'a } [@@deriving hardcaml]
end

val create : Scope.t -> Signal.t I.t -> Signal.t O.t
val hierarchical : Scope.t -> Signal.t I.t -> Signal.t O.t
