extends Node2D

@onready var BallScene = preload("res://ball.tscn")

func _ready():
	spawn_ball()

func spawn_ball():
	var ball = BallScene.instantiate()
	ball.position = $BallSpawnPoint.global_position
	ball.connect("ball_fallen", self._on_ball_fallen)  # ✅ modern Godot 4 syntax
	add_child(ball)

func _on_ball_fallen():
	print("Ball lost!")
	await get_tree().create_timer(1.0).timeout
	spawn_ball()
