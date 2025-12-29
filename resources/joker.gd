class_name Joker
extends Resource

func applies_pre_hand(_hand_kind: HandType.HandKind) -> bool:
	return false
	
func apply_pre_hand(_score_manager: ScoreManager, _hand_kind: HandType.HandKind) -> void:
	pass
	
func applies_for_card(_card_ui: PlayingCardUI) -> bool:
	return false

func apply_for_card(_score_manager: ScoreManager, _card_ui: PlayingCardUI) -> void:
	pass

func applies_post_hand(_hand_kind: HandType.HandKind) -> bool:
	return false
	
func apply_post_hand(_score_manager: ScoreManager, _hand_kind: HandType.HandKind) -> void:
	pass
