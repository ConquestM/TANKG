extends CharacterBody2D

@export var speed = 100
var screen_size
var HP = 50
@onready var healthbar = $Healthbar
var health = HP : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	healthbar.init_health(health)
	$Death.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_health(health)
	if HP < 0 or HP == 0:
		queue_free()

func _set_health(value):
	if healthbar != null:
		healthbar.health = HP


func _on_death_timeout():
	HP -= 1
	$Death.start()