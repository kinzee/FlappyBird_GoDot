# PipePair.gd
extends Node2D

@export var move_speed = 200.0
var is_moving = true

func _ready():
	$TopPipe.body_entered.connect(_on_lethal_body_entered)
	$BottomPipe.body_entered.connect(_on_lethal_body_entered)
	$ScoreArea.body_entered.connect(_on_score_area_entered)
	
	# 监听总线：听到游戏结束，我就停止移动
	GameEvents.game_over.connect(_on_game_over)

func _process(delta):
	if is_moving:
		position.x -= move_speed * delta
		if position.x < -300:
			queue_free()


func _on_lethal_body_entered(body):
	if body.name == "Bird":
		body.die()

func _on_score_area_entered(body):
	if body.name == "Bird":
		GameEvents.point_scored.emit()

func _on_game_over():
	is_moving = false
