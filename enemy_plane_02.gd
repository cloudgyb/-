extends Area2D

@export var speed: float = 0
@export var health: int = 1500
@export var Bullet: PackedScene
@export var Bomb: PackedScene

const DEFAULT_SPEED: float = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if speed == 0:
		speed = DEFAULT_SPEED
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
		print("02生命值-" + str(area.damage))
		health -= area.damage
	if health <= 0:
		var bomb = Bomb.instantiate()
		bomb.position = position
		get_parent().add_child(bomb)
		bomb.play()
		$BombAudioPlayer.play()
		hide()
