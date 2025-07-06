/datum/job/roguetown/priest
	title = "Priest"
	flag = PRIEST
	department_flag = CHURCHMEN
	selection_color = JCOLOR_CHURCH
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_CHURCH
	f_title = "Priestess"
	allowed_races = RACES_NO_CONSTRUCT		//Too recent arrivals to ascend to priesthood.
	allowed_patrons = ALL_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The nine protect; and it is your watch that has kept the church comfortable under such, even through the debates of nobles and scholars, balance and change. Aeternus guides your hand, yet still; \
				to keep this as it is, fraught as it may sometimes feel - and your own opinions therein..."
	whitelist_req = FALSE

	spells = list(/obj/effect/proc_holder/spell/invoked/cure_rot, /obj/effect/proc_holder/spell/self/convertrole/templar, /obj/effect/proc_holder/spell/self/convertrole/monk)
	outfit = /datum/outfit/job/roguetown/priest

	display_order = JDO_PRIEST
	give_bank_account = 115
	min_pq = 5 // You should know the basics of things if you're going to lead the town's entire religious sector
	max_pq = null
	round_contrib_points = 3

	//No nobility for you, being a member of the clergy means you gave UP your nobility. It says this in many of the church tutorial texts.
	virtue_restrictions = list(/datum/virtue/utility/noble, /datum/virtue/utility/outlander, /datum/virtue/sucker/lesser_bloodsucker) //Local priests probably shouldn't be from Not Here, though monks and the like make sense.

/datum/job/roguetown/priest/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/priest/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
	head = /obj/item/clothing/head/roguetown/priestmask
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	beltl = /obj/item/storage/keyring/priest
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/active/nomag
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/priest
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/needle/infinite = 1,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/ritechalk,
	)
	ADD_TRAIT(H, TRAIT_CHOSEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	if(H.mind)
		H.cmode_music = 'sound/music/combat_holy.ogg'
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -1)
	var/datum/devotion/C = new /datum/devotion(H, H.patron) // This creates the cleric holder used for devotion spells
	C.grant_spells_priest(H)
	if (!H.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/revive)) // If not an aethernus priest, we give them Revive
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/revive)
	else // If aethernus priest, we give them turn undead since we are nice people.
		if (!H.mind?.has_spell(/obj/effect/proc_holder/spell/targeted/abrogation))
			H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/abrogation)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	H.verbs |= /mob/living/carbon/human/proc/coronate_lord
	H.verbs |= /mob/living/carbon/human/proc/churchexcommunicate
	H.verbs |= /mob/living/carbon/human/proc/churchannouncement


/mob/living/carbon/human/proc/coronate_lord()
	set name = "Coronate"
	set category = "Priest"
	if(!mind)
		return
	if(!istype(get_area(src), /area/provincial/indoors/town/church))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE
	for(var/mob/living/carbon/human/HU in get_step(src, src.dir))
		if(!HU.mind)
			continue
		if(HU.mind.assigned_role == "Marquis")
			continue
		if(!HU.head)
			continue
		if(!istype(HU.head, /obj/item/clothing/head/roguetown/crown/serpcrown))
			continue

		//Abdicate previous King
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.mind)
				if(HL.mind.assigned_role == /datum/job/roguetown/lord::title)
					HL.mind.assigned_role = "Towner" //So they don't get the innate traits of the king
			//would be better to change their title directly, but that's not possible since the title comes from the job datum
			if(HL.job == /datum/job/roguetown/lord::title)
				HL.job = /datum/job/roguetown/exlord::title

		//Coronate new King (or Queen)
		HU.mind.assigned_role = /datum/job/roguetown/lord::title
		HU.job = /datum/job/roguetown/lord::title
		if(should_wear_femme_clothes(HU))
			SSticker.rulertype = /datum/job/roguetown/lord::f_title
		else
			SSticker.rulertype = /datum/job/roguetown/lord::title
		SSticker.rulermob = HU
		var/dispjob = mind.assigned_role
		removeomen(OMEN_NOLORD)
		say("By the authority of the gods, I pronounce you Ruler of all Sunmarch!")
		priority_announce("[real_name] the [dispjob] has named [HU.real_name] the inheritor of SOLARIS RIDGE!", title = "Long Live [HU.real_name]!", sound = 'sound/misc/bell.ogg', sender = src)

/mob/living/carbon/human/proc/churchexcommunicate()
	set name = "Curse"
	set category = "Priest"
	if(stat)
		return
	var/inputty = input("Curse someone... (curse them again to remove it)", "Sinner Name") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/provincial/indoors/town/church))
			to_chat(src, span_warning("I need to do this from the chapel."))
			return FALSE
		if(inputty in GLOB.excommunicated_players)
			GLOB.excommunicated_players -= inputty
			priority_announce("[real_name] has forgiven [inputty]. Once more walk in the light!", title = "Hail the Nine!", sound = 'sound/misc/bell.ogg')
			for(var/mob/living/carbon/human/H in GLOB.player_list)
				if(H.real_name == inputty)
					H.remove_stress(/datum/stressevent/psycurse)
			return
		var/found = FALSE
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H == src)
				continue
			if(H.real_name == inputty)
				found = TRUE
				H.add_stress(/datum/stressevent/psycurse)
		if(!found)
			return FALSE
		GLOB.excommunicated_players += inputty
		priority_announce("[real_name] has put the curse of woe on [inputty] for offending the church!", title = "SHAME", sound = 'sound/misc/excomm.ogg')

/mob/living/carbon/human/proc/churchannouncement()
	set name = "Announcement"
	set category = "Priest"
	if(stat)
		return
	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/provincial/indoors/town/church))
			to_chat(src, span_warning("I need to do this from the chapel."))
			return FALSE
		priority_announce("[inputty]", title = "The Priest Speaks", sound = 'sound/misc/bell.ogg')

/obj/effect/proc_holder/spell/self/convertrole/templar
	name = "Recruit Templar"
	new_role = "Templar"
	overlay_state = "recruit_templar"
	recruitment_faction = "Templars"
	recruitment_message = "Serve the Nine, %RECRUIT!"
	accept_message = "FOR THE NINE!"
	refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/monk
	name = "Recruit Acolyte"
	new_role = "Acolyte"
	overlay_state = "recruit_acolyte"
	recruitment_faction = "Church"
	recruitment_message = "Serve the Nine, %RECRUIT!"
	accept_message = "FOR THE NINE!"
	refuse_message = "I refuse."
