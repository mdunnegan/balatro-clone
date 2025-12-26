class_name TwoPair
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 4:
		return false

	var rank_counts := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		rank_counts[rank] = rank_counts.get(rank, 0) + 1

	var pair_like_ranks := 0

	for count in rank_counts.values():
		if count >= 2:
			pair_like_ranks += 1

	return pair_like_ranks >= 2

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	var rank_to_cards := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		if !rank_to_cards.has(rank):
			rank_to_cards[rank] = []
		rank_to_cards[rank].append(card_ui)

	var pairs: Array[Array] = []

	for rank in rank_to_cards.keys():
		if rank_to_cards[rank].size() >= 2:
			pairs.append(rank_to_cards[rank])

	if pairs.size() < 2:
		return []

	# take the first two pairs found
	return pairs[0].slice(0, 2) + pairs[1].slice(0, 2)
