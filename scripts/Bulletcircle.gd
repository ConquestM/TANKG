extends Area2D
@export var explosion_scene: PackedScene
@export var megabulletcircle_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 150
var despawn = 0
var megabullet
var friendly = false

# Called when the node enters the scene tree for the first time.
# Sets the delete metadata. Spawns a hitbox where the bullet will detonate.
func _ready():
	if not friendly:
		set_meta("Delete", 0)
		var hitbox = explosion_scene.instantiate()
		hitbox.position = get_node("/root/Map/Player").position
		hitbox.rotation = rotation+1.5
		add_sibling(hitbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the bullet and changes the colour.
func _process(delta):
	move_local_x(speed * delta)
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)


# Damage fuction, along with the code for detonating when coming into contact with the hitbox.
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()
	if area.has_meta("Debt2"):
		if not friendly:
			for i in 60:
				var megabulletcircle = megabulletcircle_scene.instantiate()
				add_sibling(megabulletcircle)
				megabulletcircle.position = position
				megabulletcircle.rotation_degrees = rotation_degrees + i*6
				queue_free()
