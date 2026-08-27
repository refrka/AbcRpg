class_name DispositionInfoDisplay extends UIElement




@export var entity_label: Label

@export var fear_label: Label

@export var affection_label: Label

@export var respect_label: Label


var disposition: Disposition




func load_disposiiton(_disposition: Disposition) -> void:

	disposition = _disposition

	entity_label.text = disposition.target_entity.get_display_name()

	fear_label.text = str(disposition.fear)

	affection_label.text = str(disposition.affection)

	respect_label.text = str(disposition.respect)

	disposition.fear_updated.connect(_on_fear_updated)

	disposition.affection_updated.connect(_on_affection_updated)

	disposition.respect_updated.connect(_on_respect_updated)





func _on_fear_updated() -> void:

	fear_label.text = str(disposition.fear)



func _on_affection_updated() -> void:

	affection_label.text = str(disposition.affection)



func _on_respect_updated() -> void:

	respect_label.text = str(disposition.respect)



