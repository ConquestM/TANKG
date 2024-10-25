extends Control

@export var _theme: Theme
@export var default_theme: Theme
@export var volume_name: String
var volume_index: int
@onready var global = get_node("/root/global")
@onready var hslider = $CanvasLayer/HSlider
@onready var vslider = $CanvasLayer/Soundslider


# Sets the slider to the right values visually
func _ready():
	volume_index = AudioServer.get_bus_index(volume_name)
	hslider.value = global.boss_hp_mult
	vslider.value = db_to_linear(AudioServer.get_bus_volume_db(volume_index))


# Function that sets the boss health multiplier based off of the slider.
func _on_h_slider_value_changed(value):
	global.boss_hp_mult = value


# Returns to the main menu.
func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


# Makes the G flash and flicker
func _on_timer_timeout():
	$CanvasLayer/WorldEnvironment.environment.glow_strength = randf() - 0.2
	$CanvasLayer/G.modulate.a = randf() - 0.2


# Makes the text change font on hover
func _on_button_mouse_entered():
	$CanvasLayer/Button.theme = _theme


# Returns the text to the normal font
func _on_button_mouse_exited():
	$CanvasLayer/Button.theme = default_theme


# Makes the slider change the volume of the game
func _on_soundslider_value_changed(value):
	AudioServer.set_bus_volume_db(volume_index, linear_to_db(value))
