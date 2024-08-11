extends Area2D
@export var explosion_scene: PackedScene
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 500
var despawn = 0
var megabullet
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if not friendly:
		set_meta("Delete", 0)
		var hitbox = explosion_scene.instantiate()
		hitbox.global_position = get_node("/root/Map/Player").global_position
		hitbox.rotation = rotation+1.5
		add_sibling(hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)
	
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly:
		global.HP -= 1
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		queue_free()
	if area.has_meta("Debt"):
		if not friendly:
			for i in 20:
				var megabulletb = megabullet2_scene	.instantiate()
				add_sibling(megabulletb)
				megabulletb.global_position = global_position
				megabulletb.rotation_degrees = global_rotation_degrees + i*18
				queue_free()
