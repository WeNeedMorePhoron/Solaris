/datum/job/roguetown/steward
	title = "Steward"
	flag = STEWARD
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_patrons = ALL_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_STEWARD
	tutorial = "Coin, Coin, Coin! Oh beautiful coin: You're addicted to it, and you hold the position as the Marquis' personal treasurer of both coin and information. You know the power silver and gold has on a man's mortal soul, and you know just what lengths they'll go to in order to get even more."
	outfit = /datum/outfit/job/roguetown/steward
	give_bank_account = 22
	noble_income = 16
	min_pq = 3 //Please don't give the vault keys to somebody that's going to lock themselves in on accident
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'
	virtue_restrictions = list(/datum/virtue/utility/outlander, /datum/virtue/sucker/lesser_bloodsucker)//Command roles probably shouldn't be from Not Here

/datum/job/roguetown/steward/after_spawn(mob/living/L, mob/M, latejoin)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/steward/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/steward
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random	//Added Silk Stockings for the female nobles
	else if(should_wear_masc_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/silktunic
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquegold/steward
	beltr = /obj/item/storage/keyring/steward
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", -1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
