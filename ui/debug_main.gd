class_name DebugMain extends Control


@export var disposition_info_display: DispositionInfoDisplay

@export var thief: EntityNode






func _ready() -> void:

	var behavior_component = thief.get_component(BehaviorComponent)

	behavior_component.disposition_generated.connect(_on_disposition_generated)





func _on_disposition_generated(disposition: Disposition) -> void:

	if disposition.target_entity is Player:

		disposition_info_display.load_disposiiton(disposition)