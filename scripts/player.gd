extends CharacterBody2D
# variable de base du joueur
@export var speed := 250
@export var jump_force := -450
@export var gravity := 1200

# variable pour faire tourner le joueur quand il saute
var face_index := 0


func _physics_process(delta: float) -> void:
	#mouvement automatique vers la droite
	velocity.x = speed
	
	#gravite
	
	if not is_on_floor():
		velocity.y += gravity * delta
	# rotation progressive

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
		#ajoute 90 degree a chaque saut
		face_index = (face_index + 1) % 4
		rotation = face_index * PI / 2

		
	
	move_and_slide()
	
	
