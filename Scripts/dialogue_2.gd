extends Control

var resource = load("res://dialogue/lore.dialogue")

func _ready():
	var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start") 
	dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	
