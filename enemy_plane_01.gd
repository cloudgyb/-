extends RigidBody2D

@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 100
	linear_velocity = Vector2(0,speed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
