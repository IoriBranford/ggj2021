extends KinematicBody2D

onready var BulletScene = preload("res://Scenes/Bullet.tscn")

export (int) var speed
var player : Node2D = null
var canShoot = true


func Shoot():
	var bullet = BulletScene.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child((bullet))
	
func _on_Timer_timeout():
	if canShoot  and player != null:
		Shoot()

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		canShoot = true


func _on_Area2D2_body_exited(body):
	if body.name == "Player":
		canShoot = false


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body
	
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player = null
