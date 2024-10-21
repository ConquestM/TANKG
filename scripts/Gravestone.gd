extends CharacterBody2D

@export var speed = 100
var screen_size
var hp = 50
@onready var healthbar = $Healthbar
var health = hp : set = _set_health


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	healthbar.init_health(health)
	rotation = 0
	$Death.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_health(health)
	rotation = 0
	if global.bosshp == 0:
		queue_free()
	if hp < 0 or hp == 0:
		queue_free()


func _set_health(value):
	if healthbar != null:
		healthbar.health = hp


func _on_death_timeout():
	hp -= 1
	$Death.start()

