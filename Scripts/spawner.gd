extends Node2D

@export var enemy_scene : PackedScene

# If true: each spawn picks a random marker independently.
# If false: visit all markers in a random shuffled order, then reshuffle.
@export var random_each_spawn: bool = true

# Markers should be child nodes of this Spawner (Position2D/Node2D) or empty to use spawner position.
var markers: Array = []
var _order: Array = []
var _order_idx: int = 0
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

#spawn interval values
@export var fix_spawn_interval: float = 1.0
@export var use_random_interval: bool = false
@export var min_spawn_interval: float = 0.5
@export var max_spawn_interval: float  = 2.0

#spawn interval according to val of marker
@export var per_marker_interval_meta: String = "spawn_interval"


func _ready() -> void:
	# Ensure the Spawner's Timer is running (some .tscn files don't set autostart).
	if has_node("Timer"):
		var t: Timer = $Timer
		if not t.is_stopped():
			# already running
			pass
		else:
			# Start
			t.start()

	# Initialize RNG and collect marker nodes (child Node2D/Position2D nodes)
	_rng.randomize()
	markers.clear()
	for child in get_children():
		if child is Node2D and child.name != "Timer":
			markers.append(child)

	# Prepare visit order when not using independent random picks
	if not random_each_spawn and markers.size() > 0:
		_reshuffle_order()


func _on_timer_timeout() -> void:
	if enemy_scene == null:
		return
	var enemy = enemy_scene.instantiate()
	# Choose spawn position: prefer marker positions if present
	var spawn_pos: Vector2 = position
	if markers.size() > 0:
		if random_each_spawn:
			var idx = _rng.randi_range(0, markers.size() - 1)
			spawn_pos = markers[idx].global_position
		else:
			# use shuffled visit order
			var marker = _order[_order_idx]
			spawn_pos = marker.global_position
			_order_idx += 1
			if _order_idx >= _order.size():
				_reshuffle_order()

	enemy.position = spawn_pos

	# Parent the enemy into the scene
	get_parent().add_child(enemy)

	# Try to wire the spawned enemy to the player so its AI can track the cat.
	# Prefer using the "player" group (FatCat in map.tscn is added to this group).
	var players: Array = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		enemy.player = players[0]
	else:
		# Fallback: look for a sibling node named "FatCat"
		if get_parent().has_node("FatCat"):
			enemy.player = get_parent().get_node("FatCat")


func _reshuffle_order() -> void:
	_order = markers.duplicate()
	# Fisher-Yates shuffle via RNG
	var n = _order.size()
	for i in range(n - 1, 0, -1):
		var j = _rng.randi_range(0, i)
		var tmp = _order[i]
		_order[i] = _order[j]
		_order[j] = tmp
	_order_idx = 0
