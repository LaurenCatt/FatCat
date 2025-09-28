extends Area2D
@onready var gamemanager: Node = %GameManager
@onready var player = $"../FatCat"




func _on_body_entered(player) -> void:
	if !player.can_eat:
		gamemanager.add_speed()
