extends Node
@onready var player= $"../FatCat"
@onready var cat_nip = $"../items/cat_nip"
@onready var treat = $"../items/treat"
		

func add_health():
	player.player_health+=2
	player.velocity=player.velocity/5
	
func add_speed():
	player.player_health-=2
	player.velocity*=5
	
		
		



	



	
