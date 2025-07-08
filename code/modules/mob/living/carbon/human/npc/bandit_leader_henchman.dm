GLOBAL_LIST_INIT(bandhench_aggro, world.file2list("strings/rt/searaideraggrolines.txt"))

/mob/living/carbon/human/species/human/bandit_leader_henchman
	aggressive=1
	mode = NPC_AI_IDLE
	faction = list("miniboss")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/human/bandit_leader_henchman/ambush
	aggressive=1
	wander = TRUE

/mob/living/carbon/human/species/human/bandit_leader_henchman/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.bandhench_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/bandit_leader_henchman/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/bandit_leader_henchman/Initialize(mob/living/L)
	. = ..()
	if(prob(50))
		set_species(/datum/species/human/northern)
	else
		set_species(/datum/species/human/halfelf)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/bandit_leader_henchman/after_creation()
	..()
	job = "Henchman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	real_name = pick("Bandit Henchman","Bandit Goon","Bandit Thug")
	gender = pick(MALE, FEMALE)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/himecut, 
						/datum/sprite_accessory/hair/head/countryponytailalt, 
						/datum/sprite_accessory/hair/head/stacy, 
						/datum/sprite_accessory/hair/head/kusanagi_alt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher, 
						/datum/sprite_accessory/hair/head/dave, 
						/datum/sprite_accessory/hair/head/emo, 
						/datum/sprite_accessory/hair/head/sabitsuki))
	var/hairc =  pick(list("#191515","#a39c3d"),"#7a440f","#3f2516")
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	var/eyec = pick(list("#29b136","#3d51be","#8b6215","#72863c"))

	if(organ_eyes)
		(organ_eyes.eye_color) = (eyec)
	hair_color = (hairc)
	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
	else
		new_hair.set_accessory_type(hairm, null, src)

	head.add_bodypart_feature(new_hair)
	if(is_species(src,/datum/species/human/northern))
		equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/bandit_leader_henchman)
	else
		equipOutfit(new /datum/outfit/job/roguetown/human/species/human/halfelf/bandit_leader_henchman)
	update_hair()
	update_body()
	src.say(pick("On it boss!","You got it boss!","Roger dat boss!","Lets get em!"))

/mob/living/carbon/human/species/human/bandit_leader_henchman/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/human/bandit_leader_henchman/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(5))
			emote("warcry")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/bandit_leader_henchman/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(H.gender == FEMALE && prob(22)) //if the bikini ever updates to works on men, remove the gender check only
		armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/raincloak
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/red
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/green
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(20))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	mask = /obj/item/clothing/mask/rogue/facemask
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/black
	if(prob(40))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	neck = /obj/item/clothing/neck/roguetown/leather
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.STASTR = rand(10,12)
	H.STASPD = rand(10,12)
	H.STACON = rand(12,14)
	H.STAEND = rand(12,14)
	H.STAPER = rand(10,12)
	H.STAINT = rand(8,10) //dump stat
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
		l_hand = /obj/item/rogueweapon/shield/wood
	else
		r_hand = /obj/item/rogueweapon/huntingknife/idagger

/datum/outfit/job/roguetown/human/species/human/halfelf/bandit_leader_henchman/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(H.gender == FEMALE && prob(22)) //if the bikini ever updates to works on men, remove the gender check only
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/raincloak
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/blue
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/purple
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(20))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	mask = /obj/item/clothing/mask/rogue/facemask
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/black
	if(prob(40))
		head = /obj/item/clothing/head/roguetown/helmet/bandana
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.STASTR = rand(10,12)
	H.STASPD = rand(12,14) //slightly higher speed as a consolation for being worse equipped
	H.STACON = rand(12,14)
	H.STAEND = rand(12,14)
	H.STAPER = rand(10,12)
	H.STAINT = rand(8,10) //dump stat
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
		l_hand = /obj/item/rogueweapon/huntingknife/idagger
	else
		r_hand = /obj/item/rogueweapon/huntingknife/idagger
	
	

