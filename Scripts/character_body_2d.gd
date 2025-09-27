extends CharacterBody2D
var can_attack: bool = true

var can_eat: bool = true
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	var direction = Input.get_vector("left", "right","up","down")
	velocity = direction*500
	move_and_slide()
	
	
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position()-position).normalized()
	if !velocity:  
		animated_sprite.play("idle")
	if velocity:
		animated_sprite.play("moving")
	if Input.is_action_just_pressed("attack")and can_attack:
		animated_sprite.play("attack")
		can_attack = false
		
	
		
	if Input.is_action_just_pressed("eating") and can_eat:
		print("can eat")
		


func _on_timer_timeout() -> void:
	pass # Replace with function body.
