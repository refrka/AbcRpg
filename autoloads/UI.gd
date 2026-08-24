extends Node


signal popup_boolean_completed(state: bool)


# @onready var popup_scene:= preload("res://ui/game_popup.tscn")

# @onready var count_selector_scene:= preload("res://ui/count_selector.tscn")

# @onready var barter_count_selector_scene:= preload("res://ui/barter_count_selector.tscn")

# @onready var interaction_progress_displace_scene:= preload("res://ui/interaction_progress_display.tscn")




var overlay_registry: Dictionary[Script, OverlayElement]

var active_overlays: Array[OverlayElement]

var pause_overlays: Array[OverlayElement]


var player_profile: PlayerProfile

var game_menu: GameMenu


var overlay_root: Control

# var notice_root: NoticeRoot

var popup_root: Control



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	player_profile = get_tree().get_first_node_in_group("player_profile")

	player_profile._initialize()

	player_profile._deactivate()

	player_profile.hide()

	game_menu = get_tree().get_first_node_in_group("game_menu")

	game_menu._deactivate()

	game_menu.hide()

	# Events.subscribe(GameEndingEvent, _on_game_ending)

	overlay_root = get_tree().get_first_node_in_group("overlay_root")

	# notice_root = get_tree().get_first_node_in_group("notice_root")

	popup_root = get_tree().get_first_node_in_group("popup_root")




func register_overlay(overlay: OverlayElement) -> void:

	var script = overlay.get_script()

	overlay_registry[script] = overlay

	overlay.close_requested.connect(_on_overlay_close_requested.bind(overlay))




func unregister_overlay(overlay: OverlayElement) -> void:

	var script = overlay.get_script()

	overlay_registry.erase(script)





func add_overlay(overlay: OverlayElement) -> void:

	if !active_overlays.is_empty():

		active_overlays.back().sleep()

	active_overlays.append(overlay)

	overlay._activate()

	overlay.show()

	if overlay.pause_game:

		pause_overlays.append(overlay)
	
		if !Game.is_paused():

			Game.pause()




func remove_overlay(overlay: OverlayElement = null) -> void:

	if overlay == null:

		overlay = active_overlays.back()

	overlay._deactivate()

	overlay.hide()

	if active_overlays.has(overlay):

		active_overlays.erase(overlay)

		if !active_overlays.is_empty():

			active_overlays.back().wake()

		if overlay.pause_game:

			pause_overlays.erase(overlay)

			if pause_overlays.is_empty() and Game.is_paused():

				Game.resume()





func get_overlay(overlay_script: Script) -> OverlayElement:

	var overlay: OverlayElement = null

	if overlay_registry.has(overlay_script):

		overlay = overlay_registry[overlay_script]

	return overlay




# func get_interaction_progress_display() -> InteractionProgressDisplay:

# 	var display = interaction_progress_displace_scene.instantiate()

# 	return display




func deactivate_overlays() -> void:

	for overlay in active_overlays:

		remove_overlay(overlay)








# Various overlays: Notices, Popups, Dialogue, CountSelector


# func show_notice(primary: String, secondary:= "") -> Notice:

# 	var notice = notice_root.add_notice(primary, secondary)

# 	return notice




# func show_popup(mode: GamePopup.PopupMode, message: String, title:= "") -> GamePopup:

# 	var popup = popup_scene.instantiate() as GamePopup

# 	popup.set_text(message, title)

# 	popup.popup_completed.connect(_on_popup_completed)

# 	popup.boolean_completed.connect(_on_popup_boolean_completed)

# 	popup_root.add_child(popup)

# 	popup.set_mode(mode)

# 	popup._activate()

# 	if popup.pause:

# 		pause_overlays.append(popup)
	
# 		if !Game.is_paused():

# 			Game.pause()

# 	return popup




# func show_dialogue_panel(greeting: Greeting, options: Array[DialogueNode] = [], source: EntityNode = null) -> DialoguePanel:

# 	var dialogue_panel = get_overlay(DialoguePanel) as DialoguePanel

# 	dialogue_panel.set_dialogue(source, greeting, options)

# 	add_overlay(dialogue_panel)

# 	return dialogue_panel




# func show_barter_panel(target_entity: EntityNode, barter_dialogue_node: BarterDialogueNode) -> BarterPanel:

# 	var barter_panel = get_overlay(BarterPanel) as BarterPanel

# 	barter_panel.load_barter_inventories(target_entity)

# 	add_overlay(barter_panel)

# 	barter_panel.set_dialogue_text(barter_dialogue_node.dialogue_text)

# 	return barter_panel
		
		
		
# func show_count_selector(min_count: int, max_count: int, title:= "", use_float:= true, barter:= false) -> CountSelector:

# 	var overlay: CountSelector = null

# 	if barter:

# 		overlay = barter_count_selector_scene.instantiate() as BarterCountSelector

# 	else:

# 		overlay = count_selector_scene.instantiate() as CountSelector

# 	if title != "":

# 		overlay.set_title(title)

# 	overlay.set_count(min_count, max_count, use_float)

# 	overlay_root.add_child(overlay)

# 	add_overlay(overlay)

# 	return overlay






func toggle_player_profile() -> void:

	if player_profile.active:

		remove_overlay(player_profile)

	else:

		add_overlay(player_profile)






# func close_dialogue_panel() -> void:

# 	var overlay = get_overlay(DialoguePanel)

# 	if active_overlays.has(overlay):

# 		remove_overlay(overlay)




# func close_barter_panel() -> void:

# 	var overlay = get_overlay(BarterPanel)

# 	if active_overlays.has(overlay):

# 		remove_overlay(overlay)




# func close_popup(popup: GamePopup) -> void:

# 	if popup.pause:

# 		pause_overlays.erase(popup)

# 		Game.resume()

# 	popup.queue_free()







func is_busy() -> bool:

	if !active_overlays.is_empty():

		return true

	return false



func is_overlay_primary(overlay: OverlayElement) -> bool:

	if active_overlays.is_empty():

		return false

	return active_overlays.back() == overlay





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("player_profile"):

		if Game.is_active() and !game_menu.active:

			toggle_player_profile()

	if event.is_action_pressed("back"):

		if !Game.is_active():

			return

		if !active_overlays.is_empty():

			remove_overlay()

		else:

			add_overlay(game_menu)

# 	var game_menu = get_overlay(GameMenu)

# 	if game_menu.active:

# 		return

# 	if event.is_action_pressed("profile"):

# 		if Game.is_active():

# 			var profile = get_overlay(ProfilePanel)

# 			if !profile.active:

# 				add_overlay(profile)

# 			else:

# 				remove_overlay(profile)





# func _on_popup_completed(popup: GamePopup) -> void:

# 	close_popup(popup)



# func _on_popup_boolean_completed(popup: GamePopup, state: bool) -> void:

# 	close_popup(popup)

# 	popup_boolean_completed.emit(state)



func _on_overlay_close_requested(overlay: OverlayElement) -> void:

	remove_overlay(overlay)



# func _on_game_ending(_event: Event) -> void:

# 	notice_root.clear()

# 	deactivate_overlays()