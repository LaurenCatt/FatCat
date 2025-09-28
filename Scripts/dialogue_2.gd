extends Control

var resource = load("res://dialogue/lore.dialogue")

@onready var dialogue_label = $Panel/RichTextLabel/DialogueLabel
@onready var character_label = $Panel/CharacterLabel

func _ready() -> void:
	# Use the DialogueResource helper to step through lines. Provide `self` as a temporary game state
	# so any dialogue that references `self` can access this node if needed.
	var next_id: String = "start"
	while true:
		var line = await resource.get_next_dialogue_line(next_id)
		if not line:
			break
		# Set speaker name and the line. The addon DialogueLabel accepts a DialogueLine via `dialogue_line` and will handle typing.
		character_label.text = line.character
		dialogue_label.dialogue_line = line
		var input_pressed_during_typing: bool = false
		# Start typing and allow the player to skip with spacebar or left-click while typing.
		if dialogue_label.has_method("type_out"):
			dialogue_label.type_out()
			# Poll while typing so we can detect input to skip typing.
			var prev_mouse_pressed: bool = Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)
			while dialogue_label.is_typing:
				await get_tree().process_frame
				# Check space/enter
				if Input.is_action_just_pressed("ui_accept"):
					dialogue_label.skip_typing()
					input_pressed_during_typing = true
					continue
				# Check left mouse just pressed
				var mouse_pressed: bool = Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)
				if mouse_pressed and not prev_mouse_pressed:
					dialogue_label.skip_typing()
					input_pressed_during_typing = true
				prev_mouse_pressed = mouse_pressed
		else:
			# Fallback: just show the text if the custom method isn't available
			dialogue_label.text = line.text
			# No typing to skip, so treat as if no input occurred during typing
			input_pressed_during_typing = false

		# If the player clicked/pressed while typing, advance immediately; otherwise wait for input to progress.
		if input_pressed_during_typing:
			# small frame to let the UI settle
			await get_tree().process_frame
		else:
			# Wait for spacebar or left-click
			var prev_mouse: bool = Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)
			while true:
				await get_tree().process_frame
				if Input.is_action_just_pressed("ui_accept"):
					break
				var mouse_now: bool = Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT)
				if mouse_now and not prev_mouse:
					break
				prev_mouse = mouse_now
		# Advance to the next line
		next_id = line.next_id
	
	get_tree().change_scene_to_file("res://Scences/map.tscn")
