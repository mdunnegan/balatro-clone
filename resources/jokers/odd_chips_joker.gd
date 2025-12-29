class_name OddChipsJoker
extends Joker

var chips := 31

func description() -> String:
	return "Odd cards give +%s chips" % str(chips)

func applies_for_card(card_ui: PlayingCardUI) -> bool:
	return card_ui.card.chip_value() % 2 == 1

func apply_for_card(score_manager: ScoreManager, _card_ui: PlayingCardUI) -> void:
	score_manager.add_chips(chips)
