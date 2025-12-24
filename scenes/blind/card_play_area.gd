class_name CardPlayArea
extends HBoxContainer

const CARD_POP_DURATION := 0.35

func _ready() -> void:
	Events.hand_played.connect(_on_hand_played)
	
func _on_hand_played(played_cards: Array[PlayingCardUI]) -> void:
	
	for card: PlayingCardUI in played_cards:
		card.reparent(self)
		
	await get_tree().create_timer(CARD_POP_DURATION).timeout
	
	# TODO: Determine scoring cards...

	for card in played_cards:
		# TODO: make a number appear above each card, and add that number to Chips
		
		# pop the card
		var tween := create_tween()
		tween.tween_property(card, "scale", Vector2(1.1, 1.1), CARD_POP_DURATION)\
			 .set_trans(Tween.TRANS_QUAD)\
			 .set_ease(Tween.EASE_OUT)
		tween.tween_property(card, "scale", Vector2.ONE, CARD_POP_DURATION)\
			 .set_trans(Tween.TRANS_QUAD)\
			 .set_ease(Tween.EASE_IN)
			
		Events.card_scored.emit(card)

		# wait before doing the next card
		await tween.finished
