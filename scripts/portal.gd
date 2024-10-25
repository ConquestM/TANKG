extends Area2D

var active = false

# Called when the node enters the scene tree for the first time.
# Starts the Timer.
func _ready():
	$Timer.start()

# Plays the animation 
func _process(_delta):
	$AnimatedSprite2D.play("default")


# Takes the player to the next level, or the main menu if all levels are completed.
func _on_area_entered(area):
	global.hp = 15
	if global.level == 1 and area.has_meta("Player") and active == true:
		global.level += 1
		get_tree().change_scene_to_file("res://cutscene_2.tscn")
	elif global.level == 2 and area.has_meta("Player") and active == true:
		global.level += 1
		get_tree().change_scene_to_file("res://cutscene_3.tscn")
	elif global.level == 3 and area.has_meta("Player") and active == true:
		get_tree().change_scene_to_file("res://cutscene_4.tscn")


# Makes the portal active.
func _on_timer_timeout():
	active = true
