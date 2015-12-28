(*
 *
 *  This file is part of Fb-OCaml
 *
 *  Fb-OCaml is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later 
 *  
 *  Fb-OCaml is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with Fb-OCaml. If not, see <http://www.gnu.org/licenses/>.
 *
 *  connection.ml william le ferrand (william@themipsfactory.com) 26/03/2010 09:26
 *
 *)

open Types

let create key secret = 
  {
    http_host = "api.facebook.com" ;
    http_uri = "/restserver.php" ; 
    key = key; 
    secret = secret;
  }

