# Bird.gd
extends RigidBody2D

@export var jump_force = -400.0
@onready var hitbox = $Hitbox

var is_active = false

func _ready():
	# 初始化状态
	gravity_scale = 0.0
	is_active = false
	GameEvents.game_started.connect(_on_game_started)

func _physics_process(delta):
	# 处理跳跃 (只有激活且没死的时候才能跳)
	if is_active:
		if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			jump()

func jump():
	linear_velocity.y = jump_force
	angular_velocity = -5.0

func _on_game_started():
	is_active = true
	gravity_scale = 5.0 # 恢复重力
	jump() # 第一跳

func die():
	is_active = false
	GameEvents.bird_died.emit()
	GameEvents.game_over.emit()
