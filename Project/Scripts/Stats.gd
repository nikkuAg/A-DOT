extends Node

export var max_health = 1 setget set_max_health
var health = max_health setget set_health
var score = 0 setget set_score
var gem1 = 0 setget set_gem1
var gem2 = 0 setget set_gem2
var gem3 = 0 setget set_gem3
var Ggem1 = 0
var Ggem2 = 0
var Ggem3 = 0
var global_score = 0
var global_health = 4


signal score_updated
signal no_health
signal gem_updated
signal health_change(value)
signal max_health_change(value)

func set_health(value):
	health = value
	emit_signal("health_change", health)
	if(health <= 0):
		emit_signal("no_health")

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_change", max_health)
	
func _ready() -> void:
	self.health = max_health

func set_score(value):
	score = value
	emit_signal("score_updated")

func set_gem1(value):
	gem1 = value
	emit_signal("gem_updated")

func set_gem2(value):
	gem2 = value
	emit_signal("gem_updated")

func set_gem3(value):
	gem3 = value
	emit_signal("gem_updated")
