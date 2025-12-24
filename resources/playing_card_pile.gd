class_name CardPile
extends Resource

@export var cards: Array[PlayingCard] = []

func build_standard_deck() -> void:
	cards.clear()

	for suit in PlayingCard.Suit.values():
		for rank in PlayingCard.Rank.values():
			var card := PlayingCard.create(rank, suit)
			cards.append(card)

func is_empty() -> bool:
	return cards.is_empty()
	
func draw_card() -> PlayingCard:
	var card = cards.pop_front();
	return card

func add_card(card: PlayingCard):
	cards.append(card)

func shuffle() -> void:
	cards.shuffle()
	
func clear() -> void:
	cards.clear()
