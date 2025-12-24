class_name HighCard
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.is_empty():
		return false

	return true
