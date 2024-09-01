extends Control

var messages = [
	"Chaos",
	"Primordial Void"
]
var typing_speed = 0.5
var read_time = 0.5
var current_message = 0
var display = ""
var current_char = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label2.hide()
	start_dialogue()

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	$next_char.set_wait_time(typing_speed)
	$next_char.start()
	
func stop_dialogue():
	$end.start()

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()
		
func _on_next_message_timeout():
	typing_speed = 0.1
	$next_char.set_wait_time(typing_speed)
	$Label.scale = Vector2.ONE*0.5
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else:
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()


func _on_end_timeout():
	get_tree().change_scene_to_file("res://Level2.tscn")
