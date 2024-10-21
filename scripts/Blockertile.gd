extends CharacterBody2D

@export var speed = 100
var screen_size
var hp = 10
@onready var healthbar = $Healthbar
var health = hp : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	healthbar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_health(health)
	if hp < 0 or hp == 0:
		queue_free()

func _set_health(value):
	if healthbar != null:
		healthbar.health = hp

func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		hp -= 1
