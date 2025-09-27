extends CharacterBody2D

@export var speed = 90
@export var player_path: NodePath

var player: Node2D

@onready var anime: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	player = get_node(player_path)
	
func _physics_process(delta):
	if not player:
		return
		
var direction= (player.global_position - global_position).normalized()

velocity = dir * speed
move_and_slide()

_update_animation(dir)

func _update_animation(dir):
		if dir == Vector2.ZERO:
			anim.stop()
			return
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				anim.play("walk_right")
			else:
				anim.play("walk_left")
		else:
			if abs(dir.y) > 0:
				anim.play("walk_back")
			else:
				anim.play("walk_up")
	
