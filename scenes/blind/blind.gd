class_name Blind
extends Node2D

const PLAYING_CARD_UI := preload("res://scenes/playing_card_ui.tscn")

@onready var hand: HBoxContainer = %Hand
@onready var hand_type: Label = %HandType

@export var playing_cards: Array[PlayingCard]

var selected_cards: Array[PlayingCardUI]

func _ready() -> void:
	Events.playing_card_toggled.connect(_on_playing_card_toggled)
	draw_hand()
	
func _on_playing_card_toggled(card: PlayingCardUI, selected: bool) -> void:
	if selected:
		selected_cards.append(card)
	else:
		selected_cards.erase(card)
	
	resolve_hand_type()
	
func resolve_hand_type() -> void:
	var num_selected_cards = 0
	for card: PlayingCardUI in hand.get_children():
		if card.selected == true:
			num_selected_cards += 1
	
	hand_type.text = str(num_selected_cards)

func draw_hand() -> void:
	var card1: PlayingCard = PlayingCard.create(PlayingCard.Rank.ACE, PlayingCard.Suit.SPADES)
	var card2: PlayingCard = PlayingCard.create(PlayingCard.Rank.KING, PlayingCard.Suit.HEARTS)
	var card3: PlayingCard = PlayingCard.create(PlayingCard.Rank.QUEEN, PlayingCard.Suit.DIAMONDS)
	var card4: PlayingCard = PlayingCard.create(PlayingCard.Rank.TEN, PlayingCard.Suit.CLUBS)
	
	playing_cards = [card1, card2, card3, card4]
	
	for card: PlayingCard in playing_cards:
		var playing_card_ui = PLAYING_CARD_UI.instantiate()
		playing_card_ui.card = card
	
		hand.add_child(playing_card_ui)
