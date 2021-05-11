extends Area2D

export var max_score = 1
export var levelC = 1
export var star1 = 0
export var star2 = 0
export var star3 = 0
export (String, FILE) var change_scene = ""
export var instruction = false

onready var animation = $AnimationPlayer



func change_Scene():
	get_tree().change_scene(change_scene)
	PlayerStats.score = 0
	PlayerStats.global_health = PlayerStats.health
	PlayerStats.score = 0
	PlayerStats.gem1 = 0
	PlayerStats.gem3 = 0
	PlayerStats.gem2 = 0


func _on_Portal_body_entered(body: Node) -> void:
	if(PlayerStats.score >= max_score):
		animation.play("fade")
		if(instruction == false):
			if PlayerStats.score >= star1:
				global.level.starE[levelC] = 1
				global.level.levelMH[levelC] = true
			if PlayerStats.score >= star2:
				global.level.starE[levelC] = 2
			if PlayerStats.score >= star3:
				global.level.starE[levelC] = 3
			if(global.level.starE[levelC]>global.level.GstarE[levelC]):
				global.level.GstarE[levelC] = global.level.starE[levelC]
			if(global.level.starH[levelC]>global.level.GstarH[levelC]):
				global.level.GstarH[levelC] = global.level.starH[levelC]
			PlayerStats.global_score += PlayerStats.score
			PlayerStats.Ggem1 += PlayerStats.gem1
			PlayerStats.Ggem2 += PlayerStats.gem2
			PlayerStats.Ggem3 += PlayerStats.gem3
