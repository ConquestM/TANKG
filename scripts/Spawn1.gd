extends CharacterBody2D
@export var bullet_scene: PackedScene
@export var firetimer:Node
@export var speed = 100
var screen_size
var HP = 10
@onready var healthbar = $Healthbar
var health = HP : set = _set_health
var Attack = 0
func _ready():
	firetimer.start()
	healthbar.init_health(health)
	
func _process(_delta):
		_set_health(health)
		$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
		if HP < 0 or HP == 0:
			queue_free()


func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack +=1
	else:
		Attack = 0
func _set_health(value):
	if healthbar != null:
		healthbar.health = HP
func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		HP -= 1
