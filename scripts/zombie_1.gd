extends CharacterBody2D

@export var grave_scene : PackedScene
var direction = 0
var speed = 50
var despawn = 0
var mega_bullet
var home = 1
var friendly = false
@onready var global = get_node("/root/global")

# Reduces the zombies that the boss can spawn by 1
func _ready():
	global.zombies -=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Makes the zombie home towards the player.
func _process(delta):
	if global.boss_3_hp == 0:
		queue_free()
	if home == 1:
		move_local_x(speed * delta)
		direction = (get_node("/root/Map/Player").global_position - global_position)
		var targetRotation = direction.angle()
		rotation = lerp_angle(rotation, targetRotation, 10 * delta)
	else:
		move_local_x(speed * delta * 3)


# Damage function for the player.
func _on_area_2d_2_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true


# Once the timer finishes, the zombie will despawn and spawn a gravestone.
func _on_die_timeout():
	var grave = grave_scene.instantiate()
	grave.global_position = global_position
	add_sibling(grave)
	queue_free()

