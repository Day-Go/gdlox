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


func run_file(file_name: String) -> int:
	print("Running %s..." % file_name)
	return 0


func run_prompt() -> int:
	print("Running prompt...")
	return 0
