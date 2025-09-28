extends Resource

class_name Spawn_info

@export var enemy: PackedScene
@export var enemy_num: int =5
@export var enemy_spawnsdelay: int = 2
@export var time_start: float = 2
@export var time_end: float = 9999.0

var spawn_delay_counter: int = 0
