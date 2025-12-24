class_name Blind
extends Node2D

const PLAYING_CARD_UI := preload("res://scenes/playing_card_ui.tscn")

@onready var hand: HBoxContainer = %Hand
@onready var hand_type_label: Label = %HandType
@onready var play_button: Button = %PlayButton
@onready var discard_button: Button = %DiscardButton
@onready var card_play_area: HBoxContainer = %CardPlayArea

@export var max_hand_size: int = 8
@export var deck: CardPile

var selected_cards: Array[PlayingCardUI]
var hand_types: Array[HandType]

func _ready() -> void:
	create_hand_types()	
		
	if !hand.is_node_ready():
		await ready
	
	# clear the placeholders
	for c in hand.get_children():
		c.queue_free()
	
	Events.playing_card_toggled.connect(_on_playing_card_toggled)
	
	# initialize standard deck
	deck = CardPile.new()
	deck.build_standard_deck()
	deck.shuffle()
	
	draw_hand(max_hand_size)
	
func _on_playing_card_toggled(card: PlayingCardUI, selected: bool) -> void:
	if selected:
		selected_cards.append(card)
	else:
		selected_cards.erase(card)
	
	resolve_hand_type()

func draw_hand(num_to_draw: int) -> void:
	print("drawing %s cards" % num_to_draw)

	for i in range(num_to_draw):
		var playing_card_ui = PLAYING_CARD_UI.instantiate()
		playing_card_ui.card = deck.draw_card()
		hand.add_child(playing_card_ui)	

func _on_play_button_pressed() -> void:
	var num_cards_to_draw := selected_cards.size()
	print("pressed play button")

	play_hand()

func play_hand() -> void:
	Events.hand_played.emit(selected_cards)
	
func create_hand_types() -> void:
	hand_types.append(preload("res://resources/hand_types/pair.tres"))
	hand_types.append(preload("res://resources/hand_types/high_card.tres"))
	
	# excluded "none" because we don't want to consider this when showing the name

func resolve_hand_type() -> void:
	for hand_type: HandType in hand_types:
		if hand_type.matches(selected_cards):
			hand_type_label.text = hand_type.display_name
			Events.hand_type_changed.emit(hand_type)
			return
			
	hand_type_label.text = ""
