# Main.gd
extends Node2D

var is_game_started = false

func _ready():
	# 初始化
	new_game()
	GameEvents.game_restart.connect(_on_game_restart)

func new_game():
	is_game_started = false
	# 清理旧管道 (如果有的话)
	get_tree().call_group("pipes", "queue_free")
	# 调用 GameData 重置分数
	GameData.reset_score()

func _unhandled_input(event):
	if not is_game_started:
		if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			start_game()

func start_game():
	print("game start")
	is_game_started = true
	GameEvents.game_started.emit()
	
func _on_game_restart():
	get_tree().reload_current_scene()
