/datum/virtue/sucker/lesser_bloodsucker
	name = "Lesser Bloodsucker"
	desc = "Whether by bite or headritary, I find myself seeking out blood to sustain me and the sun bothers me. The royalty may or may not know of my existance and the church probably hates me, I may need to hide my true nature."
	custom_text = "Obtain Lesser blood sucker and lower level powers, unable to turn others. If choosen as a blood sucker for that week, obtain 1 extra level in vamprism, blood magic, and +1 extra point. You may be considered a threat, depending on the RP that week"

/datum/virtue/sucker/lesser_bloodsucker/apply_to_human(mob/living/carbon/human/recipient)
	if (HAS_TRAIT(recipient,TRAIT_VAMPIRISM)) //if they are a vampire this week, we reward them with some perk points, giving 3 extra
		recipient.mind?.adjust_vamppoints(5)
		//maybe we should give them a level?, giving 2 points above for the adjustment
		recipient.mind?.adjust_skillrank(/datum/skill/magic/vampirism, 1, TRUE)
		recipient.mind?.adjust_skillrank(/datum/skill/magic/blood, 1, TRUE)
	else
		var/datum/antagonist/bloodsucker/lesser/new_antag = new /datum/antagonist/bloodsucker/lesser()
		new_antag.sired = TRUE
		recipient.bs_spawn = 0
		recipient.mind?.add_antag_datum(new_antag)
