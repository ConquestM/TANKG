extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Function that sets the boss health multiplier based off of the slider.
func _on_h_slider_value_changed(value):
	global.boss_hp_mult = value
	print(value)

# Returns to the main menu.
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Mainmenu.tscn")
