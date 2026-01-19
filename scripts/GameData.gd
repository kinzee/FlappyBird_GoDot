extends Node

signal score_updated(current_score)
signal high_score_updated(best_score)

# 核心数据
var current_score: int = 0
var high_score: int = 0

# 存档路径 (user:// 意味着用户数据目录，跨平台安全)
const SAVE_PATH = "user://game_data.save"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 游戏启动时，尝试读取最高分
	load_high_score()

# --- 分数操作接口 ---
func reset_score():
	current_score = 0
	score_updated.emit(current_score)

func add_score(amount: int = 1):
	current_score += amount
	score_updated.emit(current_score)
	
	# 检查是否打破纪录
	if current_score > high_score:
		high_score = current_score
		high_score_updated.emit(high_score)
		save_high_score() # 实时保存新纪录

# --- 存档系统 (持久化) ---
func save_high_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_32(high_score)
		# print("最高分已保存: ", high_score)

func load_high_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_score = file.get_32()
		# print("最高分读取成功: ", high_score)
	else:
		high_score = 0
