extends Control

onready var gem = $Gem2
onready var crystal = $Crystal2
onready var jewl = $Jwel2
onready var button = $ChangeScene
onready var info = $Info
onready var button2 = $Info/Control/RichTextLabel/Button
onready var button3 = $Button

func _process(delta: float) -> void:
	gem.text = ": "+str(PlayerStats.Ggem1)
	jewl.text = ": "+str(PlayerStats.Ggem2)
	crystal.text = ": "+str(PlayerStats.Ggem3)


func _on_Button_button_up() -> void:
	button.visible = true
	button.disabled = false
	button3.visible = true
	button2.disabled = true


func _on_Button1_button_up() -> void:
	info.visible = true
	button2.disabled = false
	button3.visible = false
	button.disabled = true
	button.visible = false
