class_name CardPlayArea
extends HBoxContainer

const CARD_MOVE_DURATION := 0.15
const CARD_POP_DURATION := 0.35
const SEQUENCE_PAUSE_DURATION := 0.25

@onready var score_manager: ScoreManager = %ScoreManager

func _ready() -> void:
	Events.hand_played.connect(_on_hand_played)
	
func _on_hand_played(played_cards: Array[PlayingCardUI], hand_type: HandType, jokers: Array[JokerUI]) -> void:
	
	for card_ui: PlayingCardUI in played_cards:
		card_ui.reparent(self)
		
	await get_tree().create_timer(CARD_POP_DURATION).timeout
	
	var scoring_cards := hand_type.scoring_cards(played_cards)

	await get_tree().create_timer(SEQUENCE_PAUSE_DURATION).timeout
	
	for card_ui: PlayingCardUI in scoring_cards:
		var tween := create_tween()
		tween.tween_property(card_ui, "position:y", card_ui.position.y - 10, CARD_MOVE_DURATION)
		await tween.finished
		await get_tree().create_timer(0.1).timeout
		
	await get_tree().create_timer(SEQUENCE_PAUSE_DURATION * 2).timeout
			
	apply_pre_hand_jokers(jokers, hand_type.hand_kind)

	# Per Card scoring
	for card_ui in scoring_cards:
		# TODO: make a number appear above each card, and add that number to Chips
		
		score_manager.add_chips(card_ui.card.chip_value())
		
		# pop the card
		await pop_tween(card_ui)
		
		apply_card_jokers(card_ui, jokers, hand_type.hand_kind)

	apply_post_hand_jokers(jokers, hand_type.hand_kind)
			
	# display chips * mult product before adding to total score
	await get_tree().create_timer(SEQUENCE_PAUSE_DURATION * 3).timeout
	score_manager.show_multiplied()
		
	Events.hand_scored.emit()
	
func apply_pre_hand_jokers(jokers: Array[JokerUI], hand_kind: HandType.HandKind) -> void:
	for joker_ui in jokers:
		var joker: Joker = joker_ui.joker
		if joker.applies_pre_hand(hand_kind):
			joker.apply_pre_hand(score_manager, hand_kind)
			await pop_tween(joker_ui)
			
func apply_post_hand_jokers(jokers: Array[JokerUI], hand_kind: HandType.HandKind) -> void:
	for joker_ui in jokers:
		var joker: Joker = joker_ui.joker
		if joker.applies_post_hand(hand_kind):
			joker.apply_post_hand(score_manager, hand_kind)
			await pop_tween(joker_ui)
			
func apply_card_jokers(card_ui: PlayingCardUI, jokers: Array[JokerUI], _hand_kind: HandType.HandKind) -> void:
	for joker_ui in jokers:
		var joker: Joker = joker_ui.joker
		if joker.applies_for_card(card_ui):
			joker.apply_for_card(score_manager, card_ui)
			await pop_tween(joker_ui)

func clear_cards() -> void:
	for card: PlayingCardUI in get_children():
		card.queue_free()

func pop_tween(node: Node) -> void:
	var tween := create_tween()
	tween.tween_property(node, "scale", Vector2(1.1, 1.1), CARD_POP_DURATION)\
		 .set_trans(Tween.TRANS_QUAD)\
		 .set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "scale", Vector2.ONE, CARD_POP_DURATION)\
		 .set_trans(Tween.TRANS_QUAD)\
		 .set_ease(Tween.EASE_IN)
	await tween.finished
