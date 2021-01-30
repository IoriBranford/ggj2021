extends KinematicBody2D

export (int) var playerVelocity
var Movimiento = Vector2()
var limite

func _ready():
	limite = get_viewport_rect().size

func _process(delta):
	Movimiento = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
	if (Input.is_action_pressed("ui_left")):
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1
	
	if Movimiento.length() > 0:
			Movimiento = Movimiento.normalized() * playerVelocity
		
	position += Movimiento * delta
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
