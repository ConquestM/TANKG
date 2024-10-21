extends Node
var back = 0
var hp = 15 : set = _iframes
var bosshp = 100
var boss2hp = 100
var boss3hp = 100
var iframes = false
var timer
var level = 0
var spirits = 0
var zombies = 0
var bosshpmult = 1
var wall = 6 
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
