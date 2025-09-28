extends CharacterBody2D


@export var  speed: float = 90
@export var player_path: NodePath
var health = 1
var player: CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

#aggro settings
#enemy chases a little after losing sight
@export var aggro_radius: float = 600
@export var aggro_pursue_time: float = 3.0
var _is_aggro: bool = false
var _last_seen: float = 0.0

func _ready():
	# Resolve player either via exported player_path (if valid) or fallback to 'player' group
	if player == null:
		if player_path != NodePath("") and has_node(player_path):
			player = get_node(player_path)
		else:
			var players: Array = get_tree().get_nodes_in_group("player")
			if players.size() > 0:
				player = players[0]
	
func _physics_process(_delta:float) -> void:
	if not player:
		return

	var now = Time.get_ticks_msec() / 1000.0
	var dist = global_position.distance_to(player.global_position)

	# Enter aggro when player within radius
	if dist <= aggro_radius:
		_is_aggro = true
		_last_seen = now

	# If currently aggro and within pursue window, chase
	if _is_aggro and (now - _last_seen) <= aggro_pursue_time:
		var diff = player.global_position - global_position
		var dir: Vector2 = Vector2.ZERO 
		if diff.length() > 0.001: 
			dir = diff.normalized()
		velocity = dir * speed
		move_and_slide()
		_update_animation(dir)
	else:
		# Not aggro: stop movement (replace with patrol/wander if desired)
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation(Vector2.ZERO)

	
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
				
