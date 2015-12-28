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
 *  types.ml william le ferrand (william@themipsfactory.com) 19/04/2010 20:02
 *
 *)

type connection = 
    { 
      http_host : string ; 
      http_uri : string ; 
      key : string ;
      secret : string ; 
    }

type attribute = { name : string; value : string }

type item = { label: string ; attributes : attribute list }

exception Error of string 
