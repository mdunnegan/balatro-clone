class_name Pair
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	var seen_ranks := {}
	
	for playing_card: PlayingCardUI in cards:
		var rank = playing_card.card.rank
		if seen_ranks.has(rank):
			return true
		seen_ranks[rank] = true
	
	return false
