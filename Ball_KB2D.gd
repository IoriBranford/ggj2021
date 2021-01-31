extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export (int) var ballSpeed = 200
#First, I need to know whether ball was launched or attached.
# If attached, then I need player position and set to ball position..
# If detached, then I need just ball position.
# And then, when throwBall is called, the ballPosition is updated.
var ballVelocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#ball.position = Player.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func throwBall(angle, speed):
	#assumption angles are 0, 45, 90, 135, 180, -45, -90, -135 in degrees
	#
	#		-90
	#-135	|	 -45
	#	\	|	/
	#180<-	   ->0
	#	/	|	\
	#135	|	 45
	#		90
	#
	#speed is a number
	#print("Angle = ",angle)
	#print("Speed = ",speed)
	angle = deg2rad(angle)
	ballVelocity.x = cos(angle) * speed
	ballVelocity.y = sin(angle) * speed
#	print("ballVelocity x-axis", ballVelocity.x)
#	print("ballVelocity y-axis", ballVelocity.y)

func _physics_process(delta):
#	print("position = ", position)
#	print("ballVelocity.x = ", ballVelocity.x)
#	print("ballVelocity.y = ", ballVelocity.y)
	position += ballVelocity*delta
#	throwBall(angle,speed)
#	ballVelocity = move_and_slide(ballVelocity)
