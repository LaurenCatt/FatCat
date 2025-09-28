extends Node2D
@onready var rat1= $Rats
@onready var rat2= $Rat2
@onready var rat3= $Rat3

func _process(delta: float) -> void:
	if rat1.health<=0:
		rat1.queue_free()
	if rat2.health<=0:
		rat2.queue_free()
	if rat3.health<=0:
		rat3.queue_free()
		
		



	
