class_name DamageEntry extends RefCounted



var amount: float







static func from_attack_entry(attack_entry: AttackEntry) -> DamageEntry:

	var entry = DamageEntry.new()

	entry.amount = attack_entry.get_damage()

	return entry