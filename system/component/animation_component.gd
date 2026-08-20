class_name AnimationComponent extends Component


@export var body_anim_tree: AnimationTree

@export var combat_anim_tree: AnimationTree





var body_state_playback: AnimationNodeStateMachinePlayback

var combat_state_playback: AnimationNodeStateMachinePlayback





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	body_state_playback = body_anim_tree.get("parameters/playback")

	combat_state_playback = combat_anim_tree.get("parameters/playback")

	return true






func travel_playback(playback_name: String, node_name: String) -> void:

	match playback_name:

		"body":

			body_state_playback.travel(node_name)

		"combat":

			combat_state_playback.travel(node_name)







func _activate() -> bool:

	if !super(): return false

	body_anim_tree.active = true

	combat_anim_tree.active = true

	return true




func _deactivate() -> bool:

	if !super(): return false

	body_anim_tree.active = false

	combat_anim_tree.active = false

	return true







func _connect_signals() -> void:

	body_anim_tree.animation_finished.connect(_on_body_animation_finished)

	combat_anim_tree.animation_finished.connect(_on_combat_animation_finished)




func _disconnect_signals() -> void:

	body_anim_tree.animation_finished.disconnect(_on_body_animation_finished)

	combat_anim_tree.animation_finished.disconnect(_on_combat_animation_finished)





func _on_body_animation_finished(anim_namE: StringName) -> void:

	pass



func _on_combat_animation_finished(anim_namE: StringName) -> void:

	pass