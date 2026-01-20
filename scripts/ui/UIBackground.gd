extends ParallaxBackground

@export var scroll_speed = 100.0 # 滚动速度

func _ready():
	# 监听游戏结束，停止滚动
	GameEvents.game_over.connect(_on_game_over)

func _process(delta):
	# 修改 scroll_offset 来移动背景
	# 只要一直减小 X 值，ParallaxLayer 就会自动处理循环
	scroll_base_offset.x -= scroll_speed * delta

func _on_game_over():
	# 游戏结束，停止处理 _process，画面定格
	set_process(false)
