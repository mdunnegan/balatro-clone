class_name FlushHouse
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 5:
		return false

	var suit_to_rank_counts := {} # suit -> Dictionary(rank -> int)

	for c in cards:
		var s: int = c.card.suit
		var r: int = c.card.rank

		if not suit_to_rank_counts.has(s):
			suit_to_rank_counts[s] = {}

		var rank_counts: Dictionary = suit_to_rank_counts[s]
		rank_counts[r] = rank_counts.get(r, 0) + 1

	for s in suit_to_rank_counts.keys():
		var rank_counts: Dictionary = suit_to_rank_counts[s]

		var has_three := false
		var has_pair := false

		for count in rank_counts.values():
			if int(count) >= 3:
				has_three = true
			elif int(count) >= 2:
				has_pair = true

		if has_three and has_pair:
			return true

	return false
	
func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return cards
