class_name Blind
extends Node2D

const PLAYING_CARD_UI := preload("res://scenes/playing_card_ui.tscn")
const FLUSH_FIVE_HAND_TYPE := preload("res://resources/hand_types/flush_five.tres")
const FLUSH_HOUSE_HAND_TYPE := preload("res://resources/hand_types/flush_house.tres")
const FIVE_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/five_of_a_kind.tres")
const STRAIGHT_FLUSH_HAND_TYPE := preload("res://resources/hand_types/straight_flush.tres")
const FOUR_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/four_of_a_kind.tres")
const FULL_HOUSE_HAND_TYPE := preload("res://resources/hand_types/full_house.tres")
const FLUSH_HAND_TYPE := preload("res://resources/hand_types/flush.tres")
const STRAIGHT_HAND_TYPE := preload("res://resources/hand_types/straight.tres")
const THREE_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/three_of_a_kind.tres")
const TWO_PAIR_HAND_TYPE := preload("res://resources/hand_types/two_pair.tres")
const PAIR_HAND_TYPE := preload("res://resources/hand_types/pair.tres")
const HIGH_CARD_HAND_TYPE := preload("res://resources/hand_types/high_card.tres")
const NONE_HAND_TYPE := preload("res://resources/hand_types/none.tres")

@onready var hand: HBoxContainer = %Hand
@onready var hand_type_label: Label = %HandType
@onready var play_button: Button = %PlayButton
@onready var discard_button: Button = %DiscardButton
@onready var card_play_area: HBoxContainer = %CardPlayArea

@export var max_hand_size: int = 8
@export var deck: CardPile

var selected_cards: Array[PlayingCardUI]
var hand_types: Array[HandType]

var current_hand_type: HandType

func _ready() -> void:
	_create_hand_types()	
	
	if !hand.is_node_ready():
		await ready
	
	_update_play_discard_buttons()
	
	# clear the placeholder cards
	for c in hand.get_children():
		c.queue_free()
	
	Events.playing_card_toggled.connect(_on_playing_card_toggled)
	Events.hand_scored.connect(_on_hand_scored)
	
	# initialize standard deck
	deck = CardPile.new()
	deck.build_standard_deck()
	deck.shuffle()
	
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
		playing_card_ui.card = deck.draw_card()
		hand.add_child(playing_card_ui)	

func _on_play_button_pressed() -> void:
	Events.hand_played.emit(selected_cards, current_hand_type)

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
	
func _create_hand_types() -> void:
	hand_types.append(FLUSH_FIVE_HAND_TYPE)
	hand_types.append(FLUSH_HOUSE_HAND_TYPE)
	hand_types.append(FIVE_OF_A_KIND_HAND_TYPE)
	hand_types.append(STRAIGHT_FLUSH_HAND_TYPE)
	hand_types.append(FOUR_OF_A_KIND_HAND_TYPE)
	hand_types.append(FULL_HOUSE_HAND_TYPE)
	hand_types.append(FLUSH_HAND_TYPE)
	hand_types.append(STRAIGHT_HAND_TYPE)
	hand_types.append(THREE_OF_A_KIND_HAND_TYPE)
	hand_types.append(TWO_PAIR_HAND_TYPE)
	hand_types.append(PAIR_HAND_TYPE)
	hand_types.append(HIGH_CARD_HAND_TYPE)
	hand_types.append(NONE_HAND_TYPE)

func _set_hand_type() -> void:
	for hand_type: HandType in hand_types:
		if hand_type.matches(selected_cards):
			current_hand_type = hand_type
			hand_type_label.text = hand_type.display_name
			Events.hand_type_changed.emit(hand_type)
			return
			
	hand_type_label.text = ""

func _update_play_discard_buttons() -> void:
	play_button.disabled = selected_cards.is_empty()
	discard_button.disabled = selected_cards.is_empty()
