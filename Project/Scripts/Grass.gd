extends Node2D

const CoralEffect = preload("res://Scenes/Corals/HealingCoralEffect.tscn")
export var score = 1
export (bool) var health = false


func create_grassEffect():
	var coraleffect = CoralEffect.instance()
	var world = get_tree().current_scene
	world.add_child(coraleffect)
	coraleffect.global_position = global_position

func _on_HurtBox_area_entered(area: Area2D) -> void:
	create_grassEffect()
	queue_free()
	if health == true:
		if PlayerStats.health < PlayerStats.max_health:
			PlayerStats.health += 1
	if(global.store.selectedP == 0):
		score *= 2
	PlayerStats.score += score
