extends Node2D

@export var spawns: Array[Spawn_info] = []
@onready var player = get_tree().get_first_node_in_group("player")
@onready var spawn_markers: Array = $SpawnPoints.get_children()

var time: float = 0



func _on_timer_timeout() -> void:
	time +=1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time > i.time_start and time < i.time_end:
			if i.spawn_delay_counter < i.enemy_spawnsdelay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy= load(str(i.enemy.resource_path))				
				var counter = 0
				while counter<i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					var marker: Marker2D= spawn_markers.pick_random()
					enemy_spawn.global_position = marker.global_position
					add_child(enemy_spawn) 
					counter += 1
