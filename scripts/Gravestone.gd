extends CharacterBody2D

@export var speed = 100
var screen_size
var hp = 50
@onready var health_bar = $Healthbar
var health = hp : set = _set_health


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	health_bar.init_health(health)
	rotation = 0
	$Death.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_set_health(health)
	rotation = 0
	if global.boss_3_hp == 0:
		queue_free()
	if hp < 0 or hp == 0:
		queue_free()


func _set_health(_value):
	if health_bar != null:
		health_bar.health = hp


func _on_death_timeout():
	hp -= 1
	$Death.start()

