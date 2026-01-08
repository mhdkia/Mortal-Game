extends StaticBody2D

@export var move_distance := 120
@export var move_speed := 2.0
@export var horizontal := true

var start_position : Vector2
var time := 0.0

func _ready() -> void:
	start_position = global_position
	
func _physics_process(delta: float) -> void:
	time += delta * move_speed
	var offset := sin(time) * move_distance
	if horizontal:
		global_position.x = start_position.x + offset
	else:
		global_position.y = start_position.y + offset
