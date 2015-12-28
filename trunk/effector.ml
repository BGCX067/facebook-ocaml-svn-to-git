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
 *  effector.ml william le ferrand (william@themipsfactory.com) 19/04/2010 18:20
 *
 *)

open Misc
open Types

let send connection request = 
  let encoded_request = List.map (fun (k, v) -> encode k, encode v) request in
  let formatted_request = List.fold_left (fun acc (k,v) -> if acc = "" then Printf.sprintf "%s=%s" k v else Printf.sprintf "%s&%s=%s" acc k v) "" encoded_request in
  
    Printf.sprintf "http://%s%s?%s" connection.http_host connection.http_uri formatted_request >>>  Http_client.Convenience.http_get 
   
