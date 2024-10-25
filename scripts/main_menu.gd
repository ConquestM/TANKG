extends Control
@export var _theme: Theme
@export var default_theme: Theme

func _ready():
	global.boss_hp = 100
	global.boss_2_hp = 100
	global.boss_3_hp = 100
	sounds._main_menu_music()


# Takes the user to the furst  level and sets the boss Health.
func _on_button_pressed():
	global.boss_hp = global.boss_hp*global.boss_hp_mult
	global.boss_2_hp = global.boss_2_hp*global.boss_hp_mult
	global.boss_3_hp = global.boss_3_hp*global.boss_hp_mult
	global.hp = 15
	global.level = 1
	sounds._main_menu_exit()
	sounds._battle_music()
	get_tree().change_scene_to_file("res://cutscene_1.tscn")

# Closes the game.
func _on_button_quit():
	get_tree().quit()

# Takes the user to the settings screen/menu
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_timer_timeout():
	$CanvasLayer/WorldEnvironment.environment.glow_strength = randf() - 0.2
	$CanvasLayer/G.modulate.a = randf() - 0.2


func _on_play_1_mouse_entered():
	$CanvasLayer/Play1.theme = _theme


func _on_play_1_mouse_exited():
	$CanvasLayer/Play1.theme = default_theme


func _on_quit_mouse_entered():
	$CanvasLayer/Quit.theme = _theme


func _on_quit_mouse_exited():
	$CanvasLayer/Quit.theme = default_theme




func _on_settings_mouse_entered():
	$CanvasLayer/Settings.theme = _theme


func _on_settings_mouse_exited():
	$CanvasLayer/Settings.theme = default_theme
