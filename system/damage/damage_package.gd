class_name DamagePackage extends Resource




var source_entity: EntityNode

var damage_entries: Array[DamageEntry]








func add_damage_entry(entry: DamageEntry) -> void:

	damage_entries.append(entry)




func get_total_damage() -> float:

	var sum = 0.0

	for damage_entry in damage_entries:

		sum += damage_entry.amount

	return sum





static func from_attack_entry(attack_entry: AttackEntry, _source_entity: EntityNode = null) -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.source_entity = _source_entity

	var damage_entry = DamageEntry.new()

	damage_entry.amount = attack_entry.get_damage_roll()

	damage_package.add_damage_entry(damage_entry)

	return damage_package