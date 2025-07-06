// Vampire list for all learnable spells.

//this is the header for the spell list
/obj/effect/proc_holder/spell/self/vampire_spellslist
	name = "--Spells--"
	cost = ""
	spell_tier = 0 // What vampire level are we?
	desc = "Choose a spell, sometimes with weaknesses."
	goodtrait = "" //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description

//spells should be defined into their own DMs, DO NOT DEFINE THEM HERE!!

GLOBAL_LIST_INIT(learnable_vamp_spells, (list(/obj/effect/proc_holder/spell/self/vampire_spellslist,
		/obj/effect/proc_holder/spell/invoked/vampire_fortitude,
		/obj/effect/proc_holder/spell/invoked/vampire_strength,
		/obj/effect/proc_holder/spell/invoked/vampire_celerity,
		/obj/effect/proc_holder/spell/invoked/vampire_darkvision,
		/obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_lightning,
		/obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_steal,
		/obj/effect/proc_holder/spell/invoked/recruitthrall,
		/obj/effect/proc_holder/spell/targeted/shapeshift/vampire_bat,
		/obj/effect/proc_holder/spell/invoked/vampire_float,
		/obj/effect/proc_holder/spell/invoked/vampire_regenerate,	
)
))
GLOBAL_LIST_INIT(learnable_fledgling_spells, (list(/obj/effect/proc_holder/spell/self/vampire_spellslist,
		/obj/effect/proc_holder/spell/invoked/vampire_fortitude,
		/obj/effect/proc_holder/spell/invoked/vampire_strength,
		/obj/effect/proc_holder/spell/invoked/vampire_celerity,
		/obj/effect/proc_holder/spell/invoked/vampire_darkvision,
		/obj/effect/proc_holder/spell/targeted/shapeshift/vampire_bat,
		/obj/effect/proc_holder/spell/invoked/vampire_float,
		/obj/effect/proc_holder/spell/invoked/vampire_regenerate,
)
))
/* Leaving these out for Solaris Ridge, they might be too PVP heavy. leaving the spells in the game so people can add them back in later or by admin request
				/obj/effect/proc_holder/spell/targeted/shapeshift/vampire_mistform,
				/obj/effect/proc_holder/spell/invoked/vampire_subjugate,
				
				/obj/effect/proc_holder/spell/invoked/vampire_blood_vision,


*/
