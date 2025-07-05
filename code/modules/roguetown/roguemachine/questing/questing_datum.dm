/datum/quest
	var/title = ""
	var/datum/weakref/quest_giver_reference
	var/quest_giver_name = ""
	var/datum/weakref/quest_receiver_reference
	var/quest_receiver_name = ""
	var/quest_type = ""
	var/quest_difficulty = ""
	var/reward_amount = 0
	var/complete = FALSE
	/// Target item type for fetch quests
	var/obj/item/target_item_type
	/// Target item type for courier quests
	var/obj/item/target_delivery_item
	/// Target mob type for kill quests
	var/mob/target_mob_type
	/// Number of targets needed
	var/target_amount = 1
	/// Location for beacon quests
	var/area/beacon_activation_location
	/// Location for courier quests
	var/area/provincial/indoors/town/target_delivery_location
	/// Location name for kill/clear quests
	var/target_spawn_area = ""
	/// Fallback reference to the spawned scroll
	var/obj/item/paper/scroll/quest/quest_scroll
	/// Weak reference to the quest scroll
	var/datum/weakref/quest_scroll_ref
	/// Target beacon for beacon quests
	var/obj/structure/roguemachine/teleport_beacon/target_beacon
	/// Whether this is a beacon connection quest
	var/beacon_connection = FALSE
	/// List of possible beacons for connection quests
	var/list/possible_beacons = list()
	/// Whether the beacon has been activated for this quest
	var/beacon_activated = FALSE

/datum/quest/Destroy()
	// Clean up mobs with quest components
	for(var/mob/living/M in GLOB.mob_list)
		var/datum/component/quest_object/Q = M.GetComponent(/datum/component/quest_object)
		if(Q && Q.quest_ref?.resolve() == src)
			M.remove_filter("quest_item_outline")
			qdel(Q)

	// Clean up items with quest components carefully
	for(var/obj/item/I in world)
		var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
		if(Q && Q.quest_ref?.resolve() == src && !QDELETED(I))
			I.remove_filter("quest_item_outline")
			qdel(Q)
			// Only delete the item if it's part of a fetch or courier quest
			if(quest_type == "Fetch" && istype(I, target_item_type))
				qdel(I)
			else if(quest_type == "Courier" && istype(I, target_delivery_item))
				qdel(I)

	// Clean up references
	quest_scroll = null
	if(quest_scroll_ref)
		var/obj/item/paper/scroll/quest/Q = quest_scroll_ref.resolve()
		if(Q && !QDELETED(Q))
			Q.assigned_quest = null
			qdel(Q)
		quest_scroll_ref = null
	
	// Clean up beacon references
	target_beacon = null
	possible_beacons = null
	
	return ..()
