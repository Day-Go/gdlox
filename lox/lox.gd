extends SceneTree
class_name Lox

static var had_error: bool = false


func _init() -> void:
	var args = OS.get_cmdline_user_args()

	main(args)


func main(args: Array[String]) -> void:
	if args.size() > 1:
		push_error("Usage: gdlox [script]")
		quit()
	elif args.size() == 1:
		run_file(args[0])
	else:
		run_prompt()


func run_file(path: String) -> void:
	print("Running %s..." % path)
	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(path)
	run(bytes.get_string_from_utf8())

	if had_error:
		quit()
	quit()


func run_prompt() -> void:
	print("Running prompt...")
	while true:
		var line = OS.read_string_from_stdin().strip_edges()
		if line.length() > 0:
			run(line)
			had_error = false
		else:
			OS.delay_msec(100)


func run(source: String) -> void:
	var scanner := Scanner.new(source)
	var tokens: Array[Token] = scanner.scan_tokens()

	for token in tokens:
		print(token)


static func error(line: int, message: String) -> void:
	report(line, "", message)


static func report(line: int, where: String, message: String) -> void:
	push_error("[line %s] Error %s: %s" % [line, where, message])
	had_error = true
