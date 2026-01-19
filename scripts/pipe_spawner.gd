extends Node2D

# 1. 定义 spawner 自己的信号，用来向上传递事件
signal bird_crashed
signal point_scored

@export var pipe_scene: PackedScene # 在编辑器里把 PipePair.tscn 拖进来
@onready var timer = $Timer

func _ready():
	# 确保 Timer 的 timeout 信号连接到了这里，而不是 Main
	timer.timeout.connect(_on_timer_timeout)
	
# 对外接口：开始生成
func start_spawning():
	timer.start()
	
func _on_timer_timeout():
	var pipe = pipe_scene.instantiate()
	
	# 封装位置逻辑：Main 不需要知道管道具体生成在哪
	pipe.position = Vector2(0, randf_range(-150, 150))
	
	# --- 关键：信号中继 (Signal Relay) ---
	# 当管道发出撞击信号时，Spawner 捕获它，并转发给 Main
	pipe.bird_crashed.connect(func(): bird_crashed.emit())
	pipe.point_scored.connect(func(): point_scored.emit())
	
	# 自动归组，方便清理
	pipe.add_to_group("pipes")
	
	add_child(pipe)
