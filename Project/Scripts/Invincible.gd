extends Control

onready var button = $TextureButton
onready var timer = $Timer

func _ready() -> void:
	if(global.store.selectedP == 3):
		visible = true
		button.disabled = false
	else:
		visible = false
		button.disabled = true


func _on_TextureButton_button_up() -> void:
	timer.start()
	global.power_start = 2
	button.disabled = true	
	visible = false


func _on_Timer_timeout() -> void:
	timer.stop()
	global.power_start = 3
