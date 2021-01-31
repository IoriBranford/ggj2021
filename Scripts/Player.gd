extends KinematicBody2D

export (int) var playerVelocity
export var max_spin_radius = 32
export var spin_radius_growth = 16
export var spin_speed_deg = -900
var Movement = Vector2()
var limite
var spin_radius = 0
var spin_angle = 0
var isLaunched = 0 #1 means launched. 0 means attached to player

func _ready():
	limite = get_viewport_rect().size

func _physics_process(delta):
	Movement = Vector2()
	var ball = $Hand.find_node("Ball")
	if Input.is_action_pressed("ui_right"):
		Movement.x += 1
		scale.x = 1
	elif (Input.is_action_pressed("ui_left")):
		Movement.x -= 1
		scale.x = -1
	if Input.is_action_pressed("ui_down"):
		Movement.y += 1
	elif Input.is_action_pressed("ui_up"):
		Movement.y -= 1

	var animation = $AnimatedSprite.animation
	
	if Movement.length_squared() > 0:
		Movement = Movement.normalized() * playerVelocity
		animation = "movement"
	else:
		animation = "idle"
	
	if Input.is_action_just_released("ui_accept") and ball != null:
		var speed = 2	#for now just a static value
		var angle = 0
		if Input.is_action_pressed("ui_right"):
			angle = 0
		elif Input.is_action_pressed("ui_up"):
			angle = -90
		elif Input.is_action_pressed("ui_down"):
			angle = 90
		elif Input.is_action_pressed("ui_left"):
			angle = 180
		elif (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up")):
			angle = -45
		elif (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up")):
			angle = -135
		elif (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down")):
			angle = 45
		elif (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down")):
			angle = 135
		else:
			pass	#incase incorrect option chosen
		isLaunched = 1
		
		$Hand.remove_child(ball)
		get_parent().add_child(ball)
		ball.position = Vector2.ZERO
		ball.global_position = $Hand.global_position
		ball.throwBall(angle,speed)
	
	#if Input.is_action_pressed("ui_accept") and isLaunched == 0:
	if Input.is_action_pressed("ui_accept") and ball != null:
		spin_radius = move_toward(spin_radius, max_spin_radius, spin_radius_growth*delta)
		spin_angle += spin_speed_deg*delta
		animation += "_swing"
	else:
		spin_radius = 0
		spin_angle = 0
	#if isLaunched == 0:
	#	ball.position.x = spin_radius * cos(deg2rad(spin_angle))
	#	ball.position.y = spin_radius * sin(deg2rad(spin_angle))
	if ball != null:
		ball.position.x = spin_radius * cos(deg2rad(spin_angle))
		ball.position.y = spin_radius * sin(deg2rad(spin_angle))
	for i in range(1, 9):
		var chainlink = find_node("chainlink%d" % i)
		var radius = spin_radius * i / 9
		chainlink.position.x = radius * cos(deg2rad(spin_angle))
		chainlink.position.y = radius * sin(deg2rad(spin_angle))
	
	$AnimatedSprite.play(animation)
		
	position += Movement * delta
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
