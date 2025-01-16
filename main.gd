extends Node

@export var Level1Scene: PackedScene
var game_level

func _ready() -> void:
	$PlayerDieLabel.visible = false
	$BackButton.visible = false
	$RestartButton.visible = false


func _on_start_button_pressed() -> void:
	$PlayerDieLabel.visible = false
	$BackButton.visible = false
	$RestartButton.visible = false
	$FullBg.visible = false
	$Element01.visible = false
	$BgAudioPlayer.stop()
	$StartButton.visible = false
	$TitleLabel.visible = false
	game_level = Level1Scene.instantiate()
	game_level.connect("game_over",Callable(self, "_on_game_over"))
	add_child(game_level)


func _on_back_button_pressed() -> void:
	if game_level != null:
		game_level.queue_free()
	game_level = null
	$FullBg.visible = true
	$Element01.visible = true
	$BgAudioPlayer.play()
	$StartButton.visible = true
	$TitleLabel.visible = true
	$PlayerDieLabel.visible = false
	$BackButton.visible = false
	$RestartButton.visible = false

func _on_restart_button_pressed() -> void:
	if game_level != null && !game_level.is_queued_for_deletion():
		game_level.queue_free()
	_on_start_button_pressed()

func _on_game_over() -> void:
	$PlayerDieLabel.visible = true
	$BackButton.visible = true
	$RestartButton.visible = true
