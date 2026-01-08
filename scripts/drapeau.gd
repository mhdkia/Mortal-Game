extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().paused = true
		$CanvasLayer.visible = true
		await get_tree().create_timer(5.0).timeout
		get_tree().quit()
