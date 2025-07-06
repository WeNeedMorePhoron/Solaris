/datum/job/roguetown/captain
	title = "Knight Captain" //The Knight Captain is clearly not drawn from the ranks of guardsmen, or sergeants. They're drawn from the Knightly ranks and should be treated as such.
	flag = GUARD_CAPTAIN
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Your lineage is noble, and generations of strong, loyal knights have come before you. You served your time \
	gracefully as knight of his royal majesty, and now you've grown into a role which many men can only dream of becoming. \
	Lead your men to victory--and keep them in line--and you will see this realm prosper under a thousand suns."
	display_order = JDO_GUARD_CAPTAIN
	advclass_cat_rolls = list(CTAG_CAPTAIN = 20)

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	outfit = /datum/outfit/job/roguetown/captain

	give_bank_account = 26
	noble_income = 16
	min_pq = 9
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_knight.ogg'
	virtue_restrictions = list(/datum/virtue/utility/outlander, /datum/virtue/sucker/lesser_bloodsucker)//Command roles probably shouldn't be from Not Here

/datum/outfit/job/roguetown/captain
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	cloak = /obj/item/clothing/cloak/stabard
	id = /obj/item/scomstone/garrison

/datum/job/roguetown/captain/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "Captain Tabard ([index])"
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

		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/captain/infantry
	name = "Infantry Captain"
	tutorial = "You've fought shoulder to shoulder with the realm's worthiest Knights while embedded directly within \
	massed infantry formations. As a peerless armed combatant and tactician both, you are a formidable presence \
	on any battlefield."
	outfit = /datum/outfit/job/roguetown/captain/infantry
	category_tags = list(CTAG_CAPTAIN)	

/datum/outfit/job/roguetown/captain/infantry/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/storage/backpack/rogue/satchel/black
	armor = /obj/item/clothing/suit/roguetown/armor/plate	
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs	
	backpack_contents = list(
		/obj/item/storage/keyring/sheriff = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		)	
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("fortune", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) 		//The knightly-est knight to ever knight in the realm.
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.adjust_blindness(-3)
	var/weapons = list(
		"Zweihander",
		"Great Mace",
		"Battle Axe",
		"Estoc",
		"Bastard Sword & Shield",
		"Flail & Shield",
		"Sabre & Shield",
		)
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			backl = /obj/item/gwstrap
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		if("Great Mace")
			r_hand = /obj/item/rogueweapon/mace/goden/steel
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		if("Battle Axe")
			r_hand = /obj/item/rogueweapon/stoneaxe/battle
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		if("Estoc")
			r_hand = /obj/item/rogueweapon/estoc
			backl = /obj/item/gwstrap
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		if("Bastard Sword & Shield")
			beltr = /obj/item/rogueweapon/sword/long
			backl = /obj/item/rogueweapon/shield/tower/metal
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if("Flail & Shield")
			beltr = /obj/item/rogueweapon/flail/sflail
			backl = /obj/item/rogueweapon/shield/tower/metal
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if("Sabre & Shield")
			beltr = /obj/item/rogueweapon/sword/sabre
			backl = /obj/item/rogueweapon/shield/tower/metal
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
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

/datum/advclass/captain/cavalry
	name = "Cavalry Captain"
	tutorial = "As the first among finest you ride at the speartip of cavalier forces, barreling saiga and blades through \
	the soft flanks and hard fronts of enemy formations, remember Agincourt, and do not hit the dirt below."
	outfit = /datum/outfit/job/roguetown/captain/cavalry
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled
	category_tags = list(CTAG_CAPTAIN)

/datum/outfit/job/roguetown/captain/cavalry/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	backr = /obj/item/storage/backpack/rogue/satchel/black
	armor = /obj/item/clothing/suit/roguetown/armor/plate	
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	backpack_contents = list(
		/obj/item/storage/keyring/sheriff = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		)
		
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("fortune", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) 		//The knightly-est knight to ever knight in the realm.
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.adjust_blindness(-3)
	var/weapons = list(
		"Bastard Sword & Recurve Bow",
		"Mace & Crossbow",
		"Spear & Shield",
		"Sabre & Shield",
		)
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Bastard Sword & Recurve Bow")
			r_hand = /obj/item/rogueweapon/sword/long
			beltr = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)			
		if("Mace & Crossbow")
			r_hand = /obj/item/rogueweapon/mace
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltr = /obj/item/quiver/bolts
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		if("Spear & Shield")
			r_hand = /obj/item/rogueweapon/spear
			backl = /obj/item/rogueweapon/shield/tower/metal
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if("Sabre & Shield")
			beltr = /obj/item/rogueweapon/sword/sabre
			backl = /obj/item/rogueweapon/shield/tower/metal
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)		
	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Hounskull Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

/datum/advclass/captain/duelist
	name = "Champion Knight"
	tutorial = "A knight who has earned their place in many duels of honor and tournement. Their display of skill, honor and bravery on the battlefield has earned them the right to lead their fellow knights into battle. This has lead them "
	outfit = /datum/outfit/job/roguetown/captain/duelist
	category_tags = list(CTAG_CAPTAIN)

