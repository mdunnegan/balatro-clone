class_name HighCard
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.is_empty():
		return false

	return true

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	var highest: PlayingCardUI = cards[0]

	for card_ui in cards:
		if card_ui.card.rank > highest.card.rank:
			highest = card_ui

	return [highest]
