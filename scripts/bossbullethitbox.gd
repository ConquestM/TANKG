extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_child(0).start()
	set_meta("Debt", 0)
	$Delete.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_delete_timeout():
	queue_free()

