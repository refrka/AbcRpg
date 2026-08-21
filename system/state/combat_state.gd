class_name CombatState extends State



var combat_component: CombatComponent




func _initialize(_entity: EntityNode, _state_machine: StateMachine) -> bool:

	if !super(_entity, _state_machine): return false

	combat_component = entity.get_component(CombatComponent)

	return true



func _reset() -> bool:

	if !super(): return false

	combat_component = null

	return true



