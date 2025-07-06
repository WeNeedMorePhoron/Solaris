// Vampire list for all learnable traits.

//the is the perk list header. After this we add in perks by defining them as spells with the information we need. This isn't elegant, but it works. 
/obj/effect/proc_holder/spell/self/vampire_perklist
	name = "--Perks--"
	cost = null
	desc = "Choose a perk, often with dangerous weaknesses"
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description
	spell_tier = 0 // What vampire level are we?

/obj/effect/proc_holder/spell/self/vampire_efficientdrinker
	name = "Efficient Drinker"
	cost = 3
	spell_tier = 2 // What vampire level are we?
	desc = "You're able to drink more vitae from others"
	goodtrait = TRAIT_EFFICIENT_DRINKER //is there a good trait we want to associate? the code name
	badtrait = TRAIT_HIGH_METABOLISM //is there a bad trait we want to associate? the code name
	badtraitname = "High metabolism" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You will need to drink more blood, especially when your veil is down" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_lowmetabolism
	name = "Low Metabolism"
	cost = 1
	spell_tier = 2 // What vampire level are we?
	desc = "you use Vitae at a slower rate"
	goodtrait = TRAIT_LOW_METABOLISM //is there a good trait we want to associate? the code name
	badtrait = TRAIT_HYDROPHOBIA //is there a bad trait we want to associate? the code name
	badtraitname = "Water weakness" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You will be cursed in clean water or salt water." //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_nopain
	name = "No Pain"
	cost = 3
	spell_tier = 3 // What vampire level are we?
	desc = "You no longer feel pain"
	goodtrait = TRAIT_NOPAIN //is there a good trait we want to associate? the code name
	badtrait = TRAIT_CRITICAL_WEAKNESS //is there a bad trait we want to associate? the code name
	badtraitname = "Critical Weakness" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You are more susceptible to critical hits" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_passiveregeneration
	name = "Passive Regeneration"
	cost = 3
	spell_tier = 3 // What vampire level are we?
	desc = "You will be able to passively regenerate"
	goodtrait = TRAIT_BLOOD_REGEN //is there a good trait we want to associate? the code name
	badtrait = TRAIT_WEAK_VEIL //is there a bad trait we want to associate? the code name
	badtraitname = "Weak Veil & Healing Abilities Limit" //is there a bad trait we want to associate? the player name
	badtraitdesc = "Your veil is weak and you will weaker with it up You also can only have one ability that gives a heal. Affects regeneration, passive regeneration, batform, and mistform" //is there a bad trait we want to associate? the player description" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_resistholy
	name = "Resist Holy"
	cost = 3
	spell_tier = 4 // What vampire level are we?
	desc = "You will not be affected by divine spells or holy ground"
	goodtrait = TRAIT_HOLY_RESIST //is there a good trait we want to associate? the code name
	badtrait = TRAIT_SUN_WEAKNESS //is there a bad trait we want to associate? the code name
	badtraitname = "Sun Weakness" //is there a bad trait we want to associate? the player name
	badtraitdesc = "The sun burns you as well as weakens you without your veil" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_resistsilver
	name = "Resist Silver"
	cost = 3
	spell_tier = 4 // What vampire level are we?
	desc = "You will no longer be weakened by silver"
	goodtrait = TRAIT_SILVER_RESIST //is there a good trait we want to associate? the code name
	badtrait = TRAIT_HOLY_WEAKNESS //is there a bad trait we want to associate? the code name
	badtraitname = "Holy Weakness" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You will feel weaker in church and certain holy spells may affect you more." //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_resistsun
	name = "Resist Sun"
	cost = 3
	spell_tier = 4 // What vampire level are we?
	desc = "You can walk in the sun with your veil down"
	goodtrait = TRAIT_SUN_RESIST //is there a good trait we want to associate? the code name
	badtrait = TRAIT_NO_VEIL //is there a bad trait we want to associate? the code name
	badtraitname = "No Veil" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You can no longer raise your veil, my curse is visible to all" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_secondlife
	name = "Second Life"
	cost = 3
	spell_tier = 2 // What vampire level are we?
	desc = "Upon death you will fully heal and receive some Vitae"
	goodtrait = TRAIT_SECONDLIFE //is there a good trait we want to associate? the code name
	badtrait = TRAIT_SILVER_WEAKNESS //is there a bad trait we want to associate? the code name
	badtraitname = "Silver Weakness" //is there a bad trait we want to associate? the player name
	badtraitdesc = "Silver is my bane, I suffer more when attacked by it" //is there a bad trait we want to associate? the player description
/obj/effect/proc_holder/spell/self/vampire_silentbite
	name = "Silent Bite"
	cost = 3
	spell_tier = 2 // What vampire level are we?
	desc = "While sneaking, you can bite an unarmored part of someone's body every 30 seconds"
	goodtrait = TRAIT_SILENTBITE //is there a good trait we want to associate? the code name
	badtrait = TRAIT_NOVEGAN //is there a bad trait we want to associate? the code name
	badtraitname = "Canibal Vampire" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You can only feed on humanoid beings, animals and potions will not restore Vitae" //is there a bad trait we want to associate? the player description

/* copy paste the template and add new perks. make sure to give appropriate bad traits to balance things. Keep in mind this only populates the list, you need to add in your trait in the trait.dm under defines
/obj/effect/proc_holder/spell/self/vampire_
	name = ""
	cost = 3
	spell_tier = 1 // What vampire level are we?
	desc = ""
	goodtrait = "" //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description
*/




GLOBAL_LIST_INIT(learnable_vamp_perks, (list(/obj/effect/proc_holder/spell/self/vampire_perklist,
		/obj/effect/proc_holder/spell/self/vampire_efficientdrinker,
		/obj/effect/proc_holder/spell/self/vampire_lowmetabolism,
		/obj/effect/proc_holder/spell/self/vampire_nopain,
		/obj/effect/proc_holder/spell/self/vampire_passiveregeneration,
		/obj/effect/proc_holder/spell/self/vampire_resistholy,
		/obj/effect/proc_holder/spell/self/vampire_resistsilver,
		/obj/effect/proc_holder/spell/self/vampire_resistsun,
		/obj/effect/proc_holder/spell/self/vampire_secondlife,)
))

GLOBAL_LIST_INIT(learnable_fledgling_perks, (list(/obj/effect/proc_holder/spell/self/vampire_perklist,
		/obj/effect/proc_holder/spell/self/vampire_efficientdrinker,
		/obj/effect/proc_holder/spell/self/vampire_lowmetabolism,
		/obj/effect/proc_holder/spell/self/vampire_resistholy,
		/obj/effect/proc_holder/spell/self/vampire_resistsilver,
		/obj/effect/proc_holder/spell/self/vampire_resistsun,
		/obj/effect/proc_holder/spell/self/vampire_secondlife, 
		)
))
/*
			/obj/effect/proc_holder/spell/self/vampire_silentbite, //keeping this off solaris, and it does need some rework, its meant more for PVP servers.
*/
