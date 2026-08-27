class_name CombatComponent extends Component




var current_attack_config: AttackConfig

var current_attack_index:= 0

var current_attack_animation: StringName




var buffered:= false

var buffer_enabled:= false






func initialize(_entity: EntityNode) -> void:

	super(_entity)

	var animation_component = entity.get_component(AnimationComponent)

	animation_component.animation_finished.connect(_on_animation_finished)






func try_attack(attack_config: AttackConfig = null) -> void:

	if attack_config:

		current_attack_config = attack_config

	if !current_attack_config:

		return





func _start_attack() -> void:

	entity.state_machine.request_state(CombatAttackingState)



func _finish_attack() -> void:

	if !buffered:

		_end_attack()



func _end_attack() -> void:

	entity.state_machine.request_state(CombatReadyState)








func _on_animation_finished(anim_name: String) -> void:

	if anim_name == current_attack_animation:

		_finish_attack()