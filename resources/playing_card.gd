class_name PlayingCard
extends Resource

enum Suit {
	CLUBS,
	DIAMONDS,
	HEARTS,
	SPADES
}

enum Rank {
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE
}

const RANK_VALUES := {
	Rank.TWO:   2,
	Rank.THREE: 3,
	Rank.FOUR:  4,
	Rank.FIVE:  5,
	Rank.SIX:   6,
	Rank.SEVEN: 7,
	Rank.EIGHT: 8,
	Rank.NINE:  9,
	Rank.TEN:   10,
	Rank.JACK:  10,
	Rank.QUEEN: 10,
	Rank.KING:  10,
	Rank.ACE:   11
}

@export var suit: Suit
@export var rank: Rank

static func create(new_rank: Rank, new_suit: Suit) -> PlayingCard:
	var card := PlayingCard.new()
	card.rank = new_rank
	card.suit = new_suit
	return card

func rank_name() -> String:
	return Rank.keys()[rank].capitalize()

func suit_name() -> String:
	return Suit.keys()[suit].capitalize()

func chip_value() -> int:
	return RANK_VALUES[rank]

func rank_abbr() -> String:
	match rank:
		Rank.JACK:  return "J"
		Rank.QUEEN: return "Q"
		Rank.KING:  return "K"
		Rank.ACE:   return "A"
		_:
			return str(RANK_VALUES[rank])

func suit_abbr() -> String:
	match suit:
		Suit.CLUBS:    return "C"
		Suit.DIAMONDS: return "D"
		Suit.HEARTS:   return "H"
		Suit.SPADES:   return "S"
		_:
			return "?"

func debug_string() -> String:
	return "%s of %s" % [rank_name(), suit_name()]
