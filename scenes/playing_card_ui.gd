class_name PlayingCardUI
extends Control

@export var selected := false
@export var card: PlayingCard
@onready var label: Label = $Label

@onready var color: ColorRect = $Color

func _ready():
	if !is_node_ready():
		await ready
	
	# Programmatically set the color rect to not eat the click
	color.mouse_filter = Control.MOUSE_FILTER_IGNORE
	gui_input.connect(_on_gui_input)
	label.text = "%s %s" % [card.rank_abbr(), card.suit_abbr()]
	
func _on_gui_input(event: InputEvent) -> void: 
	if event.is_action_pressed("left_mouse"):
		if selected: # if currently selected
			position.y += 10
			toggle_selected()
			Events.playing_card_toggled.emit(self, false)
		else:
			position.y -= 10
			toggle_selected()
			Events.playing_card_toggled.emit(self, true)

func toggle_selected() -> void:
	selected = !selected
