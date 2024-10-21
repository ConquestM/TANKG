extends CharacterBody2D
@export var bullet_scene: PackedScene
@export var firetimer:Node
@export var speed = 100
var screen_size
var HP = 5
@onready var healthbar = $Healthbar
var health = HP : set = _set_health
var Attack = 0

# Occurs when the scene is loaded.
func _ready():
	# Starts the firetimer, the timer that tells the bllet to spawn.
	firetimer.start()
	# Sets the healthbar to the max health.
	healthbar.init_health(health)
	# Increases the global spirits variable by 1
	global.spirits += 1

	# Occurs every frame
func _process(_delta):
		# Makes the child, collisionshape 2D look at the player's global position.
		$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
		# Makes the health update the healthbar.
		_set_health(health)
		# Makes the position of the root to the position of the player.
		position = get_node("/root/Map/Player").global_position
		# Increases rotation.
		rotation_degrees += 1
		# kills the spawn when health is low. It also tells Boss2 that one spawn has died.
		if HP < 0 or HP == 0:
			# decreases the global spirits by 1. This allows the boss to know when to spawn more.
			global.spirits -= 1
			# 'kills' the spawn.
			queue_free()


func _set_health(value):
	if healthbar != null:
		healthbar.health = HP


# When the firetimer timeouts, a 'ghost-bullet' is spawned, in the spawn, with the rotation inherited.
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		Attack +=1
	else:
		Attack = 0
# Makes the spawn look to the left and right when on corrosponding sides by multiplying or setting the x-scale.
func _on_area_2d_area_entered(area):
	# The player has areas to its left and right that tell the spawn what direction to look.
	if area.has_meta("L"):
		print("L")
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x) * -1
	if area.has_meta("R"):
		print("R")
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x)
	if area.has_meta("Damage"):
		HP -= 1
