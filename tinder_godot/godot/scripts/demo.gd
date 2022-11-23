extends Control

onready var server_connection: Node = get_node("ServerConnection")

func _ready() -> void:
	yield(
		request_authentication(),
		"completed"
	)
	
	
func request_authentication() -> void:
	var email: String = "test@gmail.com"
	var password: String = "password"
	
	print_debug(
		"Authenticating user %s." % email
	)
	
	var result: int = yield(server_connection.authenticate_async(email, password), "completed")
	
	if result == OK:
		print_debug(
			"Authenticated user %s successfully." % email
		)
		
		return
		
	print_debug(
		"Couldn't authenticate user %s." % email
	)
