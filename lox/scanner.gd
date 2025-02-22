class_name Scanner

const TT = TokenType.Type

var SOURCE: String
var TOKENS: Array[Token] = []
var start: int = 0
var current: int = 0
var line: int = 1

var keywords: Dictionary = {
	"and": TT.AND,
	"class": TT.CLASS,
	"else": TT.ELSE,
	"false": TT.FALSE,
	"for": TT.FOR,
	"fun": TT.FUN,
	"if": TT.IF,
	"nil": TT.NIL,
	"or": TT.OR,
	"print": TT.PRINT,
	"return": TT.RETURN,
	"super": TT.SUPER,
	"this": TT.THIS,
	"true": TT.TRUE,
	"var": TT.VAR,
	"while": TT.WHILE
}


func _init(source: String) -> void:
	SOURCE = source


func scan_tokens() -> Array[Token]:
	print(SOURCE)
	while !is_at_end():
		start = current
		scan_token()

	var token := Token.new(TT.EOF, "", null, line)
	TOKENS.append(token)
	return TOKENS


func scan_token() -> void:
	var c = advance()
	print(c)
	match c:
		"(":
			add_token(TT.LEFT_PAREN)
		")":
			add_token(TT.RIGHT_PAREN)
		"{":
			add_token(TT.LEFT_BRACE)
		"}":
			add_token(TT.RIGHT_BRACE)
		",":
			add_token(TT.COMMA)
		".":
			add_token(TT.DOT)
		"-":
			add_token(TT.MINUS)
		"+":
			add_token(TT.PLUS)
		";":
			add_token(TT.SEMICOLON)
		"*":
			add_token(TT.STAR)
		"!":
			add_token(TT.BANG_EQUAL if match("=") else TokenType.Type.BANG)
		"=":
			add_token(TT.EQUAL_EQUAL if match("=") else TokenType.Type.EQUAL)
		"<":
			add_token(TT.LESS_EQUAL if match("=") else TokenType.Type.LESS)
		">":
			add_token(TT.GREATER_EQUAL if match("=") else TokenType.Type.GREATER)
		"/":
			if match("/"):
				while peek() != "\n" and !is_at_end():
					advance()
			else:
				add_token(TT.SLASH)
		" ":
			pass
		"\r":
			pass
		"\t":
			pass
		"\n":
			line += 1
		'"':
			string()
		_:
			if c.is_valid_int():
				number()
			elif is_alpha(c):
				identifier()
			else:
				Lox.error(line, "Unexpected character.")


func identifier() -> void:
	while is_alpha_numeric(peek()):
		advance()

	var text: String = SOURCE.substr(start, current - start)
	var type = keywords.get(text)
	if type == null:
		type = TT.IDENTIFIER

	add_token(type)


func string() -> void:
	while peek() != '"' and !is_at_end():
		if peek() == "\n":
			line += 1
		advance()

	if is_at_end():
		Lox.error(line, "Unterminated string.")
		return

	advance()

	var value: String = SOURCE.substr(start + 1, current - start - 2)
	add_token_literal(TT.STRING, value)


func number() -> void:
	while peek().is_valid_int():
		advance()

	if peek() == "." and peek_next().is_valid_int():
		advance()

		while peek().is_valid_int():
			advance()

	add_token_literal(TT.NUMBER, SOURCE.substr(start, current - start) as float)


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


func peek_next() -> String:
	if (current + 1) >= SOURCE.length():
		return char(0)
	return SOURCE[current + 1]


func is_alpha(c: String) -> bool:
	return (c >= "a" and c <= "z") or (c >= "A" and c <= "Z") or c == "_"


func is_alpha_numeric(c: String) -> bool:
	print("Checking if alpha numeric: %s" % c)
	return is_alpha(c) or c.is_valid_int()


func advance() -> String:
	var c: String = SOURCE[current]
	current += 1
	return c


func add_token(type: TT) -> void:
	add_token_literal(type, null)


func add_token_literal(type: TT, literal: Variant) -> void:
	var text: String = SOURCE.substr(start, current - start)
	var token := Token.new(type, text, literal, line)
	TOKENS.append(token)


func is_at_end() -> bool:
	return current >= SOURCE.length()
