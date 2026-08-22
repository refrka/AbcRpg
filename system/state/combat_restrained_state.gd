class_name CombatRestrainedState extends CombatState






func _enter() -> void:

	super()

	animation_component.combat_anim_player.play("restrain")




func _exit() -> void:

	super()

	animation_component.combat_anim_player.play("RESET")