extends Area2D

@export var cooldown = 0.2
var can_teleport = true


 


			


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if not can_teleport:
		return
	can_teleport = false
	
	var exit_point = $Marker2D.global_position
	body.global_position = exit_point
	
	
	body.velocity.y = 0
	await get_tree().create_timer(cooldown).timeout
	can_teleport = true
	if body.has_method("teleport_effect"):
		body.teleport_effect()
