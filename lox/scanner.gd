class_name Scanner

var SOURCE: String
var TOKENS: Array[Token] = []
var start: int = 0
var current: int = 0
var line: int = 1


func _init(source: String) -> void:
	SOURCE = source


func scan_tokens() -> Array[Token]:
	while !is_at_end():
		start = current
		scan_token()

	var token := Token.new(TokenType.Type.EOF, "", null, line)
	TOKENS.append(token)
	return TOKENS


func scan_token() -> void:
	var c = advance()
	match c:
		"(":
			add_token(TokenType.Type.LEFT_PAREN)
		")":
			add_token(TokenType.Type.RIGHT_PAREN)
		"{":
			add_token(TokenType.Type.LEFT_BRACE)
		"}":
			add_token(TokenType.Type.RIGHT_BRACE)
		",":
			add_token(TokenType.Type.COMMA)
		".":
			add_token(TokenType.Type.DOT)
		"-":
			add_token(TokenType.Type.MINUS)
		"+":
			add_token(TokenType.Type.PLUS)
		";":
			add_token(TokenType.Type.SEMICOLON)
		"*":
			add_token(TokenType.Type.STAR)
		"!":
			add_token(TokenType.Type.BANG_EQUAL if match("=") else TokenType.Type.BANG)
		"=":
			add_token(TokenType.Type.EQUAL_EQUAL if match("=") else TokenType.Type.EQUAL)
		"<":
			add_token(TokenType.Type.LESS_EQUAL if match("=") else TokenType.Type.LESS)
		">":
			add_token(TokenType.Type.GREATER_EQUAL if match("=") else TokenType.Type.GREATER)
		"/":
			if match("/"):
				while peek() != "\n" and !is_at_end():
					advance()
			else:
				add_token(TokenType.Type.SLASH)
		_:
			Lox.error(line, "Unexpected character.")


func match(expected: String) -> bool:
	if is_at_end():
		return false
	if SOURCE[current] != expected:
		return false

	current += 1
	return true


func peek() -> String:
	if is_at_end():
		return char(0)
	return SOURCE[current]


func advance() -> String:
	current += 1
	return SOURCE[current]


func add_token(type: TokenType.Type) -> void:
	add_token_literal(type, null)


func add_token_literal(type: TokenType.Type, literal: Object) -> void:
	var text: String = SOURCE.substr(start, current)
	var token := Token.new(type, text, literal, line)
	TOKENS.append(token)


func is_at_end() -> bool:
	return current >= SOURCE.length()
