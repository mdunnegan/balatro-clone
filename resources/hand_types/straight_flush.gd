class_name StraightFlush
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 5:
		return false

	var suit_to_ranks := {} # suit -> Dictionary(rank -> true)

	for card_ui in cards:
		var suit: int = card_ui.card.suit
		var rank: int = card_ui.card.rank

		if not suit_to_ranks.has(suit):
			suit_to_ranks[suit] = {}
		suit_to_ranks[suit][rank] = true

	for suit in suit_to_ranks.keys():
		var ranks: Array[int] = []

		# keys() is untyped, so we copy into a typed array
		for r in suit_to_ranks[suit].keys():
			ranks.append(int(r))

		ranks.sort()

		# Ace-low support (A,2,3,4,5)
		if ranks.has(PlayingCard.Rank.ACE):
			ranks.append(-1)

		var run := 1
		for i in range(1, ranks.size()):
			if ranks[i] == ranks[i - 1] + 1:
				run += 1
				if run >= 5:
					return true
			elif ranks[i] != ranks[i - 1]:
				run = 1

	return false

func scoring_cards(cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return cards
