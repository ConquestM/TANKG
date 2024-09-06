extends Node
var back = 0
var HP = 15 : set = _iframes
var BossHP = 50
var iframes = false
var timer
var level = 0

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
	HP = value
	
func _timeout():
	iframes = false
