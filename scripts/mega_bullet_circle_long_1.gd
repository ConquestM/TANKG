extends Area2D

@export var mega_bullet_scene: PackedScene
var speed = 100
var despawn = 0
var friendly = false
@onready var global = get_node("/root/global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves and rotates the bullet, also depsawns the bullet after enough time.
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	rotation_degrees += 1
	if despawn > 3000:
		queue_free()


# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()

