extends Area2D
@export var megabullet_scene: PackedScene
@onready var global = get_node("/root/global")

const SPEED = 200
const ROTAION_CHANGE = 600
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves and rotates the bullet, also depsawns the bullet after enough time.
func _process(delta):
	move_local_x(SPEED * delta)
	despawn += 1
	rotation_degrees += ROTAION_CHANGE * delta
	if despawn > 3000:
		queue_free()


# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()

