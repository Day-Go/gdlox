#### 1. Find the lexer and parser used for gdscript. Are they handwritten or generated using tools?
Lexer - https://github.com/godotengine/godot/blob/master/modules/gdscript/gdscript_tokenizer.cpp &
Parser - https://github.com/godotengine/godot/blob/master/modules/gdscript/gdscript_parser.h

Both written by hand in c++


#### 2. What reasons are there not to do JIT compilation when implementing a dynamically typed language?
Not sure rn


#### 3. Lisp implementations that compile to C also have an interpreter that lets them run on the fly. Why?
First guess is to be able to run a REPL
