extends Node

# 游戏状态信号
signal game_started
signal game_over
signal game_restart

# 具体的游戏事件信号
signal bird_died
signal point_scored
signal score_updated(new_score)
