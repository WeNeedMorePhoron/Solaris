///obj/effect/proc_holder/spell/self/vampire_strength
/obj/effect/proc_holder/spell/invoked/vampire_strength
	name = "Blood Strength"
	desc = "Increases my strength through my blood"
	cost = 2 //how many points it takes
	xp_gain = TRUE
	releasedrain = 1 //no stamina since we use vitae
	chargedrain = 1 
	chargetime = 2 
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 1 // What vampire level are we?
	invocation = "Sanguine Robur"
	invocation_type = "whisper"
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	charging_slowdown = 3
	vitaedrain = 50
	xp_gain = TRUE
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description


/obj/effect/proc_holder/spell/invoked/vampire_strength/cast(list/targets, mob/living/user)
	if(isliving(user))
		var/mob/living/carbon/human/BSDrinker = user
		if(!user)
			return
		if(!HAS_TRAIT(BSDrinker,TRAIT_VAMPIRISM))
			to_chat(BSDrinker, span_warning("I'm not a vampire, what am I doing?"))
			return
		if(BSDrinker.has_status_effect(/datum/status_effect/debuff/veil_up))
			to_chat(BSDrinker, span_warning("My curse is hidden."))
			return
		if(BSDrinker.vitae < vitaedrain)
			to_chat(BSDrinker, span_warning("Not enough vitae."))
			return
		if(BSDrinker.has_status_effect(/datum/status_effect/buff/vampire_strength))
			to_chat(BSDrinker, span_warning("Already active."))
			return
		BSDrinker.vitae -= vitaedrain
		BSDrinker.apply_status_effect(/datum/status_effect/buff/vampire_strength)
		to_chat(BSDrinker, span_greentext("! NIGHT MUSCLES !"))
		BSDrinker.playsound_local(get_turf(BSDrinker), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)

#define VAMPIRIC_FILTER "vampiric_glow"

/datum/status_effect/buff/vampire_strength/on_apply()
	. = ..()
	var/filter = owner.get_filter(VAMPIRIC_FILTER)
	if (!filter)
		owner.add_filter(VAMPIRIC_FILTER, 2, list("type" = "outline", "color" = "#8B0000", "alpha" = 100, "size" = 1))

/datum/status_effect/buff/vampire_strength/on_remove()
	. = ..()
	to_chat(owner, span_warning("My muscles relax again"))
	owner.remove_filter(VAMPIRIC_FILTER)

#undef VAMPIRIC_FILTER

