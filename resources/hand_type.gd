class_name HandType
extends Resource

enum HandKind {
	NONE,
	HIGH_CARD,
	PAIR,
	TWO_PAIR,
	THREE_OF_A_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	FOUR_OF_A_KIND,
	STRAIGHT_FLUSH
}

@export var hand_kind: HandKind
@export var display_name: String
@export var base_chips: int
@export var base_mult: int

func matches(cards: Array[PlayingCardUI]) -> bool:
	# overridden per hand
	return false
