extends Node2D

@export var enemy_scene : PackedScene


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


func _on_timer_timeout() -> void:
	if enemy_scene == null:
		return
	var enemy = enemy_scene.instantiate()
	enemy.position = position
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
