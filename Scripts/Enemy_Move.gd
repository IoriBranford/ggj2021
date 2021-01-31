extends KinematicBody2D

export (int) var speed
var player : Node2D = null
var move = Vector2.ZERO
var canAttack = false
var canShoot = true
var canMove = true

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null and canMove:
		move = position.direction_to(player.position) * speed
		
		move = move.normalized()
		move = move_and_collide(move)
		
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player = null
