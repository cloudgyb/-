extends Node

@export var EnemyPlane01: PackedScene
@export var EnemyPlane02: PackedScene
@export var EnemyPlane03: PackedScene
@export var Player: PackedScene
var player: Area2D

var eps: Array

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eps = [EnemyPlane01,EnemyPlane02,EnemyPlane03]
	$EnemyPlaneTimer.start()
	player = Player.instantiate()
	var vp_size = get_viewport().size
	var p_size = player.get_node("Sprite2D").get_rect().size
	player.position = Vector2((vp_size.x/2),(vp_size.y-p_size.y));
	add_child(player)
	player.connect("play_die", Callable(self, "_on_play_die"))

# 定时生成敌机
func _on_enemy_plane_timer_timeout() -> void:
	var index = randi_range(0, eps.size()-1)
	var plane_scene = eps[index]
	var p = plane_scene.instantiate()
	p.position = Vector2(0, 0)
	p.position.x += randi_range(100, get_viewport().size.x-100)
	#p.speed = randi_range(100,500)
	add_child(p)
	


func _on_play_die() -> void:
	player.queue_free()
	game_over.emit()
	pass # Replace with function body.
