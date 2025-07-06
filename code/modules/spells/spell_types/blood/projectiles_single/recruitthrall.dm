/obj/effect/proc_holder/spell/invoked/recruitthrall
	name = "Recruit Thrall"
	desc = "recruit a thrall to become a fledgling"
	antimagic_allowed = TRUE
	//charge_max = 150
	//max_targets = 1
	cost = 4 //how many points it takes
	releasedrain = 0
	chargedrain = 1
	chargetime = 1 SECONDS
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 4 // What vampire level are we?
	invocation = ""
	invocation_type = "whisper"
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 50
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description

/obj/effect/proc_holder/spell/invoked/recruitthrall/cast(list/targets,mob/user = usr)
	..()
	var/inputty = input(user, "Make a dark offer", "VAMPIRE") as text|null
	if(inputty)
		to_chat(targets[1], span_userdanger(inputty))
		vamp_ask(targets[1],user,inputty)
		

/obj/effect/proc_holder/spell/invoked/recruitthrall/proc/vamp_ask(mob/living/carbon/human/guy,mob/living/carbon/human/caster,offer)
	if(!guy || !offer)
		return
	if(!ishuman(guy))
		return
	if(HAS_TRAIT(guy,TRAIT_VAMPIRISM))
		to_chat(src,span_danger("I am already a vampire"))
		to_chat(guy,span_danger("They are already a vampire"))
	if(HAS_TRAIT(guy,TRAIT_BLOOD_THRALL))
		to_chat(src,span_danger("I am already a Thrall"))
		to_chat(guy,span_danger("They are already a Thrall"))
	if(guy.mind)
		if(guy.mind.special_role)
			return
	var/shittime = world.time
	caster.playsound_local(caster, 'sound/misc/rebel.ogg', 100, FALSE)
	var/garbaggio = alert(guy, "[offer]","Become a Thrall?", "Yes", "No")
	if(world.time > shittime + 35 SECONDS)
		to_chat(caster,span_danger("Too late."))
		return
	guy.mob_timers["thralloffer"] = world.time
	if(garbaggio == "Yes")
		if(caster.bs_thrall >= 1)
			to_chat(guy,span_danger("They have too many Thralls"))
			to_chat(caster,span_danger("I have too many Thralls"))
		else
			to_chat(caster,span_blue("[guy] makes a dark choice."))
			ADD_TRAIT(guy, TRAIT_BLOOD_THRALL, GENERIC)

			//we need to add the thrall trait "TRAIT_BLOOD_THRALL" here, also give a tag to the caster for getting a thrall and to the victim for being turned in this round
			caster.bs_thrall += 1
			guy.bs_spawn = 1
			//we remove the spell here for normal blood suckers and greater ones get more
			if (HAS_TRAIT(caster,TRAIT_VAMP_ANCIENT) && caster.bs_thrall < 4)
				//we don't do anything if they are an ancient vampire and under 3 thralls
			else
				//giving the caster an intelligence point and taking one from their last thrall as a reward and consequence for the choice
				guy.change_stat("intelligence", -1)
				caster.change_stat("intelligence", 1)
				caster.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/recruitthrall)
	else
		to_chat(guy,span_danger("I reject the offer."))
		to_chat(caster,span_danger("[guy] rejects the offer."))
