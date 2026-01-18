extends CharacterBody2D
# variable de base du joueur
@export var base_speed := 200
@export var max_speed := 500
@export var jump_force := -450
@export var gravity := 1200
@export var acceleration := 25




# variaables du score 
var start_x = 0.0
var score = 0

var current_speed := 0.0
# variable pour faire tourner le joueur quand il saute
var face_index := 0
# variable de la gravité du joueur
var gravity_direction := 1

func _ready() -> void:
	current_speed = base_speed
	# remet le score toujours a 0 quand le joueur meurt
	start_x = global_position.x
	score = 0
func _physics_process(delta: float) -> void:
	# ca augmente le score 
	#modifie le chiffre a la fin pour changer la vitesse du score
	#si tu augment le chiffre le score monte lentement mais a l'inverse ca accelère
	score = int((global_position.x - start_x) / 20)
	#mouvement automatique vers la droite
	current_speed += acceleration * delta
	current_speed = min(current_speed, max_speed)
	velocity.x = current_speed
	
	#gravite
	
	if not is_on_floor():
		velocity.y += gravity * gravity_direction * delta
	# rotation progressive
  
	# Saut
	if Input.is_action_pressed("jump") and is_on_surface():
		velocity.y = jump_force * gravity_direction
		
		#ajoute 90 degree a chaque saut
		face_index = (face_index + 1) % 4
		rotation = face_index * PI / 2
		
		
	
	move_and_slide()

	update_score_ui()
	# c"est la fonction qui gere la mort du joueur avec les autres obstacles
	check_death()
	

func die():
	$AnimatedSprite2D.visible = false
	#$CollisionShape2D.disabled = true
	$GPUParticles2D.global_position = global_position
	$GPUParticles2D.emitting = true
	velocity.x = 0
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

func update_score_ui():
	var label = get_tree().get_first_node_in_group("score_label")
	if label:
		label.text = str(score)
func teleport_effect():
	rotation = 0
