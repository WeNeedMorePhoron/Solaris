/obj/effect/proc_holder/spell/targeted/vampire_transfix
	name = "Vampire Transfix"
	overlay_state = "transfix"
	releasedrain = 100
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	charging_slowdown = 3
	vitaedrain = 100
	xp_gain = TRUE
	antimagic_allowed = TRUE
	//include_user = 0
	spell_tier = 7
	//max_targets = 1
	spell_tier = 1 // What vampire level are we?
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description


/obj/effect/proc_holder/spell/targeted/vampire_transfix/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough! I must say more"))
		return FALSE
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d8")
	user.say(msg)
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/bloodsucker/BS = L.mind?.has_antag_datum(/datum/antagonist/bloodsucker)
		if(HAS_TRAIT(L,TRAIT_VAMPIRISM))
			return
		var/willpower = round(L.STAINT / 4)
		var/willroll = roll("[willpower]d6")
		if(BS)
			return
		if(L.cmode)
			willroll += 10
		var/found_psycross = FALSE
		for(var/obj/item/clothing/neck/roguetown/psicross/silver/I in L.contents) //Subpath fix.
			found_psycross = TRUE
			break

		if(bloodroll >= willroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				L.drowsyness = min(L.drowsyness + 50, 150)
				switch(L.drowsyness)
					if(0 to 50)
						to_chat(L, "You feel like a curtain is coming over your mind.")
						to_chat(user, "Their mind gives way slightly.")
						L.Slowdown(20)
					if(50 to 100)
						to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						to_chat(user, "They will not be able to resist much more.")
					if(100 to INFINITY)
						to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
						to_chat(user, "They're mine now.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						sleep(50)
						L.Sleeping(600)

		if(willroll >= bloodroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				to_chat(user, "I fail to ensnare their mind.")
			if(willroll - bloodroll >= 3)
				if(found_psycross == TRUE)
					to_chat(L, "<font color='white'> The silver psycross shines and protect me from the blood magic, the one who used blood magic was [user]!</font>")
				else
					to_chat(user, "I fail to ensnare their mind.")
					to_chat(L, "I feel like someone or something unholy is messing with my head. I should get out of here!")
					var/holyskill = L.mind.get_skill_level(/datum/skill/magic/holy)
					var/arcaneskill = L.mind.get_skill_level(/datum/skill/magic/arcane)
					if(holyskill + arcaneskill >= 1)
						to_chat(L, "I feel like the unholy magic came from [user].")
			


