//shield flail or longsword, tief can be this with red cross

/datum/job/roguetown/templar
	title = "Templar"
	flag = TEMPLAR
	department_flag = CHURCHMEN
	selection_color = JCOLOR_CHURCH
	faction = "Station"
	tutorial = "Templars are warriors who have forsaken wealth and title in lieu of service to the church, due to either zealotry or a past shame. They guard the church and its priest; largely ceremonially."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = ALL_PATRONS
	outfit = /datum/outfit/job/roguetown/templar
	min_pq = 3 //Deus vult, but only according to the proper escalation rules
	max_pq = null
	round_contrib_points = 2
	total_positions = 3
	spawn_positions = 3
	advclass_cat_rolls = list(CTAG_TEMPLAR = 20)
	display_order = JDO_TEMPLAR

	give_bank_account = TRUE

	//No nobility for you, being a member of the clergy means you gave UP your nobility. It says this in many of the church tutorial texts.
	virtue_restrictions = list(/datum/virtue/utility/noble, /datum/virtue/sucker/lesser_bloodsucker)

/datum/job/roguetown/templar/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/templar
	has_loadout = TRUE
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/storage/keyring/churchie
	id = /obj/item/clothing/ring/silver
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/ritechalk)

/datum/job/roguetown/templar/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/templar/monk
	name = "Monk"
	tutorial = "You are a monk of the Church, trained in pugilism and acrobatics. You bear no armor but your faith, and your hands are lethal weapons in service to your God."
	outfit = /datum/outfit/job/roguetown/templar/monk

	category_tags = list(CTAG_TEMPLAR)

/datum/outfit/job/roguetown/templar/monk/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
			cloak = /obj/item/clothing/cloak/tabard/crusader/aeternus
		if(/datum/patron/peoples_pantheon/cinella)
			neck = /obj/item/clothing/neck/roguetown/psicross/cinella
			cloak = /obj/item/clothing/cloak/cinellatabard
		if(/datum/patron/three_sisters/tamari)
			neck = /obj/item/clothing/neck/roguetown/psicross/tamari
			cloak = /obj/item/clothing/cloak/tabard/crusader/tamari
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 2, TRUE) //SOLARIS EDIT. better than templar at the funny shapeshifting because you're already punching things. Worse than unarmed usually anyways.
			to_chat(H, span_notice("As a follower of Tamari, you have innate knowledge of druidic magic."))
		if(/datum/patron/lording_three/tsoridys)
			neck = /obj/item/clothing/neck/roguetown/psicross/tsoridys
			cloak = /obj/item/clothing/cloak/templar/tsoridian
		if(/datum/patron/peoples_pantheon/varielle)
			neck = /obj/item/clothing/neck/roguetown/psicross/varielle
			cloak = /obj/item/clothing/cloak/templar/variellian
		if(/datum/patron/lording_three/zira)
			neck = /obj/item/clothing/neck/roguetown/psicross/zira
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
		if(/datum/patron/peoples_pantheon/carthus)
			neck = /obj/item/clothing/neck/roguetown/psicross/carthus
			cloak = /obj/item/clothing/cloak/tabard/crusader/carthus
		if(/datum/patron/three_sisters/nunos)
			neck = /obj/item/clothing/neck/roguetown/psicross/nunos
			cloak = /obj/item/clothing/cloak/templar/nunite
		if(/datum/patron/three_sisters/nunos)
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
			cloak = /obj/item/clothing/cloak/templar/kasmidian
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
		if(H.patron?.type == /datum/patron/three_sisters/nunos)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
		H.cmode_music = 'sound/music/combat_holy.ogg'
		H.change_stat("strength", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 2)
		H.change_stat("perception", -1)

		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)


	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/templar/monk/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Katar")
	switch(H.patron?.type)
		if(/datum/patron/peoples_pantheon/varielle)
			weapons += "Close Caress"
		if(/datum/patron/peoples_pantheon/cinella)
			weapons += "Barotrauma"

	var/weapon_choice = input(H,"Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Katar")
			H.put_in_hands(new /obj/item/rogueweapon/katar(H), TRUE)
		if("Close Caress")
			H.put_in_hands(new /obj/item/rogueweapon/knuckles/varielle(H), TRUE)
		if("Barotrauma")
			H.put_in_hands(new /obj/item/rogueweapon/katar/cinella(H), TRUE)

/datum/advclass/templar/crusader
	name = "Templar"
	tutorial = "You are a templar of the Church, trained in heavy weaponry and zealous warfare. You are the instrument of your God's wrath, clad in steel and faith."
	outfit = /datum/outfit/job/roguetown/templar/crusader

	category_tags = list(CTAG_TEMPLAR)

