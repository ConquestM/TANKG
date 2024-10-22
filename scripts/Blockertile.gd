extends CharacterBody2D

@export var speed = 100
var screen_size
var hp = 10
@onready var health_bar = $Healthbar
var health = hp : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	health_bar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_health(health)
	if hp < 0 or hp == 0:
		queue_free()

func _set_health(value):
	if health_bar != null:
		health_bar.health = hp

func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		hp -= 1
