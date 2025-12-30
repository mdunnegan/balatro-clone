class_name RunState
extends Resource

var jokers: Array[Joker] # TODO: Not fully used everywhere

var deck: PlayingCardPile

var hand_types: Array[HandType]

enum BlindType {
	SMALL_BLIND = 0,
	BIG_BLIND = 1,
	BOSS_BLIND = 2
}

var current_ante: int = 0
var current_blind: BlindType = BlindType.SMALL_BLIND

var required_scores := []

func get_required_score() -> int:
	return required_scores[current_ante][current_blind]

func initialize_required_scores() -> void:
	var a1 = [300, 450, 600]
	var a2 = [1000, 1500, 2000]
	var a3 = [3000, 4500, 6000]
	var a4 = [8000, 12000, 16000]
	var a5 = [20000, 30000, 40000]
	
	required_scores.append(a1)
	required_scores.append(a2)
	required_scores.append(a3)
	required_scores.append(a4)
	required_scores.append(a5)

func move_to_next_blind() -> void:
	if current_blind == BlindType.BOSS_BLIND:
		current_ante += 1
		current_blind = BlindType.SMALL_BLIND
	elif current_blind == BlindType.BIG_BLIND:
		current_blind = BlindType.BOSS_BLIND
	else:
		current_blind = BlindType.BIG_BLIND
