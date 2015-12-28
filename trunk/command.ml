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
 *  command.ml william le ferrand (william@themipsfactory.com) 19/04/2010 20:02
 *
 *)

open Misc
open Types
open Result 


module UsersGetLoggedInUser =
  struct
    let raw_exec ?(format = "XML") connection session_key = 
      let request = [
	"format", format; 
	"call_id", Unix.gettimeofday () >>> int_of_float >>> string_of_int; 
	"api_key", connection.key ; 
	"method", "Users.getLoggedInUser"; 
	"v", "1.0" ;
	"session_key", session_key ] in 
	
      let signature = Authentication.sign connection request in 
 	("sig", signature) :: request  >>> Effector.send connection

  end
    
module UsersGetInfo =
  struct 

    let raw_exec connection ?(session_secret=None) ?(session_key = None) ?(format = "XML") uids fields = 
      
      let request = 
	("format", format) ::
	("call_id", Unix.gettimeofday () >>> int_of_float >>> string_of_int) ::
	("api_key", connection.key ) :: 
	("method", "Users.getInfo") ::
	("v", "1.0" ) ::
	("uids", uids ) :: 
	("fields", fields) :: (match session_key with None -> [] |  Some key -> [ "session_key", key ]) in 
	
	match session_secret with 
	    None -> 
	      let signature = Authentication.sign connection request in 
 		("sig", signature) :: request  >>> Effector.send connection
	  | Some secret -> 
	      let request = ("ss", "true") :: request in
	      let signature = Authentication.sign ({ connection with secret = secret }) request in 
 		("sig", signature) :: request  >>> Effector.send connection
	  
    let split_result result = 
      match Xml.parse_string result with
	  Xml.Element (_, _, users_list) -> 
	    users_list
	| _ -> raise Malformed 
 
    let extract result = 
      let users_list = split_result result in 
	List.map (function 
		      Xml.Element ("user", _, attributes) -> 
			let attributes = List.map (function Xml.Element (name,_, Xml.PCData (value) :: _) -> { name = name; value = value } | _ -> raise Malformed) attributes in
			let uid = List.find (fun a -> a.name = "uid") attributes >>> (fun a -> a.value) in
			  { label = uid ; attributes = attributes }
		    | _ -> raise Malformed) users_list 
	  
    let exec connection ?(session_secret=None) ?(session_key = None) ?(format = "XML") uids fields = 
      let raw_data = raw_exec connection ~session_secret:session_secret ~session_key:session_key ~format:format uids fields in 
	display "@@@ Details: %s\n" raw_data ;
	raw_data >>> extract 
  end


module StreamPublish = 
struct 
  let raw_exec connection ?(session_secret=None) ?(session_key = None) ?(format = "XML") uid message attachment action_links = 
    debug "@@@ Attachment: %s\n" attachment; 
    let request = 
      ("format", format) ::
	("call_id", Unix.gettimeofday () >>> int_of_float >>> string_of_int) ::
	("api_key", connection.key ) :: 
	("method", "Stream.publish") ::
	("v", "1.0" ) ::


	("message", message) ::  
	("attachment", attachment) :: 
	("action_links", action_links) :: 
	("uid" , uid ) ::


	(match session_key with None -> [] |  Some key -> [ "session_key", key ]) in 
      
      match session_secret with 
	  None -> 
	    let signature = Authentication.sign connection request in 
 	      ("sig", signature) :: request  >>> Effector.send connection
	| Some secret -> 
	    let request = ("ss", "true") :: request in
	    let signature = Authentication.sign ({ connection with secret = secret }) request in 
 	      ("sig", signature) :: request  >>> Effector.send connection

  let exec connection ?(session_secret=None) ?(session_key = None) ?(format = "XML") uid message attachment action_links = 
    raw_exec connection ~session_secret:session_secret ~session_key:session_key ~format:format uid message attachment action_links >>> display "@@@ %s\n" 
end
