extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

# 定义回调函数
func _on_body_entered(body):
	# 逻辑判断：如果是鸟，就弄死它
	if body.name == "Bird":
		body.die()
	
