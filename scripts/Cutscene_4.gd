extends Control

const MESSAGES = [
	"Congratulations! You've won. Roll Credits.",
	"A game by Michael Xue and Fearghal Reid",
	"Zeus sprite by Rin Munagala",
	"Chaos sprite by Evelyn Mitchell",
	"Hades sprite by Joe Mitchell",
	"Main menu music from The White Piano Key",
	"Battle music by Matt Solomon",
	"Thank you to Sylvia Hagen for helping with the code",
	"And thank you, for playing!",
]
const TYPING_SPEED = 0.05
const READ_TIME = 0.1
var current_message = 0
var display = ""
var current_char = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	start_dialogue()


func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	$next_char.set_wait_time(TYPING_SPEED)
	$next_char.start()


func stop_dialogue():
	$end.start()


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
		
func _on_next_message_timeout():
	if (current_message == len(MESSAGES) - 1):
		stop_dialogue()
	else:
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()


func _on_end_timeout():
	get_tree().change_scene_to_file("res://mainmenu.tscn")

