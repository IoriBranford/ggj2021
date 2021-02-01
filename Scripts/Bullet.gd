extends Area2D

export (int) var speed
var move = Vector2.ZERO
var lookVec
var player

func _ready():
	lookVec = player.position - global_position
	
func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(lookVec, delta)
	move = move.normalized() * speed
	position += move
	


func _on_Timer_timeout():
	queue_free()
