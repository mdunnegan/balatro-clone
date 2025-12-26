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
	var rank_to_cards: Dictionary = {} # rank -> Array (of PlayingCardUI)

	for card_ui in cards:
		var rank: int = card_ui.card.rank
		if not rank_to_cards.has(rank):
			rank_to_cards[rank] = []
		(rank_to_cards[rank] as Array).append(card_ui)

	var pairs: Array = [] # Array of Array (untyped by necessity)

	for rank in rank_to_cards.keys():
		var group := rank_to_cards[rank] as Array
		if group.size() >= 2:
			pairs.append(group)

	if pairs.size() < 2:
		return []

	var result: Array[PlayingCardUI] = []
	result.append_array((pairs[0] as Array).slice(0, 2))
	result.append_array((pairs[1] as Array).slice(0, 2))

	return result
