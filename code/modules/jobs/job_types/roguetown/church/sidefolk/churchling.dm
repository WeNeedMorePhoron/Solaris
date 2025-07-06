/datum/job/roguetown/churchling
	title = "Churchling"
	flag = CHURCHLING
	department_flag = CHURCHMEN
	selection_color = JCOLOR_CHURCH
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "Your family were zealots. They scolded you with a studded belt and prayed like \
				sinners every waking hour of the day they weren't toiling in the fields. You escaped \
				them by becoming a churchling - and a guaranteed education isn't so bad, though you find \
				yourself pulling the duties of the Acolytes on regular enough occasion..."

	outfit = /datum/outfit/job/roguetown/churchling
	display_order = JDO_CHURCHLING
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null
	round_contrib_points = 2
	virtue_restrictions = list(/datum/virtue/sucker/lesser_bloodsucker)

/datum/job/roguetown/churchling/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/churchling/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.cmode_music = 'sound/music/combat_holy.ogg'
	neck = /obj/item/clothing/neck/roguetown/psicross
	if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/armingcap
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltl = /obj/item/storage/keyring/churchie


	H.change_stat("perception", 1)
	H.change_stat("speed", 2)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
