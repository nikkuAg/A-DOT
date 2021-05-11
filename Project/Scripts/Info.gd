extends ColorRect

onready  var control = $Control/RichTextLabel/Node2D
onready var scroll = $Control/RichTextLabel/VScrollBar2
onready var button = $Control/RichTextLabel/Button



func _process(delta: float) -> void:
	control.position.y = -scroll.value

func _on_Button_button_up() -> void:
	visible = false
	


func _on_VScrollBar2_scrolling() -> void:
	if(scroll.value != 0):
		button.visible = false
		button.disabled = true
	else:
		button.visible = true
		button.disabled = false
