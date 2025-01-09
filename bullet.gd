extends RigidBody2D

@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if speed == 0:
		speed = 80
	linear_velocity = Vector2(0,speed)
