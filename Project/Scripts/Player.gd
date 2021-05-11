extends KinematicBody2D

const PlayerHurtSound = preload("res://Scenes/PlayerHurtSound.tscn")
const Time_Period = 0.3

export var friction = 500
export var acc = 500
export var Max_speed = 150
export var health = 4
export(bool) var move = true
export(bool) var action = true

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats
var animationTree
var animationState
var count = 0
var timer = 0.0


onready var animationplayer = $AnimationPlayerGreen
onready var swordHitbox = $HitBoxPivot/HitBox
onready var hurtbox = $HurtBox


func _ready() -> void:
	randomize()
	playerSelect()
	stats.connect("no_health", self, "die_player")
	PlayerStats.max_health  = health
	PlayerStats.health = PlayerStats.global_health
	print(PlayerStats.health)
	print(PlayerStats.max_health)


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			moveState(delta)
		ATTACK:
			if action==true:
				attackState(delta)
	if(PlayerStats.health <= 4):
		if(count == 0):
			delta = 0
			count = 1
		timer = timer + delta
		if(timer < Time_Period):
			pass
		else:
			if(global.store.selectedP == 2):
				count = 2
			if(count == 1):
				armorBreak()
			count = 2
		
		
func moveState(delta):
	var input_vector = Vector2.ZERO
	if move==true:
		input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	else:
		input_vector = Vector2.ZERO
	input_vector = input_vector.normalized()
	
	if input_vector!=Vector2.ZERO:
		swordHitbox.knock_back_vec = input_vector
		animationState.travel("Run")
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * Max_speed, acc * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attackState(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)

func armorBreak():
	print("In armor")
	animationTree.active = false
	global.load_store()
	if global.store.selectedA == 1:
		global.store.selectedA = 0 
		global.store.boughtA[1] = false
	elif global.store.selectedA == 2:
		global.store.selectedA = 0 
		global.store.boughtA[2] = false
	animationState  = animationTree.get("parameters/playback")
	global.save_store()
	PlayerStats.max_health = 4
	playerSelect()

func playerSelect():
	print(global.store.selectedA)
	if global.store.selectedA == 0 and global.store.selectedW == 0:
		animationTree = $AnimationsTrees/AnimationTree00
	if global.store.selectedA == 0 and global.store.selectedW == 1:
		animationTree = $AnimationsTrees/AnimationTree10
	if global.store.selectedA == 0 and global.store.selectedW == 2:
		animationTree = $AnimationsTrees/AnimationTree20
	if global.store.selectedA == 1 and global.store.selectedW == 0:
		animationTree = $AnimationsTrees/AnimationTree01
	if global.store.selectedA == 1 and global.store.selectedW == 1:
		animationTree = $AnimationsTrees/AnimationTree11
	if global.store.selectedA == 1 and global.store.selectedW == 2:
		animationTree = $AnimationsTrees/AnimationTree21
	if global.store.selectedA == 2 and global.store.selectedW == 0:
		animationTree = $AnimationsTrees/AnimationTree02
	if global.store.selectedA == 2 and global.store.selectedW == 1:
		animationTree = $AnimationsTrees/AnimationTree12
	if global.store.selectedA == 2 and global.store.selectedW == 2:
		animationTree = $AnimationsTrees/AnimationTree22
	animationTree.active = true
	animationState  = animationTree.get("parameters/playback")

func die_player():
	queue_free()
	PlayerStats.global_score += PlayerStats.score
	global.reset_powerup()
	get_tree().change_scene("res://Scenes/Die.tscn")

func attack_animation_finished():
	state = MOVE

func _on_HurtBox_area_entered(area: Area2D) -> void:
	if(global.power_start == 2):
		stats.health = stats.health
	else:
		stats.health -= area.damage
		hurtbox.start_invinciblity(0.5)
		hurtbox.creta_hit_effect()
		var palyerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(palyerHurtSound)
	
