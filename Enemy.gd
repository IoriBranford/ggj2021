extends KinematicBody2D

var player = null
var move = Vector2.ZERO
var speed = 1
var canAttack = false
var canMove = true

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null and canMove:
		move = position.direction_to(player.position) * speed
		
		move = move.normalized()
		move = move_and_collide(move)

func _on_Area2D_body_entered(body):
	if body != self:
		player = body


func _on_Area2D_body_exited(body):
	player = null


func _on_Timer_timeout():
	if player != null and canAttack:
		print("attack")


func _on_Area2D2_body_entered(body):
	if body != self:
		canAttack = true
		print("in range to attack")


func _on_Area2D2_body_exited(body):
	canAttack = false
	print("out of range to attack")
	