/datum/outfit/job/roguetown/captain/duelist/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(
		/obj/item/storage/keyring/sheriff = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 2)
		H.change_stat("fortune", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) 		//The knightly-est knight to ever knight in the realm.
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.adjust_blindness(-3)
	var/weapons = list(
		"Katar & Longbow",
		"Estoc & Recurve",
		"Sabre & Pistol",
		"Whip & Buckler",
		"Rapier & Longbow",
		)

	var/armor_options = list("Medium Armor", "Heavy Armor")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armor_options
	H.set_blindness(0)
	switch(weapon_choice)
		if("Katar & Longbow")
			beltl = /obj/item/rogueweapon/katar
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
			beltr = /obj/item/quiver/arrows
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)

		if("Estoc & Recurve Bow")
			r_hand = /obj/item/rogueweapon/estoc
			backl = /obj/item/gwstrap
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)

		if("Sabre & Pistol")
			r_hand = /obj/item/powderhorn
			beltl = /obj/item/gun/ballistic/arquebus_pistol
			backl = /obj/item/rogueweapon/sword/sabre
			beltr = /obj/item/ammopouch/bullets
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 5, TRUE)

		if("Rapier & Buckler")
			beltl = /obj/item/rogueweapon/whip
			backl = /obj/item/rogueweapon/shield/buckler
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)

		if("Rapier & Longbow")
			beltl = /obj/item/rogueweapon/sword/rapier
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
			beltr = /obj/item/quiver/arrows
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)

	switch(armor_choice)
		if("Medium Armor")
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SENTINELOFWITS, TRAIT_GENERIC)
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/fencer
			pants = /obj/item/clothing/under/roguetown/chainlegs
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			H.change_stat("speed", 3)

		if("Heavy Armor")
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			pants = /obj/item/clothing/under/roguetown/chainlegs
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat
			H.change_stat("strength", 3)

			
	var/helmets = list(
		"Pigface Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Bascinet"				= /obj/item/clothing/head/roguetown/helmet/bascinet,
		"Sallet"				= /obj/item/clothing/head/roguetown/helmet/sallet,
		"Visored Sallet"		= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Hounskull Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
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
		
			
/datum/advclass/captain/carian
	name = "Royal Magic Knight"
	tutorial = "A Knight who has offered their might and body to a pact or rite to attain power in service of their lord, empowered they may be the magic they wield is not theres to call their own."
	outfit = /datum/outfit/job/roguetown/captain/carian
	category_tags = list(CTAG_CAPTAIN)

/datum/outfit/job/roguetown/captain/carian/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	backr = /obj/item/storage/backpack/rogue/satchel/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/fencer
	pants = /obj/item/clothing/under/roguetown/chainlegs
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	backpack_contents = list(
		/obj/item/storage/keyring/sheriff = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.change_stat("constitution", 2) // 12 total points to be conservative
		H.change_stat("intelligence", 4)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) 		//The knightly-est knight to ever knight in the realm.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	H.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_ELITE
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade) 
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/warlock/summon_weapon)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/cloakofflies)
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

/datum/outfit/job/roguetown/captain/carian/proc/giveweapon(mob/living/carbon/human/human, patronchoice)
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


/obj/effect/proc_holder/spell/self/convertrole
	name = "Recruit Beggar"
	desc = "Recruit someone to your cause."
	overlay_state = "recruit_bog"
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Role given if recruitment is accepted
	var/new_role = "Beggar"
	/// Faction shown to the user in the recruitment prompt
	var/recruitment_faction = "Beggars"
	/// Message the recruiter gives
	var/recruitment_message = "Serve the beggars, %RECRUIT!"
	/// Range to search for potential recruits
	var/recruitment_range = 3
	/// Say message when the recruit accepts
	var/accept_message = "I will serve!"
	/// Say message when the recruit refuses
	var/refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/cast(list/targets,mob/user = usr)
	. = ..()
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/recruit in (get_hearers_in_view(recruitment_range, user) - user))
		//not allowed
		if(!can_convert(recruit))
			continue
		recruitment[recruit.name] = recruit
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential recruits in range."))
		return
	var/inputty = input(user, "Select a potential recruit!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(recruitment_range, user)))
			INVOKE_ASYNC(src, PROC_REF(convert), recruit, user)
		else
			to_chat(user, span_warning("Recruitment failed!"))
	else
		to_chat(user, span_warning("Recruitment cancelled."))

/obj/effect/proc_holder/spell/self/convertrole/proc/can_convert(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//only migrants and peasants
	if(!(recruit.job in GLOB.peasant_positions) && !(recruit.job in GLOB.yeoman_positions) && !(recruit.job in GLOB.allmig_positions))
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/proc/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE
	recruiter.say(replacetext(recruitment_message, "%RECRUIT", "[recruit]"), forced = "[name]")
	var/prompt = alert(recruit, "Do you wish to become a [new_role]?", "[recruitment_faction] Recruitment", "Yes", "No")
	if(QDELETED(recruit) || QDELETED(recruiter) || !(recruiter in get_hearers_in_view(recruitment_range, recruit)))
		return FALSE
	if(prompt != "Yes")
		if(refuse_message)
			recruit.say(refuse_message, forced = "[name]")
		return FALSE
	if(accept_message)
		recruit.say(accept_message, forced = "[name]")
	if(new_role)
		recruit.job = new_role
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/guard
	name = "Recruit Guardsmen"
	new_role = "Watchman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Watchman"
	recruitment_message = "Serve the town guard, %RECRUIT!"
	accept_message = "FOR THE CROWN!"
	refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/guard/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	. = ..()
	if(!.)
		return
	recruit.verbs |= /mob/proc/haltyell
