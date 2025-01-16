extends Area2D

const DEFAULT_SPEED: int = 500

@export var speed:int = DEFAULT_SPEED
@export var Bullet: PackedScene
@export var Bomb: PackedScene
@export var health: int = 5000
var screen_size
var ui_player_health_progress: ProgressBar
var ui_player_health_label: Label

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$BulletTimer.start()
	$ProgressBar.max_value = health
	$ProgressBar.value = health
	ui_player_health_progress = get_parent().get_node("UI/ProgressBar")
	ui_player_health_progress.max_value = health
	ui_player_health_progress.value = health
	ui_player_health_label = get_parent().get_node("UI/HealthLabel")
	ui_player_health_label.text = str(health)
	
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
	if health <= 0:
		return
	if area.has_method("has_damage"):
		health -= area.damage
		$ProgressBar.value = health
		ui_player_health_progress.value = health
		var h = health
		if health < 0:
			h = 0
		ui_player_health_label.text = str(h)
		if health <= 0:
			$BulletTimer.stop()
			hide()
			set_deferred("monitoring", false)
			set_deferred("monitorable", false)
			collision_layer = 0
			var bomb = Bomb.instantiate()
			bomb.position = position
			get_parent().add_child(bomb)
			bomb.play()
		print("玩家被击中生命-" + str(area.damage))


func _on_bullet_timer_timeout() -> void:
	var b = Bullet.instantiate()
	b.position = position
	b.speed = 100 + speed
	get_parent().add_child(b)
