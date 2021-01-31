extends KinematicBody2D

export (int) var playerVelocity
var Movement = Vector2()
var limite

func _ready():
	limite = get_viewport_rect().size

func _process(delta):
	Movement = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		Movement.x += 1
		$AnimatedSprite.flip_h = false;
	elif (Input.is_action_pressed("ui_left")):
		Movement.x -= 1
		$AnimatedSprite.flip_h = true;
	if Input.is_action_pressed("ui_down"):
		Movement.y += 1
	elif Input.is_action_pressed("ui_up"):
		Movement.y -= 1

	if Movement.length() > 0:
		Movement = Movement.normalized() * playerVelocity
		$AnimatedSprite.play("movement")
		
	else:
		$AnimatedSprite.play("idle")
		
	position += Movement * delta
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
