class_name Token

# These are constants, but godot doesnt allow uninitialized contants
# so we will use the dynamic language approach of constant by convention
# and give them ALL CAPS names
var TYPE: TokenType.Type
var LEXEME: String
var LITERAL: Variant
var LINE: int


func _init(type: TokenType.Type, lexeme: String, literal: Variant, line: int) -> void:
	TYPE = type
	LEXEME = lexeme
	LITERAL = literal
	LINE = line


func _to_string() -> String:
	return "%s %s %s" % [TYPE, LEXEME, LITERAL]
