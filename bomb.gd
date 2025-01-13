extends AnimatedSprite2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _on_animation_finished() -> void:
	#queue_free()
	hide()
	pass


func _on_audio_stream_player_2d_finished() -> void:
	print("Bomb 特效移除")
	queue_free()
