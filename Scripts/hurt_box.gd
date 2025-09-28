extends Area2D
@onready var player: CharacterBody2D  = %fat_cat


func _on_area_entered(area: Area2D) -> void:
	player.player_health-=25
	
