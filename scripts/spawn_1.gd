extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var fire_timer:Node
@export var speed = 100
var hp = 5
var health = hp : set = _set_health
var Attack = 0
@onready var health_bar = $Healthbar


# Occurs when the scene is loaded.
func _ready():
	# Starts the firetimer, the timer that tells the bllet to spawn.
	$CollisionShape2D/Firetimer.start()
	# Sets the healthbar to the max health.
	health_bar.init_health(health)
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
		if hp < 0 or hp == 0:
			# decreases the global spirits by 1. This allows the boss to know when to spawn more.
			global.spirits -= 1
			# 'kills' the spawn.
			queue_free()

# Updates the health.
func _set_health(_value):
	if health_bar != null:
		health_bar.health = hp


# When the firetimer timeouts, a 'ghost-bullet' is spawned, in the spawn, with the rotation inherited.
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		$CollisionShape2D/Firetimer.start()
		Attack +=1
	else:
		Attack = 0


# Makes the spawn look to the left and right when on corrosponding sides by multiplying or setting the x-scale.
func _on_area_2d_area_entered(area):
	# The player has areas to its left and right that tell the spawn what direction to look.
	if area.has_meta("L"):
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x) * -1
	if area.has_meta("R"):
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x)
	if area.has_meta("Damage"):
		hp -= 1

