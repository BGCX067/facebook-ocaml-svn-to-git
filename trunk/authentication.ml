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
 *  authentication.ml william le ferrand (william@themipsfactory.com) 19/04/2010 20:02
 *
 *)

open Misc  
open Types
 
let sign connection request = 
  let sorted_attributes = List.sort (fun (k1, v1)  (k2, v2) -> String.compare k1 k2) request in

  let raw_request = List.fold_left (fun acc (k,v) -> 
				      Printf.sprintf "%s%s=%s" acc k v) "" sorted_attributes in
    
    let hasher = Cryptokit.Hash.md5 () in
    let encoder = Cryptokit.Hexa.encode () in
    let req = raw_request ^ connection.secret in
      Cryptokit.hash_string hasher req >>> Cryptokit.transform_string encoder >>> String.lowercase 
      
        
      
	    
  
 
