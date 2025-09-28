extends Control

var resource = load("res://dialogue/lore.dialogue")

@onready var dialogue_label = $Panel/RichTextLabel/DialogueLabel

func _ready() -> void:
	# Use the DialogueResource helper to step through lines. Provide `self` as a temporary game state
	# so any dialogue that references `self` can access this node if needed.
	var next_id: String = "start"
	while true:
		var line = await resource.get_next_dialogue_line(next_id)
		if not line:
			break
		# The addon DialogueLabel accepts a DialogueLine via `dialogue_line` and will handle typing.
		dialogue_label.dialogue_line = line
		# Start typing and wait for the `finished_typing` signal emitted by DialogueLabel
		if dialogue_label.has_method("type_out"):
			dialogue_label.type_out()
			# Wait for the signal
			await dialogue_label.finished_typing
		else:
			# Fallback: just show the text if the custom method isn't available
			dialogue_label.text = line.text
		# Advance to the next line
		next_id = line.next_id
