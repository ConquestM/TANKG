extends Control
@onready var global = get_node("/root/global")
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_pressed():
	global.BossHP = global.BossHP*global.BossHPMult
	global.Boss2HP = global.Boss2HP*global.BossHPMult
	global.Boss3HP = global.Boss3HP*global.BossHPMult
	global.HP = 15
	get_tree().change_scene_to_file("res://Cutscene_1.tscn")


func _on_button_quit():
	get_tree().quit()


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Cutscene_2.tscn")
	global.level = 2

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Level3.tscn")
	global.level = 3

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Settings.tscn")
	
