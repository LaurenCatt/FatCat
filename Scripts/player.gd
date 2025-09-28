extends CharacterBody2D

var player_health = 100



var can_eat: bool = true

signal slash(pos,direction)
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	var direction = Input.get_vector("left", "right","up","down")
	if direction.x >0:
		animated_sprite.flip_h = false
	if direction.x<0:
		animated_sprite.flip_h = true
		
	
	velocity = direction*500
	move_and_slide()
	
	if can_eat:
		if !velocity:  
			animated_sprite.play("idle")
		if velocity:
			animated_sprite.play("moving")
	if Input.is_action_pressed("pick_up") and can_eat:
		animated_sprite.play("piking up item")
		can_eat = false
		$eatTimer.start()
		
		
		



	




	


func _on_eat_timer_timeout() -> void:
	can_eat = true
