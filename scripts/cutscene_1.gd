extends Control

const MESSAGES = [
	"Zeus",
]
const TYPING_SPEED = 0.25
const READ_TIME = 0.5
var current_message = 0
var display = ""
var current_char = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label2.hide()
	start_dialogue()

# Sets the data needed for the cutscene
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	$next_char.set_wait_time(TYPING_SPEED)
	$next_char.start()


# Starts the timer to end the cutscene.
func stop_dialogue():
	$end.start()


# Types the next character in the message
func _on_next_char_timeout():
	if (current_char < len(MESSAGES[current_message])):
		var next_char = MESSAGES[current_message][current_char]
		display += next_char
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(READ_TIME)
		$next_message.start()


# Goes to the next message
func _on_next_message_timeout():
	$Label2.show()
	if (current_message == len(MESSAGES) - 1):
		stop_dialogue()
	else:
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()


# Ends the cutscene
func _on_end_timeout():
	get_tree().change_scene_to_file("res://level.tscn")
