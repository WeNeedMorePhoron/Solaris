/datum/job/roguetown/marshal // A somewhat ham-fisted merge between bailiff and the old town sheriff role. The latter was built like a modern day officer, but we medieval in this bitch!
	title = "Marshal"
	flag = MARSHAL
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_MARSHAL
	tutorial = "You are an agent of the crown in matters of law and military, making sure that laws are pushed, verified and carried out by the retinue upon the citizenry of the realm. While you preside over the knights and men-at-arms, much of your work happens behind a desk, deferring to the Knight Captain to make sure your will is carried out in the field."
	whitelist_req = FALSE

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	outfit = /datum/outfit/job/roguetown/marshal

	give_bank_account = 40
	noble_income = 20
	min_pq = 8
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_guard.ogg'
	advclass_cat_rolls = list (CTAG_MARSHAL = 20)
	virtue_restrictions = list(/datum/virtue/utility/outlander, /datum/virtue/sucker/lesser_bloodsucker)//Command roles probably shouldn't be from Not Here

/datum/outfit/job/roguetown/marshal/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/platelegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	neck = /obj/item/clothing/neck/roguetown/bevor
	id = /obj/item/scomstone/garrison
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/signal_horn = 1)
	if(H.mind)

		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PERFECT_TRACKER, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/living/carbon/human/proc/request_law, /mob/living/carbon/human/proc/request_law_removal, /mob/living/carbon/human/proc/request_purge)

/datum/job/roguetown/marshal/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/marshal/classic
	name = "Marshal"
	tutorial = "You've spent your days in the courts and garrisons of the city. You've studied the law tome from back to front and enforce your word with the iron hand of justice, and the iron mace in your hands. More men have spent days rotting in the dungeon than that Knight Commander could ever have claimed, and every person in the realm respects your authority in matters of law and order."
	outfit = /datum/outfit/job/roguetown/marshal/classic

	category_tags = list(CTAG_MARSHAL)

/datum/outfit/job/roguetown/marshal/classic/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/sheriff
	cloak = /obj/item/clothing/cloak/stabard/surcoat/bailiff
	backr = /obj/item/rogueweapon/mace/cudgel/justice
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltl = /obj/item/storage/keyring/sheriff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE) // was told that Marshal should be a rough equivalent to knight captain
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("fortune", 1)

/datum/advclass/marshal/kcommander
	name = "Knight Commander"
	tutorial = "You spent your days as a dutiful knight in the service of the crown. Earning your accolades through military tactics and victories, you're reknown for your warfaring. Now retired from your days afield, you enforce the same iron law you once practiced at war in your home. You run the garrison, knights and the town's laws with a military strictness, and no-one can claim you are weaker on crime than any of those weak Marshals."
	outfit = /datum/outfit/job/roguetown/marshal/kcommander

	category_tags = list(CTAG_MARSHAL)

/datum/outfit/job/roguetown/marshal/kcommander/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat
	backr = /obj/item/rogueweapon/sword/long/oathkeeper
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltl = /obj/item/storage/keyring/sheriff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.change_stat("fortune", 1)

/datum/advclass/marshal/renalla
	name = "Magic Knight General"
	tutorial = "Someone who offered his power and devotion to unknown rites, now wields them to command forces at his beck and call in the name of sunmarch"
	outfit = /datum/outfit/job/roguetown/marshal/renalla
	category_tags = list(CTAG_MARSHAL)

/datum/outfit/job/roguetown/marshal/renalla/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltl = /obj/item/storage/keyring/sheriff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.change_stat("Strength", 2)		// 12 total points to be conservative
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", 4)
		H.change_stat("endurance", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	H.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_ELITE
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade) 
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/warlock/summon_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mindlink)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
	H.put_in_hands(giveweapon(H,"Sunmarch"), FALSE)

	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"sheriff"				= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"wolf"					= /obj/item/clothing/head/roguetown/helmet/heavy/wolfplate,
		"Armet"					= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Heavy Knight"			= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]
	backpack_contents = list(
		/obj/item/storage/keyring/sheriff = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		)

