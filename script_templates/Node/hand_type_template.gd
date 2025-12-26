class_name MyHandType
extends HandType

func matches(_cards: Array[PlayingCardUI]) -> bool:
	return false
	
func scoring_cards(_cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return []
