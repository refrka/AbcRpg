class_name HealthComponent extends Component


signal health_depleted




var max_health: float

var current_health: float





func _initialize(_entity: EntityNode) -> bool:

	if !super(_entity): return false

	var entity_def = entity.entity_def

	max_health = entity_def.base_max_health

	current_health = max_health

	return true







func receive_damage_package(damage_package: DamagePackage) -> void:

	for damage_entry in damage_package.damage_entries:

		var animation_component = entity.get_component(AnimationComponent)

		animation_component.combat_anim_player.play("flinch")

		if entity is Player:

			Game.camera.anim_player.play("shake")

		reduce_health(damage_entry.amount)




func reduce_health(amount: float) -> void:

	if is_alive():

		current_health -= amount

		if !is_alive():

			var animation_component = entity.get_component(AnimationComponent)

			if animation_component.combat_anim_player.is_playing():

				await animation_component.combat_anim_player.animation_finished

			health_depleted.emit()

			entity.queue_free.call_deferred()







func is_alive() -> bool:

	return current_health > 0.0