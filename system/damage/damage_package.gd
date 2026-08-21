class_name DamagePackage extends Resource



var damage_entries: Array[DamageEntry]








func add_damage_entry(entry: DamageEntry) -> void:

	damage_entries.append(entry)





static func from_attack_entry(attack_entry: AttackEntry) -> DamagePackage:

	var damage_package = DamagePackage.new()

	var damage_entry = DamageEntry.new()

	damage_entry.amount = attack_entry.get_damage_roll()

	damage_package.add_damage_entry(damage_entry)

	return damage_package