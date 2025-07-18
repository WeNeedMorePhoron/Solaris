

/mob/living/simple_animal/attack_hand(mob/living/carbon/human/M)
	..()
	switch(M.used_intent.type)
		if(INTENT_HELP)
			if (health > 0)
				visible_message(span_notice("[M] [response_help_continuous] [src]."), \
								span_notice("[M] [response_help_continuous] you."), null, null, M)
				to_chat(M, span_notice("I [response_help_simple] [src]."))
				playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
			return TRUE

		if(INTENT_GRAB)
			if(!M.has_hand_for_held_index(M.active_hand_index, TRUE)) //we obviously have a hadn, but we need to check for fingers/prosthetics
				to_chat(M, span_warning("I can't move the fingers."))
				return
			grabbedby(M)
			return TRUE

		if(INTENT_HARM)
			var/atk_verb = pick(M.used_intent.attack_verb)
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_warning("I don't want to hurt [src]!"))
				return
			M.do_attack_animation(src, M.used_intent.animname)
			playsound(loc, attacked_sound, 25, TRUE, -1)
			var/damage = M.get_punch_dmg()
			next_attack_msg.Cut()
			attack_threshold_check(damage)
			log_combat(M, src, "attacked")
			updatehealth()
			var/hitlim = simple_limb_hit(M.zone_selected)
			simple_woundcritroll(M.used_intent.blade_class, damage, M, hitlim)
			visible_message(span_danger("[M] [atk_verb] [src]![next_attack_msg.Join()]"),\
							span_danger("[M] [atk_verb] me![next_attack_msg.Join()]"), null, COMBAT_MESSAGE_RANGE)
			next_attack_msg.Cut()
			return TRUE

		if(INTENT_DISARM)
			var/mob/living/carbon/human/user = M
			var/mob/living/simple_animal/target = src
			if(!(user.mobility_flags & MOBILITY_STAND) || user.IsKnockdown())
				return FALSE
			if(user == target)
				return FALSE
			if(user.loc == target.loc)
				return FALSE
			else
				user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
				playsound(target, 'sound/combat/shove.ogg', 100, TRUE, -1)

				var/turf/target_oldturf = target.loc
				var/shove_dir = get_dir(user.loc, target_oldturf)
				var/turf/target_shove_turf = get_step(target.loc, shove_dir)
				var/mob/living/target_collateral_mob
				var/obj/structure/table/target_table
				var/shove_blocked = FALSE //Used to check if a shove is blocked so that if it is knockdown logic can be applied
				if(prob(30 + generic_stat_comparison(user.STASTR, target.STACON) ))//check if we actually shove them
					target_collateral_mob = locate(/mob/living) in target_shove_turf.contents
					if(target_collateral_mob)
						shove_blocked = TRUE
					else
						target.Move(target_shove_turf, shove_dir)
						if(get_turf(target) == target_oldturf)
							target_table = locate(/obj/structure/table) in target_shove_turf.contents
							if(target_table)
								shove_blocked = TRUE

				if(shove_blocked && !target.buckled)
					var/directional_blocked = FALSE
					if(shove_dir in GLOB.cardinals) //Directional checks to make sure that we're not shoving through a windoor or something like that
						var/target_turf = get_turf(target)
						for(var/obj/O in target_turf)
							if(O.flags_1 & ON_BORDER_1 && O.dir == shove_dir && O.density)
								directional_blocked = TRUE
								break
						if(target_turf != target_shove_turf) //Make sure that we don't run the exact same check twice on the same tile
							for(var/obj/O in target_shove_turf)
								if(O.flags_1 & ON_BORDER_1 && O.dir == turn(shove_dir, 180) && O.density)
									directional_blocked = TRUE
									break
					if((!target_table && !target_collateral_mob) || directional_blocked)
						target.Stun(10)
						target.visible_message(span_danger("[user.name] shoves [target.name]!"),
										span_danger("I'm shoved by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
						to_chat(user, span_danger("I shove [target.name]!"))
						log_combat(user, target, "shoved", "knocking them down")
					else if(target_table)
						target.Stun(10)
						target.visible_message(span_danger("[user.name] shoves [target.name] onto \the [target_table]!"),
										span_danger("I'm shoved onto \the [target_table] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
						to_chat(user, span_danger("I shove [target.name] onto \the [target_table]!"))
						target.throw_at(target_table, 1, 1, null, FALSE) //1 speed throws with no spin are basically just forcemoves with a hard collision check
						log_combat(user, target, "shoved", "onto [target_table] (table)")
					else if(target_collateral_mob)
						target.Stun(10)
						target_collateral_mob.Stun(SHOVE_KNOCKDOWN_COLLATERAL)
						target.visible_message(span_danger("[user.name] shoves [target.name] into [target_collateral_mob.name]!"),
							span_danger("I'm shoved into [target_collateral_mob.name] by [user.name]!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, user)
						to_chat(user, span_danger("I shove [target.name] into [target_collateral_mob.name]!"))
						log_combat(user, target, "shoved", "into [target_collateral_mob.name]")
				else
					target.visible_message(span_danger("[user.name] shoves [target.name]!"),
									span_danger("I'm shoved by [user.name]!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, user)
					to_chat(user, span_danger("I shove [target.name]!"))
					log_combat(user, target, "shoved")
			return TRUE

	if(M.used_intent.unarmed)
		var/atk_verb = pick(M.used_intent.attack_verb)
		if(HAS_TRAIT(M, TRAIT_PACIFISM))
			to_chat(M, span_warning("I don't want to hurt [src]!"))
			return
		M.do_attack_animation(src, M.used_intent.animname)
		playsound(loc, attacked_sound, 25, TRUE, -1)
		var/damage = M.get_punch_dmg()
		next_attack_msg.Cut()
		attack_threshold_check(damage)
		log_combat(M, src, "attacked")
		updatehealth()
		var/hitlim = simple_limb_hit(M.zone_selected)
		simple_woundcritroll(M.used_intent.blade_class, damage, M, hitlim)
		visible_message(span_danger("[M] [atk_verb] [src]![next_attack_msg.Join()]"),\
						span_danger("[M] [atk_verb] me![next_attack_msg.Join()]"), null, COMBAT_MESSAGE_RANGE)
		next_attack_msg.Cut()
		return TRUE

/mob/living/simple_animal/attack_paw(mob/living/carbon/monkey/M)
	if(..()) //successful monkey bite.
		if(stat != DEAD)
			var/damage = rand(1, 3)
			attack_threshold_check(damage)
			return 1
	if (M.used_intent.type == INTENT_HELP)
		if (health > 0)
			visible_message(span_notice("[M.name] [response_help_continuous] [src]."), \
							span_notice("[M.name] [response_help_continuous] you."), null, COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_notice("I [response_help_simple] [src]."))
			playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)


/mob/living/simple_animal/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		next_attack_msg.Cut()
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		var/hitlim = simple_limb_hit(M.zone_selected)
		attack_threshold_check(damage, M.melee_damage_type)
		simple_woundcritroll(M.a_intent.blade_class, damage, M, hitlim)
		visible_message(span_danger("\The [M] [pick(M.a_intent.attack_verb)] [src]![next_attack_msg.Join()]"), \
					span_danger("\The [M] [pick(M.a_intent.attack_verb)] me![next_attack_msg.Join()]"), null, COMBAT_MESSAGE_RANGE)
		next_attack_msg.Cut()

/mob/living/simple_animal/onbite(mob/living/carbon/human/user)
	var/damage = 10*(user.STASTR/20)
	if(HAS_TRAIT(user, TRAIT_STRONGBITE))
		damage = damage*2
	playsound(user.loc, "smallslash", 100, FALSE, -1)
	user.next_attack_msg.Cut()
	if(stat == DEAD)
		if(user.has_status_effect(/datum/status_effect/debuff/silver_curse))
			to_chat(user, span_notice("My power is weakened, I cannot heal!"))
			return
		if(user.mind && istype(user, /mob/living/carbon/human/species/werewolf))
			visible_message(span_danger("The werewolf ravenously consumes the [src]!"))
			to_chat(src, span_warning("I feed on succulent flesh. I feel reinvigorated."))
			user.reagents.add_reagent(/datum/reagent/medicine/healthpot, 30)
			gib()
		if(HAS_TRAIT(user, TRAIT_VAMPIRISM) && !HAS_TRAIT(user, TRAIT_NOVEGAN))
			var/mob/living/carbon/human/bsdrinker = user
			var/mob/living/bsvictim = src
			var/drinktime = 10 SECONDS
			var/vitaedrain = 400 //a flat 500 for now, If we get a size trait later, I'd like to use that
			var/drinkexp = 10
			if(HAS_TRAIT(user, TRAIT_EFFICIENT_DRINKER)) //halve the time and 1.5 the volume for the trait, this might never occur depending on balance
				drinktime = 5 SECONDS
				vitaedrain = 600
				drinkexp = 14
			var/bloodleft = bsvictim.blood_volume

			if(bsvictim in range(1, bsdrinker))
				if (bloodleft < 100)
					visible_message(span_danger("[bsdrinker] bites the [bsvictim]!"))
					to_chat(bsdrinker, span_warning("There's not enough blood left for me"))
				else
					visible_message(span_danger("[bsdrinker] bites the [bsvictim]!"))
					to_chat(bsdrinker, span_warning("I start to drain [bsvictim] blood"))
					if(do_after(bsdrinker, drinktime, target = bsvictim))
						to_chat(bsdrinker, span_warning("I have sated some of my thirst"))
						bsdrinker.vitae += vitaedrain //we give them some vitae depending their traits
						bsvictim.blood_volume = 0 //we set the animal's blood low so we don't have continued bites
						bsdrinker.mind.add_sleep_experience(/datum/skill/magic/vampirism, drinkexp)
						bsdrinker.mind.add_sleep_experience(/datum/skill/magic/blood, 0.50*drinkexp)
					else
						to_chat(bsdrinker, span_warning("I need them still to drink")) //we moved away or they did
		else 
			visible_message(span_danger("[user] bites the [src]!"))
			if(HAS_TRAIT(user, TRAIT_NOVEGAN))
				to_chat(user, span_warning("animal blood is not enough for me"))
		return
	if(src.apply_damage(damage, BRUTE))
		if(istype(user, /mob/living/carbon/human/species/werewolf))
			visible_message(span_danger("The werewolf bites into [src] and thrashes!"))
		else
			visible_message(span_danger("[user] bites [src]! What is wrong with them?"))

/mob/living/simple_animal/onkick(mob/M)
	var/mob/living/simple_animal/target = src
	var/mob/living/carbon/human/user = M
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm [target]!"))
		return FALSE
	if(user.IsKnockdown())
		return FALSE
	if(user == target)
		return FALSE
	if(user.check_leg_grabbed(1) || user.check_leg_grabbed(2))
		to_chat(user, span_notice("I can't move my leg!"))
		return
	if(user.rogfat >= user.maxrogfat)
		return FALSE
	if(user.loc == target.loc)
		to_chat(user, span_warning("I'm too close to get a good kick in."))
		return FALSE
	else
		user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
		playsound(target, 'sound/combat/hits/kick/kick.ogg', 100, TRUE, -1)

		var/shove_dir = get_dir(user.loc, target.loc)
		var/turf/target_shove_turf = get_step(target.loc, shove_dir)

		target.Move(target_shove_turf, shove_dir)

		target.visible_message(span_danger("[user.name] kicks [target.name]!"),
						span_danger("I'm kicked by [user.name]!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("I kick [target.name]!"))
		log_combat(user, target, "kicked")
		playsound(target, 'sound/combat/hits/kick/kick.ogg', 100, TRUE, -1)
		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		if(target.mind)
			target.mind.attackedme[user.real_name] = world.time
		user.rogfat_add(15)

/mob/living/simple_animal/proc/attack_threshold_check(damage, damagetype = BRUTE, armorcheck = d_type)
	var/temp_damage = damage
	if(!damage_coeff[damagetype])
		temp_damage = 0
	else
		temp_damage *= damage_coeff[damagetype]

	if(temp_damage >= 0 && temp_damage <= force_threshold)
		visible_message(span_warning("[src] looks unharmed!"))
		return FALSE
	else
		apply_damage(damage, damagetype, null, getarmor(null, armorcheck))
		return TRUE

/mob/living/simple_animal/bullet_act(obj/projectile/Proj)
	apply_damage(Proj.damage, Proj.damage_type)
	Proj.on_hit(src)
	return BULLET_ACT_HIT

/mob/living/simple_animal/ex_act(severity, target, epicenter, devastation_range, heavy_impact_range, light_impact_range, flame_range)
	..()
	if(!severity || !epicenter)
		return
	var/ddist = devastation_range || 0
	var/hdist = heavy_impact_range || 0
	var/ldist = light_impact_range || 0
	var/fdist = flame_range || 0
	var/fodist = get_dist(src, epicenter)
	var/brute_loss = 0
	var/burn_loss = 0
	var/dmgmod = round(rand(0.5, 1.5), 0.1)

	if(fdist)
		var/stacks = ((fdist - fodist) * 2)
		fire_act(stacks)

	switch(severity)
		if(EXPLODE_DEVASTATE)
			brute_loss = ((120 * ddist) - (120 * fodist) * dmgmod)
			burn_loss = ((60 * ddist) - (60 * fodist) * dmgmod)
			Unconscious((50 * ddist) - (15 * fodist))
			Knockdown((30 * ddist) - (30 * fodist))

		if(EXPLODE_HEAVY)
			brute_loss = ((40 * hdist) - (40 * fodist) * dmgmod)
			burn_loss = ((20 * hdist) - (20 * fodist) * dmgmod)
			Unconscious((10 * hdist) - (5 * fodist))
			Knockdown((30 * hdist) - (30 * fodist))

		if(EXPLODE_LIGHT)
			brute_loss = ((10 * ldist) - (10 * fodist) * dmgmod)

	take_overall_damage(brute_loss,burn_loss)

/mob/living/simple_animal/do_attack_animation(atom/A, visual_effect_icon, used_item, no_effect)
	if(!no_effect && !visual_effect_icon && melee_damage_upper)
		if(melee_damage_upper < 10)
			visual_effect_icon = ATTACK_EFFECT_PUNCH
		else
			visual_effect_icon = ATTACK_EFFECT_SMASH
	..()
