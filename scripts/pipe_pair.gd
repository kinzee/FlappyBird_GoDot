extends Node2D

signal bird_crashed # 撞毁信号
signal point_scored # 得分信号

@export var move_speed = 200.0

func _ready():
	# 1. 连接“杀手”信号 (上管和下管)
	# body_entered 是 Area2D 自带的信号，检测物理体进入
	$TopPipe.body_entered.connect(_on_body_entered)
	$BottomPipe.body_entered.connect(_on_body_entered)

	# 2. 连接“计分”信号
	$ScoreArea.body_entered.connect(_on_score_area_entered)

func _process(delta):
	position.x -= move_speed * delta
	if position.x < -300:
		queue_free()

# 内部处理函数：检测撞到的是不是鸟
func _on_body_entered(body):
	# 这里的 "Bird" 是你 Main 场景里鸟节点的名字
	# 或者更严谨的做法是：if body is RigidBody2D:
	if body.name == "Bird":
		bird_crashed.emit() # 发出自定义信号

func _on_score_area_entered(body):
	if body.name == "Bird":
		point_scored.emit() # 发出自定义信号
