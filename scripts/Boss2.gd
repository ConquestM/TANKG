extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var bullet_scene: PackedScene
@export var bullethell_scene: PackedScene
@export var bullethell2_scene: PackedScene
@export var teleport_scene: PackedScene
@export var line_scene: PackedScene
@export var firetimer:Node
@onready var healthbar = $CanvasLayer/Healthbar
var health = global.boss2hp : set = _set_health
var Attack = 0

func _ready():
	firetimer.start()
	healthbar.init_health(health)
	global.wall = 6 

# Makes the boss look at the player, for attack purposes.
# Also despawns the boss when health is low and plays the animated sprite.
func _process(_delta):
	_set_health(health)
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.boss2hp <= 0:
		queue_free()
	$AnimatedSprite2D.play("default")

# Function for the Attacks
# 1. Spawns the lines that rotate.
func _on_firetimer_timeout():
	if global.wall > 1 :
		for i in 3:
			var line = line_scene.instantiate()
			line.rotation_degrees = $CollisionShape2D.rotation_degrees -(120)*(i-1)
			add_sibling(line)aw
			global.wall = 0
# Spawns the continous waves of bullets.
	if Attack < 3:
		for i in 36:
			var bullethell = bullethell_scene.instantiate()
			bullethell.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			bullethell.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
			add_sibling(bullethell)
		Attack +=1
		$CollisionShape2D/Firetimer.start()
		global.back = 0
# Spawns the reverse bullets when below a certain health value.
		if global.boss2hp <= 51 * global.bosshpmult:
			for i in 36:
				var bullethell2 = bullethell2_scene.instantiate()
				bullethell2.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
				bullethell2.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
				add_sibling(bullethell2)
# Spawns the bullet that leads to the *black* circle to spawn.
	else:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		Attack =0
		global.back = 1


func _set_health(value):
	if healthbar != null:
		healthbar.health = global.boss2hp
