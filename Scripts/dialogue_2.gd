extends Control

var resource = load("res://dialogue/lore.dialogue")

@onready var dialogue_label = $Panel/RichTextLabel/DialogueLabel

func _ready() -> void:
	# Use the DialogueResource helper to step through lines. Provide `self` as a temporary game state
	# so any dialogue that references `self` can access this node if needed.
	var next_id: String = "start"
	while true:
		var line = await resource.get_next_dialogue_line(next_id, [self])
		if not line:
			break
		# The addon DialogueLabel accepts a DialogueLine via `dialogue_line` and will handle typing.
		dialogue_label.dialogue_line = line
		# Wait until the label has finished typing. The DialogueLabel exposes `finished_typing` in the addon.
		if dialogue_label.has_method("finished_typing"):
			# If finished_typing is a Signal, yield on it; otherwise wait a short frame as fallback.
			if dialogue_label.finished_typing is Signal:
				await dialogue_label.finished_typing
			else:
				# Fallback: give the engine a tick so UI updates
				await Engine.get_main_loop().process_frame
		# Advance to the next line
		next_id = line.next_id

