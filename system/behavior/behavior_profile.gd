class_name BehaviorProfile extends Resource


@export var attribute_remaps: Dictionary[Behavior.BehaviorType, AttributeRemap]






func get_remap(behavior_type: Behavior.BehaviorType) -> AttributeRemap:

	if attribute_remaps.has(behavior_type):

		return attribute_remaps[behavior_type]

	return null