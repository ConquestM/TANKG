extends Label
@onready var timer = $Timer
@onready var light = $PointLight2D
var neu_color : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var random = randf()
	print(random)

