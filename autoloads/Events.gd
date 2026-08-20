extends Node




var subscriptions: Dictionary[Script, Array] = {}





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	subscribe(GameExitedEvent, _on_game_exited)




func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	subscriptions[event_script].append(callback)







func fire(event_script: Script, _data:= {}) -> void:

	if !subscriptions.has(event_script):

		return

	var event = event_script.new()

	event.fire(_data)

	for callback in subscriptions[event_script]:

		callback.call(event)






func _clear_game_subscriptions() -> void:

	for event_script in subscriptions:

		if event_script.get_base_script() == GameEvent:

			subscriptions.erase(event_script)










func _on_game_exited(_event: Event) -> void:

	_clear_game_subscriptions()