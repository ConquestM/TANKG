extends Node2D

var size = 0 
var big = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("/root/Map/Bossbody2") != null:
		global_position = (get_node("/root/Map/Bossbody2").global_position)
		rotation_degrees += 0.25


func _on_expand_timeout():
	if size >= 1 :
		big = 0
		print("change")
	if size <= -1  :
		big = 1
		print("change2")
	if big == 1 :
		scale.x += 0.1
		size += 0.1
	if big == 0 :
		scale.x -= 0.1
		size -= 0.1


func _on_area_2d_area_entered(area):
		if area.has_meta("Player"):
			global.HP -= 2
