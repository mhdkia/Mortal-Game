extends Area2D
# cette variables permet de changer la gravité et de l'inverser
@export var invert_gravity := true



func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_gravity"):
		body.set_gravity(invert_gravity)
