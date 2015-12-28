 #
 #
 #  This file is part of Facebook-OCaml
 #
 #  Facebook-OCaml is free software: you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation, either version 3 of the License, or
 #  (at your option) any later 
 #  
 #  Facebook-OCaml is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU General Public License for more details.
 #  
 #  You should have received a copy of the GNU General Public License
 #  along with Facebook-OCaml. If not, see <http://www.gnu.org/licenses/>.
 #
 #  Makefile william le ferrand (william@themipsfactory.com) 19/03/2010 20:19
 #
 #

all:
	ocamlbuild fb.cma

install:
	ocamlfind install fb META _build/fb.cma _build/fb.cmi 

remove: 
	ocamlfind remove fb

tt: 
	ocamlbuild test.byte

clean:
	ocamlbuild -clean


