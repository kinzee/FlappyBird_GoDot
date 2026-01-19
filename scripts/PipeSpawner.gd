# PipeSpawner.gd
extends Node2D

@export var pipe_scene: PackedScene
@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	
	GameEvents.game_started.connect(func(): timer.start())
	GameEvents.game_over.connect(func(): timer.stop())

func _on_timer_timeout():
	var pipe = pipe_scene.instantiate()
	pipe.position = Vector2(350, randf_range(-150, 150))
	
	# 必须加组，方便 Main 清理
	pipe.add_to_group("pipes") 
	# 注意：PipePair.gd 里已经写了监听 Game_over 停止移动的逻辑，
	# 所以这里不需要再手动连信号了，非常省心！
	
	add_child(pipe)
