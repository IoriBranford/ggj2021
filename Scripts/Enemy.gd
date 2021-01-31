extends KinematicBody2D

onready var BulletScene = preload("res://Scenes/Bullet.tscn")

export (int) var speed
var player : Node2D = null
var move = Vector2.ZERO
var canAttack = false
var canShoot = true
var canMove = true

func _ready():
	$Tentacle.visible = false
	
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
	player = null

func Shoot():
	var bullet = BulletScene.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child((bullet))
	
func _on_Timer_timeout():
	if player != null:
		if canAttack:
			var dir = player.global_position - global_position
			$Tentacle.rotation = dir.angle()
			$AnimationPlayer.play("TentacleAttack")
		elif canShoot:
			Shoot()

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		canAttack = true
		print("in range to attack")


func _on_Area2D2_body_exited(body):
	canAttack = false
	print("out of range to attack")
	
