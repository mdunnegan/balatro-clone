class_name PairMultJoker
extends Joker

var mult := 8

func description() -> String:
	return "Pair gives +%s mult" % str(mult)

func applies_post_hand(hand_kind: HandType.HandKind) -> bool:
	return hand_kind == HandType.HandKind.PAIR

func apply_post_hand(score_manager: ScoreManager, _hand_kind: HandType.HandKind) -> void:
	score_manager.add_mult(mult)
