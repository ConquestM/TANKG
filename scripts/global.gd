extends Node
var back = 0
var hp = 15 : set = _iframes
var boss_hp = 100
var boss_2_hp = 100
var boss_3_hp = 100
var iframes = false
var timer
var level = 0
var spirits = 0
var zombies = 0
var boss_hp_mult = 1
var wall = 6 
var lightning = 0
var light = 1
var wall_attack = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _iframes(value):
	iframes = true
	timer = get_tree().create_timer(1)
	timer.connect("timeout", _timeout)
	hp = value
	
func _timeout():
	iframes = false
