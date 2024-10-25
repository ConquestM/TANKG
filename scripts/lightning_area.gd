extends Area2D
@export var lightning_scene: PackedScene
var priming = 10
var in_player = 0


# Called when the node enters the scene tree for the first time.
# makes the area invisible. increases the global variable and sets the y pos to 0.
func _ready():
	visible = (false) 
	global.light += 1
	position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Despawns if the boss is dead.
func _process(_delta):
	if global.boss_hp == 0:
		queue_free()


# Function for setting up spawning lightning.
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


# Trigger for starting to attack the player.
func _on_body_entered(body):
	if body.has_meta("Player") :
		in_player = 1
		if global.lightning >= 1 and in_player == 1 :
			$Primer.start() 
			global.lightning -= 1 


# Once enough priming's have gone, the lightning is spawned.
func _on_primed_timeout():
	var lightning = lightning_scene.instantiate()
	lightning.global_position = global_position
	add_sibling(lightning)


# Makes it unable to try to attack the player when the player is not in it.
func _on_body_exited(body):
	if body.has_meta("Player") :
		in_player = 0


# Despawns the area.
func _on_despawn_timeout():
	queue_free()
