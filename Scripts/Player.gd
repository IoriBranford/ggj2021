extends KinematicBody2D

export (int) var playerVelocity
export var max_spin_radius = 32
export var spin_radius_growth = 16
export var spin_speed_deg = -900
var Movement = Vector2()
var limite
var spin_radius = 0
var spin_angle = 0

var footsteps_instance = 0
var spin_instance = 0

func _ready():
	limite = get_viewport_rect().size
	
	#footsteps_instance = Fmod.create_event_instance("event:/Player/FootstepsLoop")
	#spin_instance = Fmod.create_event_instance("event:/Weapon/SwingLoop")

func _exit_tree():
	#if footsteps_instance != 0:
		#Fmod.release_event(footsteps_instance)
	#if spin_instance != 0:
		#Fmod.release_event(spin_instance)
	pass

func _physics_process(delta):
	if not visible:
		if Input.is_action_just_released("ui_accept"):
			get_tree().change_scene("res://Scenes/MainMenu.tscn")
			Fmod.stop_all_bus_events("bus:/", Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
		return
	
	Movement = Vector2()
	var ball = get_node("Hand/Ball") if has_node("Hand/Ball") else null
	if Input.is_action_pressed("ui_right"):
		Movement.x += 1
		$AnimatedSprite.flip_h = false
		if $Hand.position.x > 0:
			$Hand.position.x = -$Hand.position.x
	elif (Input.is_action_pressed("ui_left")):
		Movement.x -= 1
		$AnimatedSprite.flip_h = true
		if $Hand.position.x < 0:
			$Hand.position.x = -$Hand.position.x
	if Input.is_action_pressed("ui_down"):
		Movement.y += 1
	elif Input.is_action_pressed("ui_up"):
		Movement.y -= 1

	var animation = $AnimatedSprite.animation
	
	if Movement.length_squared() > 0:
		Movement = Movement.normalized() * playerVelocity
		animation = "movement"
		#if footsteps_instance != 0:
			#Fmod.start_event(footsteps_instance)
	else:
		animation = "idle"
		#if footsteps_instance != 0:
			#Fmod.stop_event(footsteps_instance, Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	
	if Input.is_action_just_released("ui_accept"):
		print(ball)
		print($Hand.get_children())
		if ball != null:
			var speed = 2	#for now just a static value
			var angle = 0
			var ball_position = ball.global_position
			$Hand.remove_child(ball)
			get_parent().add_child(ball)
			ball.global_position = ball_position
			if spin_speed_deg < 0:
				angle = spin_angle - 90
			else:
				angle = spin_angle + 90
			speed = abs(deg2rad(spin_speed_deg)) * spin_radius
			ball.throwBall(angle, speed)
			ball = null
	
	if Input.is_action_pressed("ui_accept") and ball != null:
		spin_radius = move_toward(spin_radius, max_spin_radius, spin_radius_growth*delta)
		spin_angle += spin_speed_deg*delta
		animation += "_swing"
		ball.position.x = spin_radius * cos(deg2rad(spin_angle))
		ball.position.y = spin_radius * sin(deg2rad(spin_angle))
		#if spin_instance != 0:
			#Fmod.start_event(spin_instance)
	else:
		spin_radius = 0
		spin_angle = 0
		#if spin_instance != 0:
			#Fmod.stop_event(spin_instance, Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	
	for i in range(1, 9):
		var chainlink = find_node("chainlink%d" % i)
		var radius = spin_radius * i / 9
		chainlink.position.x = radius * cos(deg2rad(spin_angle))
		chainlink.position.y = radius * sin(deg2rad(spin_angle))
	$AnimatedSprite.play(animation)
		
	move_and_slide(Movement)
	for i in range(0, get_slide_count()):
		var collision = get_slide_collision(i)
		var object = collision.collider
		if object.has_method("pick_up"):
			object.call("pick_up", $Hand)
			continue
		if object is PhysicsBody2D and object.collision_layer == 8:
			Fmod.play_one_shot("event:/Player/TakeDamage", self)
			visible = false


func _on_Footsteps_timeout():
	if Movement != Vector2.ZERO:
		Fmod.play_one_shot("event:/Player/FootstepsLoop", self)
		$Footsteps.start(1.6)


func _on_Swing_timeout():
	if Input.is_action_pressed("ui_accept"):
		Fmod.play_one_shot("event:/Weapon/SwingLoop", self)
		$Swing.start(2.6)
