extends Control
@onready var global = get_node("/root/global")
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_pressed():
	global.HP = 15
	get_tree().change_scene_to_file("res://Cutscene_1.tscn")


func _on_button_quit():
	get_tree().quit()


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Level2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Level3.tscn")
