extends Node
@onready var player= $"../FatCat"
@onready var cat_nip = $"../items/cat_nip"
@onready var treat = $"../items/treat"
func _ready() -> void:
	for i in 100:
		i+25
		var cat_nip2 = cat_nip.duplicate()
		var treat2 = treat.duplicate()
		cat_nip2.position.x = randf_range(0,100)
		cat_nip2.position.x= randf_range(0,100)
		cat_nip2 = cat_nip
		

func add_health():
	player.player_health+=2
	player.velocity=player.velocity/5
	
func add_speed():
	player.player_health-=2
	player.velocity*=5
	
		
		



	



	
