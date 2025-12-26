class_name FiveOfAKind
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	var rank_counts := {}

	for c in cards:
		var r = c.card.rank
		rank_counts[r] = rank_counts.get(r, 0) + 1

	for count in rank_counts.values():
		if count >= 5:
			return true

	return false
	
func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return cards
