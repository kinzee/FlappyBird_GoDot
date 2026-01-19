extends RigidBody2D

@export var jump_force = -400.0
var is_started = false # 状态标记

func _ready():
	# 游戏刚运行时，将重力倍率设为 0，小鸟会悬浮在空中
	gravity_scale = 0.0 
	# 可选：给个向上的初速度让它看起来像在“飘”，或者写个Tween动画

func start_flying():
	if is_started:
		return
	is_started = true
	gravity_scale = 5.0 # 恢复重力 (根据你之前的设置调整数值)
	jump() # 第一次点击同时也触发第一下跳跃

func jump():
	linear_velocity.y = jump_force
	angular_velocity = -5.0
