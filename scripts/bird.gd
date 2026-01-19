# Bird.gd
extends RigidBody2D

@export var jump_force = -400.0
@export var rotate_speed = 3.0 # 下落旋转的速度

var is_active = false

func _ready():
	# 初始化状态
	gravity_scale = 0.0
	is_active = false
	GameEvents.game_started.connect(_on_game_started)

func _physics_process(delta):
	if gravity_scale > 0:
		handle_rotation(delta)
	# 处理跳跃 (只有激活且没死的时候才能跳)
	if is_active:
		if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			jump()

func jump():
	linear_velocity.y = jump_force
	rotation_degrees = -30.0

func _on_game_started():
	is_active = true
	gravity_scale = 5.0 # 恢复重力
	jump() # 第一跳

func die():
	is_active = false
	GameEvents.bird_died.emit()
	GameEvents.game_over.emit()
	
func handle_rotation(delta):
	if linear_velocity.y > 0:
		# 使用 lerp (线性插值) 让角度平滑过渡到 90度 (垂直向下)
		rotation_degrees = lerp(rotation_degrees, 90.0, rotate_speed * delta)
	else:
		# 如果还在上升阶段，保持抬头 (或者缓慢回正，看手感需求)
		# 原版游戏上升时基本保持 -30 度不动
		rotation_degrees = -30.0
