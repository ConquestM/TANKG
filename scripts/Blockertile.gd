extends CharacterBody2D

@export var speed = 100
var screen_size
@export var bullet_scene: PackedScene
var can_shoot = true
var dashing = false
var dash_duration = 0.1
var dash_timer = 0
var can_dash = true
var direction = 0
var vert_direction = 0
var saved_direction = 0
var saved_vert_direction = 0
var HP = 10
@onready var healthbar = $Healthbar
var health = global.HP : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	healthbar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	_set_health(health)
	if HP < 0 or HP == 0:
		queue_free()

func _set_health(value):
	if healthbar != null:
		healthbar.health = HP
		

func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		HP -= 1
