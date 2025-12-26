class_name Straight
extends HandType

func matches(cards: Array[PlayingCardUI]) -> bool:
	if cards.size() < 5:
		return false

	var unique_ranks := {}

	for card_ui in cards:
		var rank: int = card_ui.card.rank
		unique_ranks[rank] = true

	var ranks := unique_ranks.keys()
	ranks.sort()

	# Ace low support (A acts as -1 below TWO)
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
