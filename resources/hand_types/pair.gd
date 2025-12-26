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

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	var rank_to_cards := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		if !rank_to_cards.has(rank):
			rank_to_cards[rank] = []
		rank_to_cards[rank].append(card_ui)

	for rank in rank_to_cards.keys():
		if rank_to_cards[rank].size() >= 2:
			return [
				rank_to_cards[rank][0],
				rank_to_cards[rank][1]
			]

	return []
