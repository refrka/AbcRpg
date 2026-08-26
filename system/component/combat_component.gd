class_name CombatComponent extends Component
















func receive_damage_package(damage_package: DamagePackage) -> void:

	if entity.state_machine.current_combat_state is CombatIdleState:

		entity.state_machine.request_state(CombatReadyState)