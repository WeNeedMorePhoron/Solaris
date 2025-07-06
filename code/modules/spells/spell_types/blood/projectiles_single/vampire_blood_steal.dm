/obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_steal
	name = "Blood Steal"
	desc = "Steal blood from your victim forcibly"
	cost = 4 //how many points it takes
	clothes_req = FALSE
	overlay_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/vampire_blood_steal
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 4 // What vampire level are we?
	invocation = "Sanguis Furtum!"
	invocation_type = "shout"
	charging_slowdown = 3
	recharge_time = 20 SECONDS
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 0
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description


/obj/projectile/magic/vampire_blood_steal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_outer_range = 7

/obj/projectile/magic/vampire_blood_steal/on_hit(target)
	. = ..() 
	if(ismob(target))
		var/mob/BSVictim = target
		var/mob/living/carbon/human/BSDrinker = src.firer
		if(BSVictim.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [BSVictim]!"))
			playsound(get_turf(BSVictim), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(BSVictim))
			var/mob/living/carbon/human/HT = BSVictim
			HT.blood_volume = max(HT.blood_volume-45, 0)
			HT.handle_blood()
			HT.visible_message(span_danger("[BSVictim] has their blood ripped from their body!!"), \
					span_userdanger("My blood erupts from my body!"), \
					span_hear("..."), COMBAT_MESSAGE_RANGE, BSVictim)
			new /obj/effect/decal/cleanable/blood/puddle(HT.loc)
			BSDrinker.vitae += 400
	qdel(src)
