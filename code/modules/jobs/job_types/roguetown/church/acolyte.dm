/datum/job/roguetown/acolyte
	title = "Acolyte"
	flag = MONK
	department_flag = CHURCHMEN
	selection_color = JCOLOR_CHURCH
	faction = "Station"
	total_positions = 6
	spawn_positions = 6

	allowed_races = RACES_ALL_KINDS
	allowed_patrons = ALL_PATRONS 
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/monk
	tutorial = "An Acolyte's life is exhausting; pulling double duty as the church's servant and student. Some find it wonderfully fufilling; others will grow to resent it."

	display_order = JDO_MONK
	give_bank_account = TRUE
	round_contrib_points = 2

	min_pq = null
	max_pq = null

	//No nobility for you, being a member of the clergy means you gave UP your nobility. It says this in many of the church tutorial texts.
	virtue_restrictions = list(/datum/virtue/utility/noble, /datum/virtue/sucker/lesser_bloodsucker)

/datum/job/roguetown/acolyte/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/monk
	name = "Acolyte"
	jobtype = /datum/job/roguetown/acolyte


/datum/outfit/job/roguetown/monk/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/storage/keyring/churchie
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/ritechalk)
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			head = /obj/item/clothing/head/roguetown/roguehood/aeternus
			neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/aeternus
		if(/datum/patron/lording_three/zira)
			head = /obj/item/clothing/head/roguetown/zirahood
			neck = /obj/item/clothing/neck/roguetown/psicross/zira
			wrists = /obj/item/clothing/wrists/roguetown/zirawrappings
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/zira
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		if(/datum/patron/peoples_pantheon/cinella) // the deep calls!
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			pants = /obj/item/clothing/under/roguetown/tights
			neck = /obj/item/clothing/neck/roguetown/psicross/cinella
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/cinella
			head = /obj/item/clothing/head/roguetown/roguehood/cinella		
		if(/datum/patron/three_sisters/tamari)
			head = /obj/item/clothing/head/roguetown/tamarimask
			neck = /obj/item/clothing/neck/roguetown/psicross/tamari
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/tamari
		if(/datum/patron/lording_three/tsoridys)
			head = /obj/item/clothing/head/roguetown/tsoridyshood
			neck = /obj/item/clothing/neck/roguetown/psicross/tsoridys
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/tsoridys
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
			cloak = /obj/item/clothing/cloak/raincloak/mortus
		if(/datum/patron/peoples_pantheon/varielle)
			head = /obj/item/clothing/head/roguetown/variellemask
			neck = /obj/item/clothing/neck/roguetown/psicross/varielle
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/varielle
			cloak = /obj/item/clothing/cloak/templar/variellian
		if(/datum/patron/three_sisters/nunos)
			head = /obj/item/clothing/head/roguetown/roguehood
			neck = /obj/item/clothing/neck/roguetown/psicross/nunos
			shoes = /obj/item/clothing/shoes/roguetown/boots
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			pants = /obj/item/clothing/under/roguetown/trou
			cloak = /obj/item/clothing/cloak/templar/nunite
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		if(/datum/patron/peoples_pantheon/carthus)
			head = /obj/item/clothing/head/roguetown/roguehood
			neck = /obj/item/clothing/neck/roguetown/psicross/carthus
			cloak = /obj/item/clothing/cloak/templar/carthus
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			shoes = /obj/item/clothing/shoes/roguetown/boots
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/white
		if(/datum/patron/three_sisters/kasmidian)
			head = /obj/item/clothing/head/roguetown/roguehood
			neck = /obj/item/clothing/neck/roguetown/psicross/carthus
			cloak = /obj/item/clothing/cloak/templar/kasmidian
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe
			var/list/psicross_options = list(
			/obj/item/clothing/neck/roguetown/psicross,
			/obj/item/clothing/neck/roguetown/psicross/aeternus,
			/obj/item/clothing/neck/roguetown/psicross/zira,
			/obj/item/clothing/neck/roguetown/psicross/cinella,
			/obj/item/clothing/neck/roguetown/psicross/tamari,
			/obj/item/clothing/neck/roguetown/psicross/tsoridys,
			/obj/item/clothing/neck/roguetown/psicross/carthus,
			/obj/item/clothing/neck/roguetown/psicross/nunos,
			/obj/item/clothing/neck/roguetown/psicross/varielle,
			/obj/item/clothing/neck/roguetown/psicross/wood
			)
			neck = pick(psicross_options) // Random psicross, as cleric.
		else
			head = /obj/item/clothing/head/roguetown/roguehood/aeternus
			neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/aeternus
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
		if(H.patron?.type == /datum/patron/three_sisters/nunos)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)
		if(H.patron?.type == /datum/patron/three_sisters/tamari)
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 3, TRUE)
			to_chat(H, span_notice("As a follower of Tamari, you have innate knowledge of druidic magic."))
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.cmode_music = 'sound/music/combat_holy.ogg'
		if(H.patron?.type == /datum/patron/lording_three/tsoridys)
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
		if(H.patron?.type == /datum/patron/peoples_pantheon/varielle)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
		if(H.patron?.type == /datum/patron/peoples_pantheon/cinella)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
			ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_monk(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
