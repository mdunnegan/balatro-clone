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
	STRAIGHT_FLUSH,
	FIVE_OF_A_KIND,
	FLUSH_HOUSE,
	FLUSH_FIVE
}

@export var hand_kind: HandKind
@export var display_name: String
@export var base_chips: int
@export var base_mult: int

func matches(_cards: Array[PlayingCardUI]) -> bool:
	return false

func scoring_cards(_cards: Array[PlayingCardUI]) -> Array[PlayingCardUI]:
	return []
