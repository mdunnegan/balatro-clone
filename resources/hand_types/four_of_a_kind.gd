class_name FourOfAKind
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 4:
		return false

	var rank_counts := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		rank_counts[rank] = rank_counts.get(rank, 0) + 1

	for count in rank_counts.values():
		if count >= 4:
			return true

	return false

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	var rank_to_cards := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		if !rank_to_cards.has(rank):
			rank_to_cards[rank] = []
		rank_to_cards[rank].append(card_ui)

	for rank in rank_to_cards.keys():
		if rank_to_cards[rank].size() >= 4:
			return rank_to_cards[rank].slice(0, 4)

	return []
