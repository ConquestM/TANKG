extends Area2D
@export var explosion_scene: PackedScene
@export var mega_bullet_2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 50
var despawn = 0
var mega_bullet
var friendly = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if friendly:
		set_meta("player", 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Function for movement, despawning and colour change.
func _process(delta):
	move_local_x(speed * delta)
	if global.level == 1 and global.boss_hp == 0:
		queue_free()
	if global.level == 2 and global.boss_2_hp == 0:
		queue_free()
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)

# Function for damage, also allows for the detonation when entering a certain area.
func _on_area_entered(area):
	if area.has_meta("Spawn"):
		queue_free()
	if area.has_meta("Tile"):
		queue_free()
	if area.has_meta("Player") and not friendly:
		global.hp -= 1
		queue_free()
	if area.has_meta("Debt"):
		if not friendly:
			for i in 20:
				var mega_bullet_b = mega_bullet_2_scene	.instantiate()
				add_sibling(mega_bullet_b)
				mega_bullet_b.global_position = global_position
				mega_bullet_b.rotation_degrees = global_rotation_degrees + i*18
				queue_free()

# Despawns the bullet on exiting the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
