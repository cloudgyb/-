extends Area2D

@export var speed: float = 0
@export var health: int = 1000
@export var Bullet: PackedScene
@export var Bomb: PackedScene

func _ready() -> void:
	if speed == 0:
		speed = 100
	$BulletTimer.start()

func _process(delta: float) -> void:
	position.y += speed * delta

func _on_bullet_timer_timeout() -> void:
	var b: Area2D = Bullet.instantiate()
	b.position = position
	b.speed = speed + 100
	get_parent().add_child(b)
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$BulletTimer.stop()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("has_damage"):
		print("生命值-" + str(area.damage))
		health -= area.damage
	if health <= 0:
		var bomb = Bomb.instantiate()
		bomb.position = position
		get_parent().add_child(bomb)
		bomb.play()
		hide()
