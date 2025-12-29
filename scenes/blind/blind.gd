class_name Blind
extends Node2D

const PLAYING_CARD_UI := preload("res://scenes/playing_card_ui.tscn")
const NONE_HAND_TYPE := preload("res://resources/hand_types/none.tres")

@onready var hand: HBoxContainer = %Hand
@onready var hand_type_label: Label = %HandType
@onready var play_button: Button = %PlayButton
@onready var discard_button: Button = %DiscardButton
@onready var card_play_area: HBoxContainer = %CardPlayArea

@export var max_hand_size: int = 8
@export var run_state: RunState

var selected_cards: Array[PlayingCardUI]
var jokers: Array[JokerUI]

var current_hand_type: HandType

func _ready() -> void:
	if !hand.is_node_ready():
		await ready
	
	_update_play_discard_buttons()
	
	# clear the placeholder cards
	for c in hand.get_children():
		c.free()
	
	Events.playing_card_toggled.connect(_on_playing_card_toggled)
	Events.hand_scored.connect(_on_hand_scored)

func begin_blind() -> void:
	draw_cards(max_hand_size)
	
func _on_playing_card_toggled(card: PlayingCardUI, selected: bool) -> void:
	if selected:
		selected_cards.append(card)
	else:
		selected_cards.erase(card)
	
	_update_play_discard_buttons()
	_set_hand_type()

func draw_cards(num_to_draw: int) -> void:
	current_hand_type = NONE_HAND_TYPE
	for i in range(num_to_draw):
		var playing_card_ui = PLAYING_CARD_UI.instantiate()
		playing_card_ui.card = run_state.deck.draw_card()
		hand.add_child(playing_card_ui)	

func _on_play_button_pressed() -> void:
	Events.hand_played.emit(selected_cards, current_hand_type, jokers)

func _on_discard_button_pressed() -> void:
	var num_selected = selected_cards.size()
	for card: PlayingCardUI in selected_cards:
		card.queue_free()
	selected_cards = []
	draw_cards(num_selected)
	_set_hand_type()
	_update_play_discard_buttons()
	Events.hand_discarded.emit(selected_cards)

func _on_hand_scored() -> void:
	card_play_area.clear_cards()
	var num_selected = selected_cards.size()
	selected_cards = []
	draw_cards(num_selected)
	_set_hand_type()
	_update_play_discard_buttons()
	

func _set_hand_type() -> void:
	for hand_type: HandType in run_state.hand_types:
		if hand_type.matches(selected_cards):
			current_hand_type = hand_type
			hand_type_label.text = hand_type.display_name
			Events.hand_type_changed.emit(hand_type)
			return
			
	hand_type_label.text = ""

func _update_play_discard_buttons() -> void:
	play_button.disabled = selected_cards.is_empty()
	discard_button.disabled = selected_cards.is_empty()
