extends Node
@warning_ignore_start("unused_signal")

signal playing_card_toggled(card: PlayingCardUI, selected: bool)
signal hand_played(cards: Array[PlayingCardUI])
signal hand_discarded(cards: Array[PlayingCardUI])

signal card_scored(card: PlayingCardUI)
signal hand_type_changed(hand_type: HandType)
signal hand_scored
