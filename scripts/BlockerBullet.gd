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
		set_meta("Delete", 0)
		var hitbox = explosion_scene.instantiate()
		hitbox.global_position = get_node("/root/Map/Player").global_position
		hitbox.rotation = rotation+1.5
		add_sibling(hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	if global.bosshp == 0:
		queue_free()
	if not friendly:
		$Sprite2D.set_visible(false)


func _on_area_entered(area):
	if area.has_meta("Debt"):
		if not friendly:
			for i in 1:
				var megabulletb = megabullet2_scene	.instantiate()
				add_sibling(megabulletb)
				megabulletb.global_position = global_position
				megabulletb.rotation_degrees = global_rotation_degrees
				queue_free()
