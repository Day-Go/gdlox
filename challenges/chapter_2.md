#### 1. Find the lexer and parser used for gdscript. Are they handwritten or generated using tools?
Lexer - https://github.com/godotengine/godot/blob/master/modules/gdscript/gdscript_tokenizer.cpp &
Parser - https://github.com/godotengine/godot/blob/master/modules/gdscript/gdscript_parser.cpp

Both written by hand in c++


#### 2. What reasons are there not to do JIT compilation when implementing a dynamically typed language?
JIT compilation adds complexity to the compilation process and needs to be constantly maintained as new architectures are released.

from solutions: bytecode is more compact which is important in embedded devices & some platforms prohibit runtime code-gen

#### 3. Lisp implementations that compile to C also have an interpreter that lets them run on the fly. Why?
First guess is to be able to run a REPL. 

wrong - compile time macros where code needs to be evaluated while compiling.