/datum/outfit/job/roguetown/templar/crusader/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	wrists = /obj/item/clothing/neck/roguetown/psicross/aeternus
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			wrists = /obj/item/clothing/neck/roguetown/psicross/aeternus
			head = /obj/item/clothing/head/roguetown/helmet/heavy/aeternian
			cloak = /obj/item/clothing/cloak/templar/aeternian
		if(/datum/patron/peoples_pantheon/cinella)
			wrists = /obj/item/clothing/neck/roguetown/psicross/cinella
			head = /obj/item/clothing/head/roguetown/helmet/heavy/cinellagreathelm
			cloak = /obj/item/clothing/cloak/cinellatabard
		if(/datum/patron/three_sisters/tamari)
			wrists = /obj/item/clothing/neck/roguetown/psicross/tamari
			head = /obj/item/clothing/head/roguetown/helmet/heavy/tamarihelm
			cloak = /obj/item/clothing/cloak/tabard/crusader/tamari
			H.grant_language(/datum/language/beast)
			H.mind.adjust_skillrank(/datum/skill/magic/druidic, 1, TRUE) //SOLARIS EDIT. worse than Monk because there's no reason you should be using this over your weapon skills. You get the goofy ones as a ribbon.
			to_chat(H, span_notice("As a follower of Tamari, you have innate knowledge of druidic magic.")) 
		if(/datum/patron/lording_three/tsoridys)
			wrists = /obj/item/clothing/neck/roguetown/psicross/tsoridys
			head = /obj/item/clothing/head/roguetown/helmet/heavy/tsoridian
			cloak = /obj/item/clothing/cloak/templar/tsoridian
		if(/datum/patron/peoples_pantheon/varielle)
			wrists = /obj/item/clothing/neck/roguetown/psicross/varielle
			head = /obj/item/clothing/head/roguetown/helmet/heavy/variellian
			cloak = /obj/item/clothing/cloak/templar/variellian
		if(/datum/patron/lording_three/zira)
			wrists = /obj/item/clothing/neck/roguetown/psicross/zira
			head = /obj/item/clothing/head/roguetown/helmet/heavy/zirahelm
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
		if(/datum/patron/peoples_pantheon/carthus)
			wrists = /obj/item/clothing/neck/roguetown/psicross/carthus
			head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
			cloak = /obj/item/clothing/cloak/tabard/crusader/carthus
		if(/datum/patron/three_sisters/nunos)
			wrists = /obj/item/clothing/neck/roguetown/psicross/nunos
			cloak = /obj/item/clothing/cloak/templar/nunite
			head = /obj/item/clothing/head/roguetown/helmet/heavy/nunos
	backr = /obj/item/rogueweapon/shield/tower/metal
	gloves = /obj/item/clothing/gloves/roguetown/chain
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	armor = /obj/item/clothing/suit/roguetown/armor/plate	///Half-Plate not fullplate
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
		if(H.patron?.type == /datum/patron/three_sisters/nunos)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)	//May tone down to 2; seems OK.
		H.cmode_music = 'sound/music/combat_holy.ogg'
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/templar/crusader/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Bastard Sword","Flail","Mace","Battle Axe")
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus) //Unique patron weapons, more can be added here if wanted.
			weapons += "Solar Judgement"
		if(/datum/patron/lording_three/zira)
			weapons += "Moonlight Khopesh"
		if(/datum/patron/lording_three/tsoridys)
			weapons += "Swift End"
		if(/datum/patron/three_sisters/nunos)
			weapons += "Forgefiend"
		if(/datum/patron/three_sisters/tamari)
			weapons += "Summer Scythe"
		if(/datum/patron/three_sisters/kasmidian)
			weapons += "Cackle Lash"
		if(/datum/patron/peoples_pantheon/carthus)
			weapons += "Duel Settler"
		if(/datum/patron/peoples_pantheon/varielle)
			weapons += "The Heartstring"
	var/weapon_choice = input(H,"Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Bastard Sword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Flail")
			H.put_in_hands(new /obj/item/rogueweapon/flail(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		if("Mace")
			H.put_in_hands(new /obj/item/rogueweapon/mace(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		if("Battle Axe")
			H.put_in_hands(new /obj/item/rogueweapon/stoneaxe/battle(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		if("Solar Judgement")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long/exe/aeternus(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Moonlight Khopesh")
			H.put_in_hands(new /obj/item/rogueweapon/sword/sabre/nockhopesh(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Swift End")
			H.put_in_hands(new /obj/item/rogueweapon/flail/sflail/tsoridysflail(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		if("Forgefiend")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long/nunosflamm(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Summer Scythe")
			H.put_in_hands(new /obj/item/rogueweapon/halberd/bardiche/scythe(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE) // again, needs skill to actually use the weapon
		if("Cackle Lash")
			H.put_in_hands(new /obj/item/rogueweapon/whip/kasmidian(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		if("Duel Settler")
			H.put_in_hands(new /obj/item/rogueweapon/mace/goden/steel/carthus(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		if("The Heartstring")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/varielle(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
