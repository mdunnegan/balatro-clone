class_name PlayingCardUI
extends Control

@export var selected := false
@export var card: PlayingCard

@onready var label: Label = $Label
@onready var color: ColorRect = $Color

var num_cards_selected := 0

func _ready():
	# makes the card scale from the center when popping	
	pivot_offset = size / 2
	
	# magically prevents the cards from resizing when the reparent from the hand to the card play area
	size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	if !is_node_ready():
		await ready
	
	# Programmatically set the color rect to not eat the click
	color.mouse_filter = Control.MOUSE_FILTER_IGNORE
	gui_input.connect(_on_gui_input)
	label.text = "%s %s" % [card.rank_abbr(), card.suit_abbr()]
	
	Events.playing_card_toggled.connect(_on_playing_card_toggled)
	Events.hand_played.connect(_on_hand_played)
	Events.hand_discarded.connect(_on_hand_discarded)
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if selected:
			mark_as_unselected()
			toggle_selected()
			Events.playing_card_toggled.emit(self, false)
		else:
			if num_cards_selected < 5:
				mark_as_selected()
				toggle_selected()
				Events.playing_card_toggled.emit(self, true)
				
func mark_as_selected() -> void:
	position.y -= 10
	
func mark_as_unselected() -> void:
	position.y += 10

func toggle_selected() -> void:
	selected = !selected

func _on_playing_card_toggled(_card: PlayingCardUI, is_selected: bool) -> void:
	if is_selected:
		num_cards_selected += 1
	else:
		num_cards_selected -= 1
	
func _on_hand_played(_cards: Array[PlayingCardUI], _hand_type: HandType) -> void:
	num_cards_selected = 0

func _on_hand_discarded(_cards: Array[PlayingCardUI]) -> void:
	num_cards_selected = 0
