extends Area2D
@export var lightning_scene: PackedScene
var priming = 10
var in_player = 0
var identity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = (false) 
	identity = global.light
	global.light += 1
	print (identity)
	position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if global.boss_hp == 0:
		queue_free()

func _on_primer_timeout():
	if priming > 0: 
		priming -= 1
		$Primer.start()
		visible = (true) 
	if priming == 0:
		var lightning = lightning_scene.instantiate()
		lightning.global_position = global_position
		add_sibling(lightning)
		priming = 10
		visible = (false) 



func _on_body_entered(body):
	if body.has_meta("Player") :
		in_player = 1
		print("player entered")
		print (identity)
		if global.lightning >= 1 and in_player == 1 :
			$Primer.start() 
			print("priming")
			global.lightning -= 1 

func _on_primed_timeout():
	var lightning = lightning_scene.instantiate()
	lightning.global_position = global_position
	add_sibling(lightning)


func _on_body_exited(body):
	if body.has_meta("Player") :
		in_player = 0
		print("player exited")
		print (identity)


func _on_despawn_timeout():
	queue_free()
