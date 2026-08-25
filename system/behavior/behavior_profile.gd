class_name BehaviorProfile extends Resource


@export var attribute_remaps: Dictionary[Behavior.BehaviorType, AttributeRemap]

@export var reaction_tags: Array[ReactionTag]

@export var behaviors: Array[Behavior]





func get_remap(behavior_type: Behavior.BehaviorType) -> AttributeRemap:

	if attribute_remaps.has(behavior_type):

		return attribute_remaps[behavior_type]

	return null






func get_reaction_tag(tag_script: Script) -> ReactionTag:

	for tag in reaction_tags:

		if tag.get_script() == tag_script:

			return tag

	return null