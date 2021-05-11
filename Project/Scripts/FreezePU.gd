extends Control

onready var button = $TextureButton
onready var timer = $Timer
onready var sound = $AudioStreamPlayer

func _ready() -> void:
	if(global.store.selectedP == 1):
		visible = true
		button.disabled = false
	else:
		visible = false
		button.disabled = true


func _on_TextureButton_button_up() -> void:
	timer.start()
	global.power_start = 1
	button.disabled = true
	visible = false
	sound.playing = true


func _on_Timer_timeout() -> void:
	timer.stop()
	global.power_start = 4
	sound.playing = false
