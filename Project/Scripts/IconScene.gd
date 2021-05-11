extends Node2D


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://Scenes/Main.tscn")
