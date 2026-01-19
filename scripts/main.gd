extends Node2D

var game_running = false

@onready var spawner = $PipeSpawner # 引用生成器
@onready var bird = $Bird
@onready var score_label = $UI/ScoreLabel

var score = 0
func _ready():
	game_running = false
	spawner.bird_crashed.connect(game_over)
	spawner.point_scored.connect(add_score)

func _unhandled_input(event):
	# 检测鼠标左键 或 空格/回车 (ui_accept)
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if not game_running:
			start_game()
		else:
			# 游戏已经开始，点击就是让鸟跳跃
			bird.jump()

func start_game():
	game_running = true
	# 1. 激活小鸟物理
	bird.start_flying()
	spawner.start_spawning()

func game_over():
	print("Game Over")
	bird.set_physics_process(false)
	spawner.stop_spawning() # 只有一行命令
	get_tree().call_group("pipes", "set_process", false)

func add_score():
	score += 1
	score_label.text = str(score)
