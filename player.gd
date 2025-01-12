extends Area2D

const DEFAULT_SPEED: int = 500

@export var speed:int = DEFAULT_SPEED
@export var Bullet: PackedScene

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$BulletTimer.start()
	
func _process(delta: float):
	var v = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		v.y -= 1
	if Input.is_action_pressed("move_down"):
		v.y += 1
	if Input.is_action_pressed("move_left"):
		v.x -= 1
	if Input.is_action_pressed("move_right"):
		v.x += 1
	if v.length() > 0:
		v = v.normalized() * speed
		position += v * delta
		position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_entered(area: Area2D) -> void:
	print("++++++8888888888")


func _on_bullet_timer_timeout() -> void:
	var b = Bullet.instantiate()
	b.position = position
	b.speed = 100 + speed
	get_parent().add_child(b)
