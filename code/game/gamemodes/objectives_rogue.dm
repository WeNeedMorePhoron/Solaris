/datum/objective/delf
	name = "delf"
	explanation_text = "Feed honeys to the mother."

/datum/objective/delf/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.delfcontrib >= C.delfgoal)
			return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.delfgoal] honeys to the mother."
		else
			explanation_text = "The statuette no longer hungers. You are free, for the time being..."

/datum/objective/werewolf
	name = "conquer"
	explanation_text = "Fear not the moon and Zira's light."
	team_explanation_text = "Lycanthropy is a terrible disease that's been recorded in scattered accounts going back hundreds of years. Nightly transformations and prodigious increses in mass drive the body into an active state of insatiable starvation, driving animalistic, rabid behavior."
	triumph_count = 5

/datum/objective/werewolf/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "werewolf")
			return TRUE

/datum/objective/vampire
	name = "conquer"
	explanation_text = "Put an end to the werewolf menace in Sunmarch, or unite with them against the forces of the Nine."
	team_explanation_text = "The feud between werewolves and vampires reaches back to the dawn of time. Will the two factions destroy each other, or find a way to coexist and face the mortals of Sunmarch together?"
	triumph_count = 5

/datum/objective/vampire/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE

//if we choose to bring back vampires verse werewolves
/datum/objective/bloodsucker
	name = "survive"
	explanation_text = "I may live forever, but only if I survive this era"
	team_explanation_text = "Will vampires return to prominance this era by learning to live along side mortals in Sunmarch? Or will there be another schism that leads to war?"
	triumph_count = 5

/*
/datum/objective/bloodsucker/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.bloodsucker_werewolf() == "bloodsucker")
			return TRUE
*/
