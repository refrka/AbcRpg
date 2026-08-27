class_name CombatAttackingState extends CombatState




var aniamtion_component: AnimationComponent




func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	aniamtion_component = entity.get_component(AnimationComponent)