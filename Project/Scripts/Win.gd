extends Control

onready var score = $Score

func _ready() -> void:
	score.text = "Score : " + str(PlayerStats.global_score)
