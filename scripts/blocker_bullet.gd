extends Area2D

const ROTATION_CHANGE = 1.5
const SPEED = 500
@export var explosion_scene: PackedScene
@export var mega_bullet_2_scene: PackedScene
var despawn = 0
var friendly = false
@onready var global = get_node("/root/global")

# Called when the node enters the scene tree for the first time.\
# Spawns a hitbox on the player's position.
func _ready():
		set_meta("Delete", 0)
		var hitbox = explosion_scene.instantiate()
		hitbox.global_position = get_node("/root/Map/Player").global_position
		hitbox.rotation = rotation + ROTATION_CHANGE
		add_sibling(hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the projectile and despawns itself on boss death.
func _process(delta):
	move_local_x(SPEED * delta)
	if global.boss_3_hp == 0:
		queue_free()


# Spawns a Gravestone upon travelling a certain distance (upon contact with the hitbox).
func _on_area_entered(area):
	if area.has_meta("Debt") and not friendly:
		var mega_bullet_b = mega_bullet_2_scene.instantiate()
		add_sibling(mega_bullet_b)
		mega_bullet_b.global_position = global_position
		mega_bullet_b.rotation_degrees = global_rotation_degrees
		queue_free()
