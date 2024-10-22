extends Area2D
@export var spark_3_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 290
var despawn = 0
var friendly = false

# Called when the node enters the scene tree for the first time.
# Begins the duplication.
func _ready():
	$Meiosis.start()

# Duplication function.
func _on_meiosis_timeout():
	var spark_3 = spark_3_scene.instantiate()
	add_sibling(spark_3)
	spark_3.global_position =global_position
	spark_3.rotation = global_rotation
	
	var spark_3_b = spark_3_scene.instantiate()
	add_sibling(spark_3_b)
	spark_3_b.global_position = global_position
	spark_3_b.rotation = global_rotation+170
	
	var spark_3_c = spark_3_scene.instantiate()
	add_sibling(spark_3_c)
	spark_3_c.global_position = global_position
	spark_3_c.rotation = global_rotation-170
	$Meiosis.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the spark and despawns it in the right conditions. 
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	if global.boss_hp == 0:
		queue_free()
	if despawn > 300:
		queue_free()

# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()

# Despawns the spark.
func _on_die_timeout():
	queue_free()

# Despawns the spark on exiting the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
