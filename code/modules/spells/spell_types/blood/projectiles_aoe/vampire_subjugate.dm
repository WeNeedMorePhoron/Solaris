/obj/effect/proc_holder/spell/invoked/vampire_subjugate
	name = "Subjugate"
	cost = 2 //how many points it takes
	overlay_state = "transfixmaster"
	releasedrain = 1000
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	school = "blood"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	charging_slowdown = 2
	antimagic_allowed = TRUE
	//include_user = 0
	//max_targets = 0
	spell_tier = 5 // What vampire level are we?
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	charging_slowdown = 3
	vitaedrain = 0
	xp_gain = TRUE
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description

/obj/effect/proc_holder/spell/invoked/vampire_subjugate/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough!"))
		return FALSE
	user.say(msg)
	user.visible_message("<font color='red'>[user]'s eyes glow a ghastly red as they project their will outwards!</font>")
	for(var/mob/living/carbon/human/L in targets)
		//var/datum/antagonist/bloodsucker/BS = L.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(HAS_TRAIT(L,TRAIT_VAMPIRISM))
			return
		L.drowsyness = min(L.drowsyness + 50, 150)
		switch(L.drowsyness)
			if(0 to 50)
				to_chat(L, "You feel like a curtain is coming over your mind.")
				L.Slowdown(20)
			if(50 to 100)
				to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
				L.Slowdown(50)
				L.eyesclosed = TRUE
				for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
					eyet.update_icon(L)
				L.become_blind("eyelids")
			if(100 to INFINITY)
				to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
				L.eyesclosed = TRUE
				for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
					eyet.update_icon(L)
				L.become_blind("eyelids")
				L.Slowdown(50)
				sleep(50)
				L.Sleeping(300)
