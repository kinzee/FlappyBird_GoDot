extends Panel

@onready var score_label = $CurScoreLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	GameEvents.game_over.connect(_on_game_over)

func _on_game_over():
	visible = true;
	score_label.text = str(GameData.current_score)


func _on_btn_restart_pressed() -> void:
	GameEvents.game_restart.emit()
