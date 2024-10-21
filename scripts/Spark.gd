extends Area2D
@export var spark2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 320
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.

# Begins the replication process. 
func _ready():
	$Meiosis.start()

# Replicates the spark.
func _on_meiosis_timeout():
	var spark2 = spark2_scene.instantiate()
	add_sibling(spark2)
	spark2.global_position = global_position
	spark2.rotation = global_rotation
	
	var spark2b = spark2_scene.instantiate()
	add_sibling(spark2b)
	spark2b.global_position = global_position
	spark2b.rotation = global_rotation+170
	
	var spark2c = spark2_scene.instantiate()
	add_sibling(spark2c)
	spark2c.global_position = global_position
	spark2c.rotation = global_rotation-170
	
	$Meiosis.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the spark.
func _process(delta):
	move_local_x(speed * delta)



func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.HP -= 1
		global.iframes = true
		queue_free()

# Kills the spark after a set time.
func _on_Apoptosis_timeout():
	queue_free()

# # Kills the spark on exiting the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
