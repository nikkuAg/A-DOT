extends Node2D

onready var label = $CanvasLayer/Label
onready var label2 = $CanvasLayer/Label2
onready var gem = $Gem
onready var jwel = $Jwel
onready var crystal = $Crystal
onready var crystalC = $Crystal/CollisionPolygon2D
onready var gemC = $Gem/CollisionPolygon2D
onready var jwelC = $Jwel/CollisionPolygon2D
onready var musicB = $Boss
onready var musicU = $UnderWater
onready var collision = $Area2D/CollisionShape2D

var rng = RandomNumberGenerator.new()
var gem1
var gem2
var gem3

func _ready() -> void:
	rng.randomize()
	var num1 = int(rng.randf_range(0,10))
	var num2 = int(rng.randf_range(0,10))
	var num3 = int(rng.randf_range(0,10))
	while(num1==num2):
		num2 = int(rng.randf_range(0,10))
	while(num1==num3 or num2==num3):
		num3 = int(rng.randf_range(0,10))
	type_of_gem()
	global.level.levels =  label.text
	global.level.difficulty = label2.text
	gem(num1, num2, num3, gem1, gem2, gem3)
	if(label.text == "4"):
		global.reset_powerup()

func type_of_gem():
	var gem_state = [1, 1, 1, 2, 2, 3]
	var gem_final_state = [0, 0 ,0]
	gem1 = 0
	gem2 = 0
	gem3 = 0
	gem_state.shuffle()
	for n in 3:
		gem_final_state[n] = gem_state.pop_front()
	for n in 3:
		if(gem_final_state[n]==1):
			gem1 = 1
		if(gem_final_state[n] == 2):
			gem2 = 1
		if(gem_final_state[n] == 3):
			gem3 = 1


func gem(position1, position2, position3, gem1, gem2, gem3):
	if(label.text != "4"):
		if(gem1==1):
			gem.visible = true
			gemC.disabled = false
			if(label.text == "1"):
				gem.position.x = global.gemPosition.x1[position1]
				gem.position.y = global.gemPosition.y1[position1]
			elif(label.text == "2"):
				gem.position.x = global.gemPosition.x2[position1]
				gem.position.y = global.gemPosition.y2[position1]
			elif(label.text == "3"):
				gem.position.x = global.gemPosition.x3[position1]
				gem.position.y = global.gemPosition.y3[position1]
		else:
			gem.visible = false
			gemC.disabled = true
		if(gem2 == 1):
			jwel.visible = true
			jwelC.disabled = false
			if(label.text == "1"):
				jwel.position.x = global.gemPosition.x1[position2]
				jwel.position.y = global.gemPosition.y1[position2]
			elif(label.text == "2"):
				jwel.position.x = global.gemPosition.x2[position2]
				jwel.position.y = global.gemPosition.y2[position2]
			elif(label.text == "3"):
				jwel.position.x = global.gemPosition.x3[position2]
				jwel.position.y = global.gemPosition.y3[position2]
		else:
			jwel.visible = false
			jwelC.disabled = true
		if(gem3 == 1):
			crystal.visible = true
			crystalC.disabled = false
			if(label.text == "1"):
				crystal.position.x = global.gemPosition.x1[position3]
				crystal.position.y = global.gemPosition.y1[position3]
			elif(label.text == "2"):
				crystal.position.x = global.gemPosition.x2[position3]
				crystal.position.y = global.gemPosition.y2[position3]
			elif(label.text == "3"):
				crystal.position.x = global.gemPosition.x3[position3]
				crystal.position.y = global.gemPosition.y3[position3]
		else:
			crystal.visible = false
			crystalC.disabled = true

func _on_Area2D_body_entered(body: Node) -> void:
	musicU.playing = false
	musicB.playing = true
	collision.disabled = true
	
