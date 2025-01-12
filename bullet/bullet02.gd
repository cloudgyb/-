extends Area2D

const DEFAULT_SPEED: float = 80
@export var speed: float = DEFAULT_SPEED

func _process(delta: float) -> void:
	position.y = position.y + speed * delta


func destory() -> void:
	print("子弹销毁")
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destory()


func _on_area_entered(area: Area2D) -> void:
	destory()
