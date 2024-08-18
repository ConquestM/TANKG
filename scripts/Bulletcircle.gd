extends Area2D
@export var explosion_scene: PackedScene
@export var megabulletcircle_scene: PackedScene
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
		hitbox.position = get_node("/root/Map/Player").position
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
			for i in 60:
				var megabulletcircle = megabulletcircle_scene.instantiate()
				add_sibling(megabulletcircle)
				megabulletcircle.position = position
				megabulletcircle.rotation_degrees = rotation_degrees + i*6
				queue_free()