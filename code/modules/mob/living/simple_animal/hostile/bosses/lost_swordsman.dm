/mob/living/simple_animal/hostile/boss/lost_swordsman
	name = "Forgotten Swordsman"
	desc = "What was once an honorable knight glittering in the dawns light has become... this. End their nightmare."
	mob_biotypes = MOB_HUMANOID|MOB_UNDEAD
	boss_abilities = list(/datum/action/boss/martialdash,/datum/action/boss/bladedance,/datum/action/boss/secondwind)
	faction = list("miniboss")
	del_on_death = TRUE
	icon = 'icons/mob/solaris_badasses.dmi'
	icon_state = "lost_swordsman"
	wander = 1
	vision_range = 4
	aggro_vision_range = 18
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 100
	base_intents = list(/datum/intent/simple/miniboss_bigsword_cleave,/datum/intent/simple/miniboss_bigsword_impale,/datum/intent/simple/miniboss_bigsword_suckerpunch)
	melee_damage_lower = 20
	melee_damage_upper = 40
	dodge_prob = 50
	health = 1200
	maxHealth = 1200
	STASTR = 18
	STAPER = 12
	STAINT = 8
	STACON = 20
	STAEND = 20
	STASPD = 15
	STALUC = 15
	loot = list(/obj/effect/spawner/lootdrop/roguetown/dungeon/money/rich, /obj/effect/spawner/lootdrop/roguetown/dungeon/gadgets, /obj/effect/spawner/lootdrop/roguetown/gems, /obj/effect/temp_visual/minibossdeath)
	footstep_type = FOOTSTEP_MOB_SHOE
	stat_attack = UNCONSCIOUS

//Effects

/obj/effect/temp_visual/trap
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	light_outer_range = 2
	duration = 14
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/blade_dance
	icon = 'icons/effects/effects.dmi'
	icon_state = "stab"
	dir = NORTH
	name = "Dance of Blades"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/minibossdeath
	icon = 'icons/effects/effects.dmi'
	icon_state = "phaseout"
	dir = NORTH
	name = "Underking's Grasp"
	desc = "Finally, freedom."
	randomdir = FALSE
	duration = 1 SECONDS
	layer = MASSIVE_OBJ_LAYER

//Basic Attacks

/datum/intent/simple/miniboss_bigsword_cleave //Weak Attack
	name = "cleave"
	icon_state = "instrike"
	attack_verb = list("cleaves", "rends", "tears")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list("genchop", "genslash")
	chargetime = 0
	penfactor = 30
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	item_d_type = "slash"

/datum/intent/simple/miniboss_bigsword_impale //Strong attack
	name = "impale"
	icon_state = "instrike"
	attack_verb = list("impales", "skewers", "runs through")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list("genstab", "genslash")
	chargetime = 0
	penfactor = 60
	swingdelay = 1
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"

/datum/intent/simple/miniboss_bigsword_suckerpunch //Equipment mauler
	name = "jab"
	icon_state = "instrike"
	attack_verb = list("uppercuts", "punches")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 10
	swingdelay = 0
	candodge = TRUE
	canparry = TRUE
	item_d_type = "blunt"

//Special Attacks

/datum/action/boss/martialdash
	check_flags = AB_CHECK_CONSCIOUS //Incase the boss is given a player
	boss_cost = 20 //Cost of usage for the boss' AI 1-100
	usage_probability = 50
	needs_target = TRUE 
	say_when_triggered = "Hrah!" 
	var/turf/dashturf
	var/dashdir

/datum/action/boss/martialdash/Trigger()
	. = ..()
	dashdir = get_dir(boss, boss.target)
	if(boss.health <= 600) //add dash feints if boss is bloodied
		if(prob(50))
			dashdir = clamp((dashdir)+1,1,10)
		else
			dashdir = clamp((dashdir)-1,1,10)
	dashturf = get_step(boss.target, dashdir)
	if(dashturf.density) //Dont backflip into a wall, legend
		return
	boss.visible_message(span_boldannounce("[boss] dashes around to [boss.target]'s blind spot!"))
	do_sparks(1, FALSE, boss)
	do_teleport(boss, dashturf, no_effects=TRUE)
	playsound(boss, 'sound/foley/martialdash.ogg', 100)

/datum/action/boss/bladedance
	check_flags = AB_CHECK_CONSCIOUS //Incase the boss is given a player
	boss_cost = 60 //Cost of usage for the boss' AI 1-100
	usage_probability = 60
	needs_target = FALSE 
	say_when_triggered = "RRAGH!"
	var/delay = 14
	var/damage = 75 //there are lines on the floor
	var/area_of_effect = 1

/datum/action/boss/bladedance/Trigger()
	. = ..()
	if(boss.health <= 600) //Wider radius when bloodied
		area_of_effect = 2
	else
		area_of_effect = 1
	var/turf/T = get_turf(boss)

	var/turf/source_turf = get_turf(boss)

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(!(affected_turf in view(source_turf)))
			continue
		new /obj/effect/temp_visual/trap(affected_turf)
	playsound(T, 'sound/foley/bladedance_telegraph.ogg', 110, TRUE, soundping = TRUE)

	sleep(delay)
	var/play_cleave = FALSE

	for(var/turf/affected_turf in view(area_of_effect, T))
		new /obj/effect/temp_visual/blade_burst(affected_turf)
		if(!(affected_turf in view(source_turf)))
			continue
		for(var/mob/living/L in affected_turf.contents)
			play_cleave = TRUE
			boss.heal_overall_damage(75) //unbelivably janky way to avoid caster damage
			L.adjustBruteLoss(damage)
			playsound(affected_turf, 'sound/foley/bladedance_swing.ogg', 110, TRUE)
			to_chat(L, "<span class='userdanger'>The Lost Swordsman gouges you in a dance of blades!</span>")

	if(play_cleave)
		playsound(T, 'sound/combat/newstuck.ogg', 80, TRUE, soundping = TRUE)

	return TRUE

/datum/action/boss/secondwind
	check_flags = AB_CHECK_CONSCIOUS //Incase the boss is given a player
	boss_cost = 90 //Cost of usage for the boss' AI 1-100
	usage_probability = 100
	needs_target = FALSE 
	say_when_triggered = "WHY!!"
	var/hashealed = FALSE

/datum/action/boss/secondwind/Trigger()
	. = ..()
	if(boss.health <= 600 && hashealed == FALSE) //Heal ourselves the first time we reach bloodied
		boss.heal_overall_damage(500)
		boss.visible_message(span_boldannounce("[boss] roars as it finds the willpower to keep fighting!"))
		hashealed = TRUE
		playsound(boss, 'sound/vo/mobs/simple_orcs/orc_yell.ogg', 70)
	else
		return

//Utility stuff

/obj/effect/temp_visual/minibossdeath/Initialize()
	. = ..()
	visible_message(span_boldannounce("The Forgotten Swordsman lets out a horrible scream and dissolves before you!"))
	playsound(src, 'sound/vo/mobs/ghost/death.ogg', 70)

/obj/effect/temp_visual/minibossdeath/Destroy()
	for(var/mob/M in range(7,src))
		shake_camera(M, 7, 1)
	return ..()







