extends SceneTree
class_name Lox


func _init() -> void:
	var args = OS.get_cmdline_user_args()
	print(args)

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


func run_prompt() -> void:
	print("Running prompt...")
	while true:
		var line = OS.read_string_from_stdin().strip_edges()
		if line.length() > 0:
			run(line)
		else:
			OS.delay_msec(100)


func run(source: String) -> void:
	print(source)
