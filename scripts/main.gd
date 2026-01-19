# Main.gd
extends Node2D

var score = 0
var is_game_started = false

func _ready():
	# 监听得分信号，负责处理核心数据
	GameEvents.point_scored.connect(_on_point_scored)
	
	# 初始化
	new_game()

func new_game():
	score = 0
	is_game_started = false
	# 清理旧管道 (如果有的话)
	get_tree().call_group("pipes", "queue_free")
	
	# 重置 UI (可以通过信号，也可以在这里发)
	GameEvents.score_updated.emit(0)

func _unhandled_input(event):
	if not is_game_started:
		if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			start_game()

func start_game():
	print("game start")
	is_game_started = true
	GameEvents.game_started.emit()

func _on_point_scored():
	score += 1
	# 更新数据后，广播给 UI
	GameEvents.score_updated.emit(score)
