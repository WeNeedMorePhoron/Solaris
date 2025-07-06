/obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_lightning
	name = "Blood Bolt"
	desc = "Shoot a bolt of lightning tainted with your blood"
	cost = 3 //how many points it takes
	clothes_req = FALSE
	overlay_state = "bloodlightning"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodlightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 4 // What vampire level are we?
	invocation = "Sanguis Sagitta!"
	invocation_type = "shout"
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description
	recharge_time = 20 SECONDS
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 100

/obj/projectile/magic/vampire_blood_lightning
	name = "blood bolt"
	tracer_type = /obj/effect/projectile/tracer/blood
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 35
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#802121"
	light_outer_range = 7

/obj/projectile/magic/vampire_blood_lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(3, src)
		
	qdel(src)
