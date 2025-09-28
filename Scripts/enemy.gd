extends CharacterBody2D


@export var  speed: float = 90
@export var player_path: NodePath
var health = 1
var player: CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if player_path != NodePath(""):
		player = get_node(player_path)
	
func _physics_process(_delta:float) -> void:
	if not player:
		return

	var dir: Vector2 = (player.global_position - global_position).normalized()
	velocity= dir * speed
	move_and_slide()
	_update_animation(dir)

	
func _update_animation(dir: Vector2):
		if dir == Vector2.ZERO:
			anim.stop()
			return
			
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				anim.play("right")
			else:
				anim.play("left")
		else:
			if abs(dir.y) > 0:
				anim.play("back")
			else:
				anim.play("up")
				
