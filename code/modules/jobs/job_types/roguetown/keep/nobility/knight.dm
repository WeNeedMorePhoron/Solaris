/datum/job/roguetown/knight
	title = "Knight" //Back to proper knights.
	flag = KNIGHT
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself both loyal and capable, you have been knighted to serve the realm as the royal family's sentry. You listen to your Liege and the Knight Captain, defending your Lord and realm - a beacon of chivalry."
	display_order = JDO_KNIGHT
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/knight
	advclass_cat_rolls = list(CTAG_ROYALGUARD = 20)

	give_bank_account = 22
	noble_income = 10
	min_pq = 8
	max_pq = null
	round_contrib_points = 2
	virtue_restrictions = list(/datum/virtue/sucker/lesser_bloodsucker)

	cmode_music = 'sound/music/combat_knight.ogg'

/datum/job/roguetown/knight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(ishuman(L))
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
			S.name = "knight's tabard ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Ser"
		if(should_wear_femme_clothes(H))
			honorary = "Dame"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

		for(var/X in peopleknowme)
			for(var/datum/mind/MF in get_minds(X))
				if(MF.known_people)
					MF.known_people -= prev_real_name
					H.mind.person_knows_me(MF)

/datum/outfit/job/roguetown/knight
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	neck = /obj/item/clothing/neck/roguetown/bevor
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison
	backpack_contents = list(/obj/item/storage/keyring/guardcastle = 1)

/datum/outfit/job/roguetown/knight/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODTRAINER, TRAIT_GENERIC)

/datum/advclass/knight/heavy
	name = "Heavy Knight"
	tutorial = "You've trained thoroughly and hit far harder than most - adept with massive swords, axes, maces, and polearms. People may fear the mounted knights, but they should truly fear those who come off their mount..."
	outfit = /datum/outfit/job/roguetown/knight/heavy

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/heavy/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE) //Polearms are pretty much explicitly a two-handed weapon, so I gave them a polearm option.
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)	//Too heavy for horses.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell


	H.change_stat("strength", 3) //Heavy hitters. Less con/end, high strength.
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", 1)

	H.adjust_blindness(-3)
	var/weapons = list("Zweihander","Great Mace","Battle Axe","Estoc","Lucerne")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			backl = /obj/item/gwstrap
		if("Great Mace")
			r_hand = /obj/item/rogueweapon/mace/goden/steel
		if("Battle Axe")
			r_hand = /obj/item/rogueweapon/stoneaxe/battle
		if("Estoc")
			r_hand = /obj/item/rogueweapon/estoc
			backl = /obj/item/gwstrap
		if("Lucerne")
			r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
			backl = /obj/item/gwstrap

	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs

	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine,
		"Coat of Plates"	= /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)

/datum/advclass/knight/footknight
	name = "Foot Knight"
	tutorial = "You are accustomed to traditional foot-soldier training in one-handed weapons such as flails, swords, and maces. Your fortitude and mastery with the versatile combination of a shield and weapon makes you a fearsome opponent to take down!"
	outfit = /datum/outfit/job/roguetown/knight/footknight

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/footknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	H.change_stat("strength", 1) //Tanky, less strength, but high con/end.
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("intelligence", 1)

	H.adjust_blindness(-3)
	var/weapons = list("Bastard Sword","Flail","Warhammer")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Bastard Sword")
			beltr = /obj/item/rogueweapon/sword/long
		if("Flail")
			beltr = /obj/item/rogueweapon/flail/sflail
		if ("Warhamer")
			beltr = /obj/item/rogueweapon/mace/warhammer //Iron warhammer. This is one-handed and pairs well with shields. They can upgrade to steel in-round.

	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	backl = /obj/item/rogueweapon/shield/tower/metal

	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine,
		"Coat of Plates"	= /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)

/datum/advclass/knight/mountedknight
	name = "Mounted Knight"
	tutorial = "You are the picture-perfect knight from a high tale, knowledgeable in riding steeds into battle. You specialize in weapons most useful on a saiga including spears, swords, maces, and a variety of ranged weaponry."
	outfit = /datum/outfit/job/roguetown/knight/mountedknight
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/mountedknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	H.change_stat("strength", 2) //Decent all-around stats. Nothing spectacular. Ranged/melee hybrid class on horseback.
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 1)

	H.adjust_blindness(-3)
	var/weapons = list("Bastard Sword + Crossbow","Billhook + Recurve Bow","Grand Mace + Longbow")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Bastard Sword + Crossbow")
			beltl = /obj/item/rogueweapon/sword/long
			beltr = /obj/item/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		if("Billhook + Recurve Bow")
			r_hand = /obj/item/rogueweapon/spear/billhook
			backl = /obj/item/gwstrap
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		if("Grand Mace + Longbow")
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/rogueweapon/mace/goden/steel

	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs

	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine,
		"Coat of Plates"	= /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)


