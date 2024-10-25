extends Area2D

@export var explosion_scene: PackedScene
@export var mega_bullet_2_scene: PackedScene
var speed = 500
var despawn = 0
var mega_bullet
var friendly = false
@onready var global = get_node("/root/global")


# Called when the node enters the scene tree for the first time.
# Sets meta data based on what spawned it.
# also spawns a explosive hitbox if the condition are met.
func _ready():
	if friendly:
		set_meta("player", 0)
	if not friendly:
		set_meta("Delete", 0)
		var hitbox = explosion_scene.instantiate()
		hitbox.global_position = get_node("/root/Map/Player").global_position
		hitbox.rotation = rotation + 1.5
		add_sibling(hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the bullet and changes the colour.
func _process(delta):
	move_local_x(speed * delta)
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)

# Damage and explosive function.
func _on_area_entered(area):
	if area.has_meta("Spawn"):
		queue_free()
	if area.has_meta("Tile"):
		queue_free()
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly:
		global.h_p -= 1
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.boss_h_p -= 1
		queue_free()
	if area.has_meta("Debt"):
		if not friendly:
			for i in 20:
				var mega_bullet_b = mega_bullet_2_scene	.instantiate()
				add_sibling(mega_bullet_b)
				mega_bullet_b.global_position = global_position
				mega_bullet_b.rotation_degrees = global_rotation_degrees + i*18
				queue_free()

