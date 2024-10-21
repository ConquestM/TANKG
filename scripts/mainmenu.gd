extends Control
@onready var global = get_node("/root/global")


func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Takes the user to the furst  level and sets the boss Health.
func _on_button_pressed():
	global.BossHP = global.BossHP*global.BossHPMult
	global.Boss2HP = global.Boss2HP*global.BossHPMult
	global.Boss3HP = global.Boss3HP*global.BossHPMult
	global.HP = 15
	global.level = 1
	get_tree().change_scene_to_file("res://Cutscene_1.tscn")

# Closes the game.
func _on_button_quit():
	get_tree().quit()

# Takes the user to the second  level and sets the boss Health.
func _on_level_2_pressed():
	global.BossHP = global.BossHP*global.BossHPMult
	global.Boss2HP = global.Boss2HP*global.BossHPMult
	global.Boss3HP = global.Boss3HP*global.BossHPMult
	global.HP = 15
	global.level = 2
	get_tree().change_scene_to_file("res://Cutscene_2.tscn")

# Takes the user to the third level and sets the boss Health.
func _on_level_3_pressed():
	global.BossHP = global.BossHP*global.BossHPMult
	global.Boss2HP = global.Boss2HP*global.BossHPMult
	global.Boss3HP = global.Boss3HP*global.BossHPMult
	global.HP = 15
	global.level = 3
	get_tree().change_scene_to_file("res://Level3.tscn")

# Takes the user to the settings screen/menu
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Settings.tscn")
