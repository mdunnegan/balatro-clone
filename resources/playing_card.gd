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

@export var suit: Suit
@export var rank: Rank

static func create(rank: Rank, suit: Suit) -> PlayingCard:
	var card := PlayingCard.new()
	card.rank = rank
	card.suit = suit
	return card

func rank_name() -> String:
	return Rank.keys()[rank].capitalize()

func suit_name() -> String:
	return Suit.keys()[suit].capitalize()

func chip_value() -> int:
	match rank:
		Rank.JACK, Rank.QUEEN, Rank.KING:
			return 10
		Rank.ACE:
			return 11
		_:
			return rank + 2

func rank_abbr() -> String:
	match rank:
		Rank.JACK:  return "J"
		Rank.QUEEN: return "Q"
		Rank.KING:  return "K"
		Rank.ACE:   return "A"
		_:
			return str(rank + 2)

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
