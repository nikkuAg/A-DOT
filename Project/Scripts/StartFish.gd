extends KinematicBody2D

const EnemyDieEffect = preload("res://Scenes/EnemyDeathEffect.tscn")

export var score = 1

onready var sprite = $Sprite
onready var stats = $Stats
onready var hurtbox = $HurtBox

func _process(delta: float) -> void:
	if(global.power_start == 1):
		$Sprite.playing = false
	else:
		$Sprite.playing = true

func _on_HurtBox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	hurtbox.creta_hit_effect()


func _on_Stats_no_health() -> void:
	queue_free()
	var enemyDieEffect = EnemyDieEffect.instance()
	get_parent().add_child(enemyDieEffect)
	enemyDieEffect.global_position = global_position
	if(global.store.selectedP == 0):
		score *= 2
	PlayerStats.score += score
	
