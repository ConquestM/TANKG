extends Area2D
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if global.level == 1 and area.has_meta("Player") and active == true:
		get_tree().change_scene_to_file("res://Cutscene_2.tscn")
		global.level += 1


func _on_timer_timeout():
	active = true
