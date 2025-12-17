class_name PlayingCard
extends Resource

enum Suit { CLUBS, DIAMONDS, HEARTS, SPADES }
enum Rank {
	TWO = 2,
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
	return Rank.keys()[Rank.values().find(rank)]

func suit_name() -> String:
	return Suit.keys()[Suit.values().find(suit)]

func rank_abbr() -> String:
	match rank:
		Rank.JACK: return "J"
		Rank.QUEEN: return "Q"
		Rank.KING: return "K"
		Rank.ACE: return "A"
		_: return str(rank)
		
func suit_abbr() -> String:
	match suit:
		Suit.CLUBS: return "C"
		Suit.DIAMONDS: return "D"
		Suit.HEARTS: return "H"
		Suit.SPADES: return "S"
		_: return "E"
