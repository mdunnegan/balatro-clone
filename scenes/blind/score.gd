class_name Score
extends HBoxContainer

const NONE_HAND_TYPE = preload("res://resources/hand_types/none.tres")

@onready var chips_label: Label = $Chips
@onready var mult_label: Label = $Mult

@onready var chips: int
@onready var mult: int

var hand_type: HandType = NONE_HAND_TYPE

func _ready() -> void:
	Events.card_scored.connect(_on_card_scored)
	Events.hand_type_changed.connect(_on_hand_type_changed)
	update_labels()
	hide()
	
func _on_hand_type_changed(new_hand_type: HandType) -> void:
	chips = new_hand_type.base_chips
	mult = new_hand_type.base_mult
	hand_type = new_hand_type
	
	update_labels()
	
func _on_card_scored(card_ui: PlayingCardUI):
	print("adding %s" % card_ui.card.chip_value())

	chips += card_ui.card.chip_value()
	# TODO: Joker value!
	
	update_labels()

func update_labels() -> void:
	if hand_type.hand_kind == HandType.HandKind.NONE:
		hide()
	else: 
		show()

	chips_label.text = str(chips)
	mult_label.text = str(mult)
