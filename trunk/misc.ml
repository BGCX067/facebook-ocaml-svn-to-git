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
 *  misc.ml william le ferrand (william@themipsfactory.com) 19/04/2010 20:02
 *
 *)

let (>>>) f g = g f

let debug fmt = 
  Printf.ksprintf (fun s -> print_string s; flush stdout) fmt

let display fmt = 
  Printf.ksprintf (fun s -> print_string s; flush stdout) fmt

(* Suboptimal dirty encoding function *)
let encode str = 
  
  let strlist = ref [] in 
    
  for i = 0 to String.length str - 1 do 
    let c = Char.code (str.[i]) in 
      if (65 <= c && c <= 90) || (48 <= c && c <= 57 ) || (97 <= c && c <= 122) || (c = 126) || (c = 95) || (c = 46) || (c = 45) then  
	strlist := Printf.sprintf "%c" str.[i] :: !strlist 
      else 
	strlist := Printf.sprintf "%%%X" c :: !strlist 
  done ;
    String.concat "" (List.rev !strlist) 

let encodeplus = 
  Netencoding.Url.encode 

let decodeplus = 
  Netencoding.Url.decode 

let current_timestamp () = 
  let tm = Unix.gmtime (Unix.time ()) in
    Printf.sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ" (1900 + tm.Unix.tm_year) (1 + tm.Unix.tm_mon) tm.Unix.tm_mday tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec
  
 
let expiration delay = 
    let tm = Unix.gmtime (Unix.time () +. delay) in
    Printf.sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ" (1900 + tm.Unix.tm_year) (1 + tm.Unix.tm_mon) tm.Unix.tm_mday tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec
  
