extends CharacterBody2D



var can_attack: bool = true

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
	
	if can_attack:
		if !velocity:  
			animated_sprite.play("idle")
		if velocity:
			animated_sprite.play("moving")
	if Input.is_action_pressed("attack") and can_attack:
		
		var slash_markers = $slash.get_children()
		var selected_slash = slash_markers[randi()%slash_markers.size()]
		
		animated_sprite.play("attack")
		can_attack = false
		$attackTimer.start()
		slash.emit(selected_slash.global_position,direction)
		
		
	if Input.is_action_just_pressed("eating") and can_eat:
		print("can eat")
		



	



func _on_attack_timer_timeout() -> void:
	can_attack = true
	
