extends Control

var hearts = 4 setget set_hearts
var max_heart = 4 setget set_max_hearts
var paused = false

onready var heartUiFull = $HeartUiFull
onready var heartUiEmpty = $HeartUiEmpty
onready var score = $Score
onready var pause = $PauseButton
onready var pause_display = $ColorRect
onready var up = $Up
onready var left = $Left
onready var down = $Down
onready var right = $Right
onready var attack = $Attack

export var allow_attack = true
export var allow_pause = true


func set_hearts(value):
	hearts= clamp(value,0,max_heart)
	if (heartUiFull != null):
		heartUiFull.rect_size.x = hearts * 15 
	
func set_max_hearts(value):
	max_heart = max(value, 1)
	self.hearts = min(hearts, max_heart)
	if heartUiEmpty != null:
		heartUiEmpty.rect_size.x = max_heart * 15

func _ready() -> void:
	if global.store.selectedA == 0:
		PlayerStats.max_health = 4
		PlayerStats.health = 4
	if global.store.selectedA == 1:
		PlayerStats.max_health = 7
		PlayerStats.health = 7
	if global.store.selectedA == 2:
		PlayerStats.max_health = 10
		PlayerStats.health = 10
	self.max_heart = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_change", self, "set_hearts")
	PlayerStats.connect("max_health_change", self, "set_max_hearts")
	PlayerStats.connect("score_updated", self, "set_score")
	set_score()
	
func _unhandled_input(event: InputEvent) -> void:
	if(allow_pause == true):
		if Input.is_action_pressed("pause"):
			_on_PauseButton_button_up()
			get_tree().set_input_as_handled()

func set_score():
	score.text = "Score: " + str(PlayerStats.score)


func _on_PauseButton_button_up() -> void:
	paused = !paused
	if(paused==true):
		get_tree().paused = true
		pause_display.visible = true
	else:
		get_tree().paused = false
		pause_display.visible = false


func _on_Resume_button_up() -> void:
	paused = false
	get_tree().paused = false
	pause_display.visible = false



func _on_Up_pressed() -> void:
	Input.action_press("ui_up")


func _on_Up_released() -> void:
	Input.action_release("ui_up")


func _on_Left_pressed() -> void:
	Input.action_press("ui_left")


func _on_Left_released() -> void:
	Input.action_release("ui_left")


func _on_Down_pressed() -> void:
	Input.action_press("ui_down")


func _on_Down_released() -> void:
	Input.action_release("ui_down")


func _on_Right_pressed() -> void:
	Input.action_press("ui_right")


func _on_Right_released() -> void:
	Input.action_release("ui_right")


func _on_Attack_pressed() -> void:
	if(allow_attack == true):
		Input.action_press("attack")


func _on_Attack_released() -> void:
	if(allow_attack == true):
		Input.action_press("attack")
