extends Node

var main_menu = false
var battle = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Changes the music based on the scene.
func _process(delta):
	if main_menu == true and $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	if battle == true and $AudioStreamPlayer2.playing == false:
		$AudioStreamPlayer2.play()


# Sets the main menu variable.
func _main_menu_music():
	main_menu = true


# Stops the main menu music.
func _main_menu_exit():
	$AudioStreamPlayer.stop()
	main_menu = false


# Sets the battle variable.  
func _battle_music():
	battle = true


# STops the battle music.
func _battle_end():
	$AudioStreamPlayer2.stop()
	battle = false

