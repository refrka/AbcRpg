@abstract class_name PreservationBehavior extends Behavior




@export var critical_ratio:= 0.25


var combat_component: CombatComponent



func _initialize(_entity: EntityNode, _behavior_component: BehaviorComponent) -> void:

	super(_entity, _behavior_component)

	combat_component = entity.get_component(CombatComponent)

	




func _evaluate(_target_disposition: Disposition = null) -> float:

	var score = super(_target_disposition)

	if IsHealthCriticalCondition.run({"entity_node": entity, "critical_ratio": critical_ratio}):

		score = 1.0

	return score