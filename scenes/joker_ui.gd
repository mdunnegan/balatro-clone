class_name JokerUI
extends Control

@onready var label: Label = $Label
@onready var color: ColorRect = $Color

@export var joker: Joker

func _ready():
	# Programmatically set the color rect to not eat the click
	color.mouse_filter = Control.MOUSE_FILTER_IGNORE
	gui_input.connect(_on_gui_input)
	
	if !is_node_ready():
		await ready

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse") && joker != null:
		print(joker.description())
