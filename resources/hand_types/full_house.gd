class_name FullHouse
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 5:
		return false

	var rank_counts := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		rank_counts[rank] = rank_counts.get(rank, 0) + 1

	var has_three := false
	var has_pair := false

	for count in rank_counts.values():
		if count >= 3:
			has_three = true
		elif count >= 2:
			has_pair = true

	return has_three and has_pair

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	var rank_to_cards := {}

	for card_ui in cards:
		var rank = card_ui.card.rank
		if !rank_to_cards.has(rank):
			rank_to_cards[rank] = []
		rank_to_cards[rank].append(card_ui)

	var three_cards: Array[PlayingCardUI] = []
	var pair_cards: Array[PlayingCardUI] = []

	for rank in rank_to_cards.keys():
		if rank_to_cards[rank].size() >= 3 and three_cards.is_empty():
			three_cards = rank_to_cards[rank].slice(0, 3)

	for rank in rank_to_cards.keys():
		if rank_to_cards[rank].size() >= 2 and (three_cards.is_empty() or rank_to_cards[rank][0].card.rank != three_cards[0].card.rank):
			pair_cards = rank_to_cards[rank].slice(0, 2)
			break

	if three_cards.is_empty() or pair_cards.is_empty():
		return []

	return three_cards + pair_cards
