extends Area2D
var player = preload("res://Scences/fat_cat.tscn")
var rat = preload("res://Scences/enemy.tscn")

func _on_body_entered(player) -> void:
	player.player_health-=10
	
