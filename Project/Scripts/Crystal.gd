extends Area2D

export var gem = 1

func _ready() -> void:
	$AnimationPlayer.play("Jump")
	$CollisionPolygon2D.disabled = false


func _on_Crystal_body_entered(body: Node) -> void:
	$AnimationPlayer.play("Picked")
	$CollisionPolygon2D.disabled = true
	if(gem==1):
		PlayerStats.gem1 += 1
	if(gem==2):
		PlayerStats.gem2 += 1
	if(gem==3):
		PlayerStats.gem3 += 1