/datum/advclass/knight/irregularknight
	name = "Royal Champion"
	tutorial = "Your skillset is abnormal for a knight. Your swift maneuvers and masterful technique impress both lords and ladies alike, and you have a preference for quicker, more elegant blades. While you are an effective fighting force in medium armor, your evasive skills will only truly shine if you don even lighter protection."
	outfit = /datum/outfit/job/roguetown/knight/irregularknight

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/irregularknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE) //Swords and knives class.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE) //Whips can work as a light class weapon.
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE) //Bows fit a light/speedy class pretty well, gave them ranged options.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 2)
	H.change_stat("intelligence", 1)

	H.adjust_blindness(-3)
	var/weapons = list("Rapier + Longbow","Estoc + Recurve Bow","Sabre + Buckler","Whip + Crossbow")
	var/armor_options = list("Light Armor", "Medium Armor")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armor_options
	H.set_blindness(0)
	switch(weapon_choice)
		if("Rapier + Longbow")
			beltl = /obj/item/rogueweapon/sword/rapier
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
			beltr = /obj/item/quiver/arrows

		if("Estoc + Recurve Bow")
			r_hand = /obj/item/rogueweapon/estoc
			backl = /obj/item/gwstrap
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve

		if("Sabre + Buckler")
			beltl = /obj/item/rogueweapon/sword/sabre
			backl = /obj/item/rogueweapon/shield/buckler

		if("Whip + Crossbow")
			beltl = /obj/item/rogueweapon/whip
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltr = /obj/item/quiver/bolts

	switch(armor_choice)
		if("Light Armor")
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
		if("Medium Armor")
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			pants = /obj/item/clothing/under/roguetown/chainlegs
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light

	var/helmets = list(
		"Pigface Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Bascinet"				= /obj/item/clothing/head/roguetown/helmet/bascinet,
		"Sallet"				= /obj/item/clothing/head/roguetown/helmet/sallet,
		"Visored Sallet"		= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Hounskull Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)

	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)


/datum/advclass/knight/reiter
	name = "Reiter"
	tutorial = "You are a Reiter Cavalryman, a new type of heavily armed knight, known for using pistols in coordinated volleys while wearing plate armor. They emphasize mobility and firepower over the traditional shock tactics of knights."
	outfit = /datum/outfit/job/roguetown/knight/reiter

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/reiter/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
	cloak = /obj/item/clothing/cloak/tabard
	neck = /obj/item/clothing/neck/roguetown/bevor
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/ammopouch/bullets
	backr = /obj/item/storage/backpack/rogue/satchel/black
	pants = /obj/item/clothing/under/roguetown/chainlegs
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	id = /obj/item/scomstone/bad/garrison
	backpack_contents = list(/obj/item/gun/ballistic/arquebus_pistol = 1, /obj/item/powderhorn = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/bait/doe = 1)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)


	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.verbs |= /mob/proc/haltyell

	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("fortune", 1) // brings in line with the other knights total of 9 (weighted), reason:Lucky for this thing to not blow your hand off

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/advclass/knight/arcane
	name = "Arcane Knight"
	tutorial = "Someone who has braved many of the dangers of the world to knighthood, now on the precipe of swearing their being to the unknown to protect the sunmarch"
	outfit = /datum/outfit/job/roguetown/knight/arcane
	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/arcane/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("Speed", 2)	
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)


	H.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_MELEE
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/warlock/summon_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/boomingblade)
	H.put_in_hands(giveweapon(H,"Sunmarch"), FALSE)

	var/helmets = list(
		"Pigface Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Bascinet"				= /obj/item/clothing/head/roguetown/helmet/bascinet,
		"Sallet"				= /obj/item/clothing/head/roguetown/helmet/sallet,
		"Visored Sallet"		= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Hounskull Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)

	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

/datum/outfit/job/roguetown/knight/arcane/proc/giveweapon(mob/living/carbon/human/human, patronchoice)
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

	// Make sure the lists exist
	if(!islist(human.mind.warlock_weapons))
		human.mind.warlock_weapons = list()
	if(!islist(human.mind.warlock_weapon_types))
		human.mind.warlock_weapon_types = list()

	human.mind.warlock_weapons += item
	human.mind.warlock_weapon_types += item_type


