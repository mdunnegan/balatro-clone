extends Node2D

const JOKER_UI := preload("res://scenes/joker_ui.tscn")
const BLIND_SCENE = preload("res://scenes/blind/blind.tscn")

const FLUSH_FIVE_HAND_TYPE := preload("res://resources/hand_types/flush_five.tres")
const FLUSH_HOUSE_HAND_TYPE := preload("res://resources/hand_types/flush_house.tres")
const FIVE_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/five_of_a_kind.tres")
const STRAIGHT_FLUSH_HAND_TYPE := preload("res://resources/hand_types/straight_flush.tres")
const FOUR_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/four_of_a_kind.tres")
const FULL_HOUSE_HAND_TYPE := preload("res://resources/hand_types/full_house.tres")
const FLUSH_HAND_TYPE := preload("res://resources/hand_types/flush.tres")
const STRAIGHT_HAND_TYPE := preload("res://resources/hand_types/straight.tres")
const THREE_OF_A_KIND_HAND_TYPE := preload("res://resources/hand_types/three_of_a_kind.tres")
const TWO_PAIR_HAND_TYPE := preload("res://resources/hand_types/two_pair.tres")
const PAIR_HAND_TYPE := preload("res://resources/hand_types/pair.tres")
const HIGH_CARD_HAND_TYPE := preload("res://resources/hand_types/high_card.tres")
const NONE_HAND_TYPE := preload("res://resources/hand_types/none.tres")

@onready var small_blind_button: Button = $AnteLayer/SmallBlindButton
@onready var big_blind_button: Button = $AnteLayer/BigBlindButton
@onready var boss_blind_button: Button = $AnteLayer/BossBlindButton

@onready var blind_layer: CanvasLayer = %BlindLayer
@onready var shop_layer: CanvasLayer = %ShopLayer
@onready var ante_layer: CanvasLayer = %AnteLayer

@onready var joker_area: HBoxContainer = %JokerArea

var all_layers: Array[CanvasLayer]

var run_state: RunState = RunState.new()


func _ready() -> void:
	_create_hand_types()	
	
	run_state.jokers = []
	
	# initialize standard deck
	var deck = PlayingCardPile.new()
	deck.build_standard_deck()
	deck.shuffle()
	run_state.deck = deck
	
	small_blind_button.pressed.connect(_on_blind_button_pressed)
	
	all_layers = [blind_layer, shop_layer, ante_layer]
	
	# clear the placeholder jokers
	for j in joker_area.get_children():
		j.free()
		
	# initialize pair joker
	var joker: Joker = preload("res://resources/jokers/pair_mult_joker.tres")
	var joker_ui := JOKER_UI.instantiate()
	joker_ui.joker = joker
	joker_area.add_child(joker_ui)
	run_state.jokers.append(joker)
	
	# initialize chips joker
	var joker2: Joker = preload("res://resources/jokers/odd_chips_joker.tres")
	var joker_ui2 := JOKER_UI.instantiate()
	joker_ui2.joker = joker2
	joker_area.add_child(joker_ui2)
	run_state.jokers.append(joker)

func show_layer(layer_to_show: CanvasLayer) -> void:
	for layer: CanvasLayer in all_layers:
		layer.hide()
	layer_to_show.show()

func _on_blind_button_pressed() -> void:
	var blind := BLIND_SCENE.instantiate()
	blind_layer.add_child(blind)
	blind.run_state = run_state
	blind.jokers = get_jokers() # TODO: Passing joker state is hacky now
	blind.begin_blind()
	show_layer(blind_layer)
	
func get_jokers() -> Array[JokerUI]:
	var return_jokers: Array[JokerUI] = []
	for joker: JokerUI in joker_area.get_children():
		return_jokers.append(joker)
	return return_jokers
	
func _on_blind_won() -> void:
	show_layer(shop_layer)
	
func _on_shop_finished() -> void:
	show_layer(ante_layer)

func _create_hand_types() -> void:
	run_state.hand_types.append(FLUSH_FIVE_HAND_TYPE)
	run_state.hand_types.append(FLUSH_HOUSE_HAND_TYPE)
	run_state.hand_types.append(FIVE_OF_A_KIND_HAND_TYPE)
	run_state.hand_types.append(STRAIGHT_FLUSH_HAND_TYPE)
	run_state.hand_types.append(FOUR_OF_A_KIND_HAND_TYPE)
	run_state.hand_types.append(FULL_HOUSE_HAND_TYPE)
	run_state.hand_types.append(FLUSH_HAND_TYPE)
	run_state.hand_types.append(STRAIGHT_HAND_TYPE)
	run_state.hand_types.append(THREE_OF_A_KIND_HAND_TYPE)
	run_state.hand_types.append(TWO_PAIR_HAND_TYPE)
	run_state.hand_types.append(PAIR_HAND_TYPE)
	run_state.hand_types.append(HIGH_CARD_HAND_TYPE)
	run_state.hand_types.append(NONE_HAND_TYPE)
