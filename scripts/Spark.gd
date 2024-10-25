extends Area2D

@export var spark_2_scene: PackedScene
const SPEED = 320
var despawn = 0
var friendly = false
@onready var global = get_node("/root/global")


# Begins the replication process. 
func _ready():
	$Meiosis.start()

# Replicates the spark.
func _on_meiosis_timeout():
	var spark_2 = spark_2_scene.instantiate()
	add_sibling(spark_2)
	spark_2.global_position = global_position
	spark_2.rotation = global_rotation
	
	var spark_2_b = spark_2_scene.instantiate()
	add_sibling(spark_2_b)
	spark_2_b.global_position = global_position
	spark_2_b.rotation = global_rotation+170
	
	var spark_2_c = spark_2_scene.instantiate()
	add_sibling(spark_2_c)
	spark_2_c.global_position = global_position
	spark_2_c.rotation = global_rotation-170
	
	$Meiosis.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the spark.
func _process(delta):
	move_local_x(SPEED * delta)

# Function for damage/despawning.
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()


# Kills the spark after a set time.
func _on_Apoptosis_timeout():
	queue_free()


# # Kills the spark on exiting the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

