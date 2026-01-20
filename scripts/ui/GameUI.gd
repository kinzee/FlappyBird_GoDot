extends CanvasLayer

@onready var score_label = $ScoreLabel

func _ready():
	score_label.text = "0"
	
	# 监听分数更新信号，直接拿数据更新文本
	GameEvents.score_updated.connect(_on_score_updated)
	GameEvents.game_started.connect(_on_game_started)

func _on_score_updated(new_score):
	score_label.text = str(new_score)

func _on_game_started():
	score_label.text = "0"
