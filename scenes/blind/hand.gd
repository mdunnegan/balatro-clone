class_name Hand
extends HBoxContainer

@onready var sort_rank: Button = %SortRank
@onready var sort_suit: Button = %SortSuit

func _ready() -> void:
	#sort_rank.pressed.connect(_on_sort_rank_pressed)
	#sort_suit.pressed.connect(_on_sort_suit_pressed)
	
	sort_rank.disabled = true
	sort_suit.disabled = true

#func _on_sort_rank_pressed() -> void:
	#var children := get_children()
	#children.sort_custom(func(a, b):
		#return a.card.rank > b.card.rank
	#)
	#
	#_update_visuals(children)
	#
#func _on_sort_suit_pressed() -> void:
	#var children := get_children()
	#children.sort_custom(func(a, b):
		#if a.card.suit == b.card.suit:
			#return a.card.rank > b.card.rank
		#return a.card.suit > b.card.suit
	#)
	#
	#_update_visuals(children)
#
#func _update_visuals(children) -> void:
	#for child in children:
		#remove_child(child)
		#add_child(child)
		#if child.selected:
			#child.mark_as_selected()
