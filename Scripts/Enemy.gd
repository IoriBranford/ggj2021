extends KinematicBody2D

export var BulletScene:PackedScene
export (int) var speed = 120
var player : Node2D = null
var move = Vector2.ZERO
var canAttack = false
var canShoot = false
var canMove = true
var squashed = false
export var squash_speed = 4

func Shoot():
	if !BulletScene:
		return
	var bullet = BulletScene.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child((bullet))

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		if canMove:
			move = position.direction_to(player.position) * speed
			move = move_and_slide(move)
	
	for i in range(0, get_slide_count()):
		var collision = get_slide_collision(i)
		var object:Node2D = collision.collider
		if object:
			if object.name == "Ball":
				if not squashed:
					$AnimatedSprite.rotation = collision.normal.angle()
					squashed = true
					canMove = false
					canShoot = false
					BulletScene = null
	
	if squashed:
		$AnimatedSprite.scale.x += squash_speed*delta
		$AnimatedSprite.scale.y -= squash_speed*delta
		if $AnimatedSprite.scale.y < 0:
			queue_free()
		
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player = null

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		if BulletScene:
			canShoot = true

func _on_Area2D2_body_exited(body):
	if body.name == "Player":
		canShoot = false

func _on_Timer_timeout():
	if canShoot and player != null:
		Shoot()
