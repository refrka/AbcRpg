@abstract class_name ConflictBehavior extends Behavior




var combat_component: CombatComponent



func _initialize(_entity: EntityNode, _behavior_component: BehaviorComponent) -> void:

	super(_entity, _behavior_component)

	combat_component = entity.get_component(CombatComponent)









func _evaluate(_target_disposition: Disposition = null) -> float:

	var score = super(_target_disposition)

	if !_target_disposition and combat_component.opponents.is_empty():

		return 0.0

	return score