extends Area2D
@export var megabullet_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 200
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves and rotates the bullet, also depsawns the bullet after enough time.
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	rotation_degrees += 6 * 100 * delta
	if despawn > 3000:
		queue_free()

# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()
