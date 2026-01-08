extends CharacterBody2D
# variable de base du joueur
@export var speed := 250
@export var jump_force := -450
@export var gravity := 1200

# variable pour faire tourner le joueur quand il saute
var face_index := 0
# variable de la gravité du joueur
var gravity_direction := 1

func _physics_process(delta: float) -> void:
	#mouvement automatique vers la droite
	velocity.x = speed
	
	#gravite
	
	if not is_on_floor():
		velocity.y += gravity * gravity_direction * delta
	# rotation progressive

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_surface():
		velocity.y = jump_force * gravity_direction
		
		#ajoute 90 degree a chaque saut
		face_index = (face_index + 1) % 4
		rotation = face_index * PI / 2

		
	
	move_and_slide()
	# c"est la fonction qui gere la mort du joueur avec les autres obstacles
	check_death()
	

func die():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	$GPUParticles2D.global_position = global_position
	$GPUParticles2D.emitting = true
	await  get_tree().create_timer(0.6).timeout
	
	get_tree().quit()


func check_death():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("dead"):
			die()

# fonction qui permet d'inverser la gravité du joueur
func set_gravity(invert: bool):
	gravity_direction = -1 if invert else 1
	rotation = face_index * PI / 2


func is_on_surface() -> bool:
	if gravity_direction == 1:
		return is_on_floor()
	else:
		return is_on_ceiling()
