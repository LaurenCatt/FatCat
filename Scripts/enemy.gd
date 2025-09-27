extends CharacterBody2D

<<<<<<< HEAD

@export var  speed: float = 90
@export var player_path: NodePath

var player: CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
=======
@export var speed = 90
@export var player_path: NodePath

var player: Node2D

@onready var anime: AnimatedSprite2D = $AnimatedSprite2D
>>>>>>> 66032fa2c7d60b375560fc0432ab26356dc25992

func _ready():
	player = get_node(player_path)
	
func _physics_process(delta):
	if not player:
		return
<<<<<<< HEAD

	var dir= (player.global_position - global_position).normalized()
	velocity= dir * speed
	move_and_slide()
	_update_animation(dir)

func _update_animation(dir: Vector2):
=======
		
var direction= (player.global_position - global_position).normalized()

velocity = dir * speed
move_and_slide()

_update_animation(dir)

func _update_animation(dir):
>>>>>>> 66032fa2c7d60b375560fc0432ab26356dc25992
		if dir == Vector2.ZERO:
			anim.stop()
			return
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
<<<<<<< HEAD
				anim.play("right")
			else:
				anim.play("left")
		else:
			if abs(dir.y) > 0:
				anim.play("down")
			else:
				anim.play("up")
=======
				anim.play("walk_right")
			else:
				anim.play("walk_left")
		else:
			if abs(dir.y) > 0:
				anim.play("walk_back")
			else:
				anim.play("walk_up")
>>>>>>> 66032fa2c7d60b375560fc0432ab26356dc25992
	
