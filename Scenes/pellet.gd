extends Area2D
var velocity: Vector2

var SPEED: int =100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func destroy():
	queue_free()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position +=SPEED *direction *delta
