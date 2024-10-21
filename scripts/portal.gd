extends Area2D
var active = false

# Called when the node enters the scene tree for the first time.
# Starts the Timer.
func _ready():
	$Timer.start()




# Takes the player to the next level, or the main menu if all levels are completed.
func _on_area_entered(area):
	if global.level == 1 and area.has_meta("Player") and active == true:
		global.level += 1
		get_tree().change_scene_to_file("res://Cutscene_2.tscn")
	elif global.level == 2 and area.has_meta("Player") and active == true:
		global.level += 1
		get_tree().change_scene_to_file("res://Level3.tscn")
	elif global.level == 3 and area.has_meta("Player") and active == true:
		get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_timer_timeout():
	active = true
