/datum/job/roguetown/manorguard
	title = "Man at Arms"
	flag = MANATARMS
	department_flag = GARRISON
	selection_color = JCOLOR_SOLDIER
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself loyal and capable, you are entrusted to defend the town and enforce its laws. Trained regularly in combat and siege warfare, you deal with threats - both within and without."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)

	give_bank_account = 22
	min_pq = 3
	max_pq = null
	round_contrib_points = 2
	virtue_restrictions = list(/datum/virtue/sucker/lesser_bloodsucker)
	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
			var/mob/living/carbon/human/H = L
			if(!(H.real_name in town_beacon.granted_list))
				town_beacon.granted_list += H.real_name
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "man-at-arms jupon ([index])"

/datum/outfit/job/roguetown/manorguard
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/rogueweapon/mace/cudgel
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison

// Melee goon
/datum/advclass/manorguard/footsman
	name = "Footman"
	tutorial = "You are a professional soldier of the realm, specializing in melee warfare. Stalwart and hardy, your body can both withstand and dish out powerful strikes.."
	outfit = /datum/outfit/job/roguetown/manorguard/footsman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +2 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.change_stat("strength", 2) // seems kinda lame but remember guardsman bonus!!
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord		//Bit worse shirt protection than the archer
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale			//Makes up for worse shirt protection with kinda better armor protection
	head = /obj/item/clothing/head/roguetown/helmet/sallet				//Better protection than kettle archer has
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/gorget

	H.adjust_blindness(-3)
	var/weapons = list("Mace & Shield","Axe & Shield","Halberd")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Mace & Shield")
			beltr = /obj/item/rogueweapon/mace/steel
			backl = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		if("Axe & Shield")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			backl = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		if("Halberd")
			r_hand = /obj/item/rogueweapon/halberd
			backl = /obj/item/gwstrap
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/guardcastle)
	H.verbs |= /mob/proc/haltyell

// Ranged weapons and daggers on the side - lighter armor, but fleet!
/datum/advclass/manorguard/skirmisher
	name = "Skirmisher"
	tutorial = "You are a professional soldier of the realm, specializing in ranged implements. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/skirmisher

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/skirmisher/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE) // Still have a cugel.
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)		//Only effects draw and reload time.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)			//Only effects draw times.
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // A little better; run fast, weak boy.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +3 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	//Garrison ranged/speed class. Time to go wild
	H.change_stat("endurance", 1) // seems kinda lame but remember guardsman bonus!!
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord			// Cant wear chainmail anymoooree
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		//Helps against arrows; makes sense for a ranged-type role.
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	pants = /obj/item/clothing/under/roguetown/trou/leather

	H.adjust_blindness(-3)
	var/weapons = list("Crossbow","Bow","Sling","Handgonner")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Crossbow")
			beltr = /obj/item/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		if("Bow") // They can head down to the armory to sideshift into one of the other bows.
			beltr = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		if("Sling")
			beltr = /obj/item/quiver/sling/iron
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/sling // Both are belt slots and it's not worth setting where the cugel goes for everyone else, sad.
			H.mind.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
		if("Handgonner")
			r_hand = /obj/item/powderhorn 
			beltr =  /obj/item/ammopouch/bullets
			backl = /obj/item/gun/ballistic/handgonne
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/guardcastle)
	H.verbs |= /mob/proc/haltyell

/datum/advclass/manorguard/cavalry
	name = "Cavalryman"
	tutorial = "You are a professional soldier of the realm, specializing in the steady beat of hoof falls. Lighter and more expendable then the knights, you charge with lance in hand. Beast sold seperately."
	outfit = /datum/outfit/job/roguetown/manorguard/cavalry

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/cavalry/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE) // Still have a cugel.
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)			// We discourage horse archers, though.
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE) // Like the other horselords.
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +3 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	//Garrison mounted class; charge and charge often.
	H.change_stat("constitution", 2) 
	H.change_stat("endurance", 2) // Your name is speed, and speed is running.
	H.change_stat("intelligence", 1) // No strength to account for the nominally better weapons. We'll see.

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord		//Bit worse shirt protection than the archer -- as foot soldier.
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale			//Makes up for worse shirt protection with kinda better armor protection
	head = /obj/item/clothing/head/roguetown/helmet/winged				//Same as the sallet, but fleet!
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/gorget

	H.adjust_blindness(-3)
	var/weapons = list("Glaive","Sword & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Glaive")
			r_hand = /obj/item/rogueweapon/halberd/glaive // Better then a halberd, but the only other polearm that makes sense is the spear, which is iron-tier.
			backl = /obj/item/gwstrap
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("Sword & Shield")
			beltr = /obj/item/rogueweapon/sword/sabre
			backl = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/guardcastle)
	H.verbs |= /mob/proc/haltyell
