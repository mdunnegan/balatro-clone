class_name Score
extends GridContainer

const NONE_HAND_TYPE = preload("res://resources/hand_types/none.tres")

@onready var chips_label: Label = %Chips
@onready var mult_label: Label = %Mult
@onready var total_score_label: Label = %TotalScore

@onready var chips: int
@onready var mult: int
@onready var total_score: int

var hand_type: HandType = NONE_HAND_TYPE

func _ready() -> void:
	Events.card_scored.connect(_on_card_scored)
	Events.hand_scored.connect(_on_hand_scored)
	Events.hand_type_changed.connect(_on_hand_type_changed)
	update_labels()
	
func _on_hand_type_changed(new_hand_type: HandType) -> void:
	chips = new_hand_type.base_chips
	mult = new_hand_type.base_mult
	hand_type = new_hand_type
	
	update_labels()
	
func _on_card_scored(card_ui: PlayingCardUI):
	chips += card_ui.card.chip_value()
	
	update_labels()
	
func _on_hand_scored() -> void:
	total_score += chips * mult
	chips = 0
	mult = 0
	update_labels()

func update_labels() -> void:
	chips_label.text = str(chips)
	mult_label.text = str(mult)
	total_score_label.text = str(total_score)
