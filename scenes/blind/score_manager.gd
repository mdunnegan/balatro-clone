class_name ScoreManager
extends GridContainer

const NONE_HAND_TYPE = preload("res://resources/hand_types/none.tres")

#@onready var chips_label: Label = %Chips
#@onready var mult_label: Label = %Mult

@onready var required_score_label: Label = %RequiredScore
@onready var current_score_label: Label = %CurrentScore
@onready var total_score_label: Label = %TotalScore

@onready var chips: int
@onready var mult: int
@onready var total_score: int

var required_score: int

var hand_type: HandType = NONE_HAND_TYPE

func _ready() -> void:
	Events.hand_scored.connect(_on_hand_scored)
	Events.hand_type_changed.connect(_on_hand_type_changed)
	update_labels()
	
func _on_hand_type_changed(new_hand_type: HandType) -> void:
	chips = new_hand_type.base_chips
	mult = new_hand_type.base_mult
	hand_type = new_hand_type
	
	update_labels()
	
func set_required_score(score: int) -> void:
	required_score = score
	update_labels()
	
func add_chips(c: int) -> void:
	chips += c
	update_labels()
	
func add_mult(m: int) -> void:
	mult += m
	update_labels()
	
func multiply_mult(m: int) -> void:
	mult += m
	update_labels()
	
func _on_hand_scored() -> void:
	total_score += chips * mult
	chips = 0
	mult = 0
	update_labels()
	
	if total_score >= required_score:
		Events.blind_won.emit()
	
func reset_score() -> void:
	chips = 0
	mult = 0
	update_labels()
	
func show_multiplied() -> void:
	update_labels(true)

func update_labels(multiply_nums = false) -> void:
	
	required_score_label.text = str(required_score)
	
	if multiply_nums:
		current_score_label.text = str("%s" % str(chips * mult))
	else:
		current_score_label.text = str("%s x %s" % [chips, mult])
		
	total_score_label.text = str(total_score)
	
