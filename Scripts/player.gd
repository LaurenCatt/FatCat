extends CharacterBody2D

var player_health = 100



@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	var direction = Input.get_vector("left", "right","up","down")
	if direction.x >0:
		animated_sprite.flip_h = false
	if direction.x<0:
		animated_sprite.flip_h = true
		
	
	velocity = direction*500
	move_and_slide()
	
	if !velocity:  
		animated_sprite.play("idle")
	if velocity:
		animated_sprite.play("moving")
	
		
		
		



	




	
