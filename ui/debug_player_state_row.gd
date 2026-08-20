class_name DebugPlayerStateRow extends HBoxContainer

@export var arrow_label: Label

@export var state_label: Label







func select() -> void:

	state_label.remove_theme_color_override("font_color")

	arrow_label.visible = true



func deselect() -> void:

	state_label.add_theme_color_override("font_color", Color("#4f4f4f"))

	arrow_label.visible = false



