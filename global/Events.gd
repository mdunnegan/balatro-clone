extends Node
@warning_ignore_start("unused_signal")

signal playing_card_toggled(card: PlayingCardUI, selected: bool)
signal hand_type_changed(hand_type: HandType)

signal hand_played(cards: Array[PlayingCardUI], hand_type: HandType, jokers: Array[JokerUI])
signal hand_discarded(cards: Array[PlayingCardUI])

signal hand_scored
