extends CharacterBody2D

@export var speed = 100
var hp = 50
var health = hp : set = _set_health
@onready var health_bar = $Healthbar


# Called when the node enters the scene tree for the first time.\
# sets the rotation to 0 and the variables for health.
# Begins the timer for decaying.
func _ready():
	health_bar.init_health(health)
	rotation = 0
	$Death.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.\
# Sets the rotation to 0, updates health, and despawns on certain conditions.
func _process(_delta):
	_set_health(health)
	rotation = 0
	if global.boss_3_hp == 0:
		queue_free()
	if hp < 0 or hp == 0:
		queue_free()


# updates the health.
func _set_health(_value):
	if health_bar != null:
		health_bar.health = hp


# The decay of the gravestone.
func _on_death_timeout():
	hp -= 1
	$Death.start()

