extends Area2D
@export var explosion_scene: PackedScene
@onready var global = get_node("/root/global")
var direction = 0
var speed = 50
var despawn = 0
var megabullet

var friendly = false
 
func _ready():
	$HomeTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

		move_local_x(speed * delta * 3)

func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.HP -= 1
		global.iframes = true
		queue_free()


