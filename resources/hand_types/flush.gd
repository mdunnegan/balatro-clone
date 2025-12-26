class_name Flush
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 5:
		return false

	var suit_counts := {}

	for card_ui in cards:
		var suit = card_ui.card.suit
		suit_counts[suit] = suit_counts.get(suit, 0) + 1

	for count in suit_counts.values():
		if count >= 5:
			return true

	return false

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return cards
