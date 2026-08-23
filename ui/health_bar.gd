class_name HealthBar extends ProgressBar


@export var health_component: HealthComponent





func _ready() -> void:

	health_component.activated.connect(_on_health_component_activated)

	health_component.health_restored.connect(_on_health_restored)

	health_component.health_reduced.connect(_on_health_reduced)

	_update_progress()




func _update_progress() -> void:

	max_value = health_component.max_health

	value = health_component.current_health




func _on_health_component_activated() -> void:

	_update_progress()



func _on_health_restored(_amount: float, _current_health: float) -> void:

	_update_progress()


func _on_health_reduced(_amount: float, _current_health: float) -> void:

	_update_progress()