/datum/outfit/job/roguetown/marshal/renalla/proc/giveweapon(mob/living/carbon/human/human, patronchoice)
	var/weapons_choice = list(
		"Axe", "Battleaxe", "Cleaver", "Dagger", "Flail", "Goden",
		"Greatsword", "Halberd", "Longsword", "Mace", "Peasant war flail",
		"Rapier", "Scythe", "Spear", "Whip"
	)

	var/weapon_chosen = input("Choose your sentient weapon", "Available weapons") as anything in weapons_choice
	var/item_type

	switch(weapon_chosen)
		if("Axe") item_type = /obj/item/rogueweapon/stoneaxe/woodcut/steel
		if("Battleaxe") item_type = /obj/item/rogueweapon/stoneaxe/battle
		if("Cleaver") item_type = /obj/item/rogueweapon/huntingknife/cleaver
		if("Dagger") item_type = /obj/item/rogueweapon/huntingknife/idagger/steel
		if("Flail") item_type = /obj/item/rogueweapon/flail/sflail
		if("Goden") item_type = /obj/item/rogueweapon/mace/goden/steel
		if("Greatsword") item_type = /obj/item/rogueweapon/greatsword
		if("Halberd") item_type = /obj/item/rogueweapon/halberd
		if("Longsword") item_type = /obj/item/rogueweapon/sword/long
		if("Mace") item_type = /obj/item/rogueweapon/mace/steel
		if("Peasant war flail") item_type = /obj/item/rogueweapon/flail/peasantwarflail
		if("Rapier") item_type = /obj/item/rogueweapon/sword/rapier
		if("Scythe") item_type = /obj/item/rogueweapon/sickle/scythe
		if("Spear") item_type = /obj/item/rogueweapon/spear
		if("Whip") item_type = /obj/item/rogueweapon/whip

	var/obj/item/item = new item_type
	item.AddComponent(/datum/component/pact_weapon, human, patronchoice)
	item.AddComponent(/datum/component/singing_item, human, patronchoice, item)

	// Make sure the lists exist
	if(!islist(human.mind.warlock_weapons))
		human.mind.warlock_weapons = list()
	if(!islist(human.mind.warlock_weapon_types))
		human.mind.warlock_weapon_types = list()

	human.mind.warlock_weapons += item
	human.mind.warlock_weapon_types += item_type



/mob/living/carbon/human/proc/request_law()
	set name = "Request Law"
	set category = "Voice of Command"
	if(stat)
		return
	var/inputty = input("Write a new law", "SHERIFF") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_law(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_requested), src, lord, inputty)
			else
				make_law(inputty)

/mob/living/carbon/human/proc/request_law_removal()
	set name = "Request Law Removal"
	set category = "Voice of Command"
	if(stat)
		return
	var/inputty = input("Remove a law", "SHERIFF") as text|null
	var/law_index = text2num(inputty) || 0
	if(law_index && GLOB.laws_of_the_land[law_index])
		if(hasomen(OMEN_NOLORD))
			remove_law(law_index)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_removal_requested), src, lord, law_index)
			else
				remove_law(law_index)

/mob/living/carbon/human/proc/request_purge()
	set name = "Request Purge"
	set category = "Voice of Command"
	if(stat)
		return
	if(hasomen(OMEN_NOLORD))
		purge_laws()
	else
		var/lord = find_lord()
		if(lord)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_purge_requested), src, lord)
		else
			purge_laws()

/mob/living/carbon/human/proc/request_outlaw()
	set name = "Request Outlaw"
	set category = "Voice of Command"
	if(stat)
		return
	var/inputty = input("Outlaw a person", "SHERIFF") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_outlaw(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_outlaw_requested), src, lord, inputty)
			else
				make_outlaw(inputty)

/proc/find_lord(required_stat = CONSCIOUS)
	var/mob/living/lord
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind || H.job != "Marquis" || (H.stat > required_stat))
			continue
		lord = H
		break
	return lord

/proc/lord_law_requested(mob/living/bailiff, mob/living/carbon/human/lord, requested_law)
	var/choice = alert(lord, "The sheriff requests a new law!\n[requested_law]", "SHERIFF LAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(bailiff)
			to_chat(span_warning("The lord has denied the request for a new law!"))
		return
	make_law(requested_law)

/proc/lord_law_removal_requested(mob/living/bailiff, mob/living/carbon/human/lord, requested_law)
	if(!requested_law || !GLOB.laws_of_the_land[requested_law])
		return
	var/choice = alert(lord, "The sheriff requests the removal of a law!\n[GLOB.laws_of_the_land[requested_law]]", "SHERIFF LAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(bailiff)
			to_chat(span_warning("The lord has denied the request for a law removal!"))
		return
	remove_law(requested_law)

/proc/lord_purge_requested(mob/living/bailiff, mob/living/carbon/human/lord)
	var/choice = alert(lord, "The sheriff requests a purge of all laws!", "SHERIFF PURGE REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(bailiff)
			to_chat(span_warning("The lord has denied the request for a purge of all laws!"))
		return
	purge_laws()

/proc/lord_outlaw_requested(mob/living/bailiff, mob/living/carbon/human/lord, requested_outlaw)
	var/choice = alert(lord, "The sheriff requests to outlaw someone!\n[requested_outlaw]", "SHERIFF OUTLAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(bailiff)
			to_chat(span_warning("The lord has denied the request for declaring an outlaw!"))
		return
	make_outlaw(requested_outlaw)

/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
