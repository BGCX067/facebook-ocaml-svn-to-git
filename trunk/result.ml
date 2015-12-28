(*
 *
 *  This file is part of Facebook-OCaml
 *
 *  Facebook-OCaml is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later 
 *  
 *  Facebook-OCaml is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with Facebook-OCaml. If not, see <http://www.gnu.org/licenses/>.
 *
 *  result.ml william le ferrand (william@themipsfactory.com) 19/04/2010 20:02
 *
 *)

open Misc
open Types

(* As usual you have the Utf8 issue looming sooo ahead; I suppose it won't work *)

exception Malformed 


let get_item label items = 
  List.find (function a -> a.label = label) items >>> (fun a -> a.attributes)

let get_attribute name attributes =
  List.find (function a -> a.name = name) attributes >>> (fun a -> a.value)
  
