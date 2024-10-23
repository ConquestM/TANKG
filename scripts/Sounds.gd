extends Node
var main_menu = false
var battle = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main_menu == true and $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if battle == true and $AudioStreamPlayer2.playing == false:
		$AudioStreamPlayer2.play()
	


func _main_menu_music():
	main_menu = true


func _main_menu_exit():
	$AudioStreamPlayer.stop()
	main_menu = false


func _battle_music():
	battle = true


func _battle_end():
	$AudioStreamPlayer2.stop()
	battle = false
