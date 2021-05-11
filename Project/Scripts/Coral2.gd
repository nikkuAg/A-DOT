extends StaticBody2D


func _process(delta: float) -> void:
	if(global.power_start == 1):
		$Bush.playing = false
	else:
		$Bush.playing = true
