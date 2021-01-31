extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var ballSpeed = 200
var ballVelocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func throwBall(angle, speed):
	#assumption angles are 0, 45, 90, 135, 180, -45, -90, -135 in degrees
	#
	#		0
	#135	|	 45
	#	\	|	/
	#	180	<-	->0
	#	/	|	\
	#-135	|	 -45
	#		-90
	#
	#speed is a number
	if (angle == 0):
		ballVelocity.x += speed
		ballVelocity.y += 0
	elif (angle == 45):
		ballVelocity.x += speed
		ballVelocity.y += speed
	elif (angle == 90):
		ballVelocity.x += 0
		ballVelocity.y += speed 
	elif (angle == 135):
		ballVelocity.x -= speed 
		ballVelocity.y += speed 
	elif (angle == 180):
		ballVelocity.x -= speed
		ballVelocity.y += 0
	elif (angle == -45):
		ballVelocity.x += speed
		ballVelocity.y -= speed 
	elif (angle == -90):
		ballVelocity.x += 0
		ballVelocity.y -= speed
	elif (angle == -135):
		ballVelocity.x -= speed
		ballVelocity.y -= speed 
	else:
		#do nothing.probably should error
		pass


#func _physics_process(delta):
#	var angle := 0
#	var speed := 1
#	throwBall(angle,speed)
#	ballVelocity = move_and_slide(ballVelocity)
