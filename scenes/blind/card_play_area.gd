class_name CardPlayArea
extends HBoxContainer

const CARD_MOVE_DURATION := 0.15
const CARD_POP_DURATION := 0.35
const SEQUENCE_PAUSE_DURATION := 0.25

func _ready() -> void:
	Events.hand_played.connect(_on_hand_played)
	
func _on_hand_played(played_cards: Array[PlayingCardUI], hand_type: HandType) -> void:
	
	for card: PlayingCardUI in played_cards:
		card.reparent(self)
		
	await get_tree().create_timer(CARD_POP_DURATION).timeout
	
	var scoring_cards := hand_type.scoring_cards(played_cards)

	await get_tree().create_timer(SEQUENCE_PAUSE_DURATION).timeout
	
	for card: PlayingCardUI in scoring_cards:
		var tween := create_tween()
		tween.tween_property(card, "position:y", card.position.y - 10, CARD_MOVE_DURATION)
		await tween.finished
		await get_tree().create_timer(0.1).timeout
		
	await get_tree().create_timer(SEQUENCE_PAUSE_DURATION * 2).timeout

	for card in scoring_cards:
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
		await tween.finished
		
	Events.hand_scored.emit()

func clear_cards() -> void:
	for card: PlayingCardUI in get_children():
		card.queue_free()
