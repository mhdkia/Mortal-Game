extends StaticBody2D


@export var rotation_speed = 360
@export var move_speed = 150
@export var move_direction = Vector2.RIGHT

func _process(delta: float) -> void:
	rotation += deg_to_rad(rotation_speed) * delta
	
	position += move_direction.normalized() * move_speed * delta
