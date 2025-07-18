#define MIN_STEW_TEMPERATURE 374 // For cooking
#define VOLUME_PER_STEW_COOK 32 // Volume to cook per ingredient
#define VOLUME_PER_STEW_COOK_AFTER 1 // Volume to deduct after the sleep is over
#define DEEP_FRY_TIME 5 SECONDS // Default deep fry time
#define OIL_CONSUMED 5 // Amount of oil consumed per deep fry (1 fat = 4 fry)


/obj/machinery/light/rogue/firebowl
	name = "brazier"
	icon = 'icons/roguetown/misc/lighting.dmi'
	icon_state = "stonefire1"
	bulb_colour = "#ffa35c"
	brightness = 12
	density = TRUE
//	pixel_y = 10
	base_state = "stonefire"
	climbable = TRUE
	pass_flags = LETPASSTHROW
	cookonme = TRUE
	dir = SOUTH
	crossfire = TRUE
	fueluse = 0

/obj/machinery/light/rogue/firebowl/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	return !density

/obj/machinery/light/rogue/firebowl/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
			H.visible_message("<span class='info'>[H] warms \his hand over the fire.</span>")

			if(do_after(H, 15, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
				to_chat(H, "<span class='warning'>HOT!</span>")
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

	else
		if(icon_state == "[base_state]over")
			user.visible_message("<span class='notice'>[user] starts to pick up [src]...</span>", \
				"<span class='notice'>I start to pick up [src]...</span>")
			if(do_after(user, 30, target = src))
				icon_state = "[base_state]0"
			return

/obj/machinery/light/rogue/firebowl/stump
	icon_state = "stumpfire1"
	base_state = "stumpfire"

/obj/machinery/light/rogue/firebowl/church
	icon_state = "churchfire1"
	base_state = "churchfire"


/obj/machinery/light/rogue/firebowl/standing
	name = "standing fire"
	icon_state = "standing1"
	base_state = "standing"
	bulb_colour = "#ff9648"
	cookonme = FALSE
	crossfire = FALSE


/obj/machinery/light/rogue/firebowl/standing/blue
	icon_state = "standingb1"
	base_state = "standingb"
	bulb_colour = "#7b60f3"

/obj/machinery/light/rogue/firebowl/standing/proc/knock_over() //use this later for jump impacts and shit
	icon_state = "[base_state]over"

/obj/machinery/light/rogue/firebowl/standing/fire_act(added, maxstacks)
	if(icon_state != "[base_state]over")
		..()

/obj/machinery/light/rogue/firebowl/standing/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(icon_state == "[base_state]over")
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")
			return
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks over [src]!</span>", \
				"<span class='warning'>I kick over [src]!</span>")
			burn_out()
			knock_over()
		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")

/obj/machinery/light/rogue/wallfire
	name = "fireplace"
	icon_state = "wallfire1"
	base_state = "wallfire"
	brightness = 10
	bulb_colour = "#ffa35c"
	density = FALSE
	fueluse = 0
	crossfire = FALSE
	cookonme = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/wallfire, 32)

/obj/machinery/light/rogue/wallfire/candle
	name = "candles"
	icon_state = "wallcandle1"
	base_state = "wallcandle"
	crossfire = FALSE
	cookonme = FALSE
	soundloop = null

/obj/machinery/light/rogue/wallfire/candle/OnCrafted(dirin)
	pixel_x = 0
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32
	. = ..()

/obj/machinery/light/rogue/wallfire/candle/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message("<span class='warning'>[user] snuffs [src].</span>")
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/wallfire/candle, 32)

/obj/machinery/light/rogue/wallfire/candle/blue
	bulb_colour = "#7b60f3"
	icon_state = "wallcandleb1"
	base_state = "wallcandleb"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/wallfire/candle/blue, 32)

/obj/machinery/light/rogue/wallfire/candle/tree
	name = "livingwood candles"
	icon_state = "wallcandle_tree1"
	base_state = "wallcandle_tree"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/wallfire/candle/tree, 32)

/obj/machinery/light/rogue/wallfire/candle/weak
	light_power = 0.9
	light_outer_range =  6

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/wallfire/candle/weak, 32)

/obj/machinery/light/rogue/torchholder
	name = "sconce"
	icon_state = "torchwall1"
	base_state = "torchwall"
	density = FALSE
	var/obj/item/flashlight/flare/torch/torchy
	fueluse = FALSE //we use the torch's fuel
	soundloop = null
	crossfire = FALSE
	plane = GAME_PLANE_UPPER
	cookonme = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/light/rogue/torchholder, 0)

/obj/machinery/light/rogue/torchholder/OnCrafted(dirin, user)
	. = ..()
	if(dir == NORTH)
		pixel_y = 32

/obj/machinery/light/rogue/torchholder/directional/north
	pixel_y = 32 /// SOLARIS NOTE: hack workaround for now; I'm not dedicating too much time to this

/obj/machinery/light/rogue/torchholder/fire_act(added, maxstacks)
	if(torchy)
		if(!on)
			if(torchy.fuel > 0)
				torchy.spark_act()
				playsound(src.loc, 'sound/items/firelight.ogg', 100)
				on = TRUE
				update()
				update_icon()
				if(soundloop)
					soundloop.start()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
				return TRUE

/obj/machinery/light/rogue/torchholder/Initialize()
	torchy = new /obj/item/flashlight/flare/torch(src)
	torchy.spark_act()
	torchy.weather_resistant = TRUE
	. = ..()

/obj/machinery/light/rogue/torchholder/OnCrafted(dirin, user)
	QDEL_NULL(torchy)
	on = FALSE
	set_light(0)
	update_icon()
	. = ..(dirin)

/obj/machinery/light/rogue/torchholder/process()
	if(on)
		if(torchy)
			if(torchy.fuel <= 0)
				burn_out()
			if(!torchy.on)
				burn_out()
		else
			return PROCESS_KILL

/obj/machinery/light/rogue/torchholder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(torchy)
		if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(torchy))
			torchy.weather_resistant = FALSE
			torchy.forceMove(loc)
		torchy = null
		on = FALSE
		set_light(0)
		update_icon()
		playsound(src.loc, 'sound/foley/torchfixturetake.ogg', 70)

/obj/machinery/light/rogue/torchholder/update_icon()
	if(torchy)
		if(on)
			icon_state = "[base_state]1"
		else
			icon_state = "[base_state]0"
	else
		icon_state = "torchwall"

/obj/machinery/light/rogue/torchholder/burn_out()
	if(torchy && torchy.on)
		torchy.turn_off()
	..()

/obj/machinery/light/rogue/torchholder/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = W
		if(torchy)
			if(LR.on && !on)
				if(torchy.fuel <= 0)
					to_chat(user, "<span class='warning'>The mounted torch is burned out.</span>")
					return
				else
					torchy.spark_act()
					user.visible_message("<span class='info'>[user] lights [src].</span>")
					playsound(src.loc, 'sound/items/firelight.ogg', 100)
					on = TRUE
					update()
					update_icon()
					addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
					return
			if(!LR.on && on)
				if(LR.fuel > 0)
					LR.spark_act()
					user.visible_message("<span class='info'>[user] lights [LR] in [src].</span>")
					user.update_inv_hands()
		else
			if(LR.on)
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
				torchy.weather_resistant = TRUE
				on = TRUE
				update()
				update_icon()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
			else
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
				torchy.weather_resistant = TRUE
				update_icon()
			playsound(src.loc, 'sound/foley/torchfixtureput.ogg', 70)
		return
	. = ..()

/obj/machinery/light/rogue/chand
	name = "chandelier"
	icon_state = "chand1"
	base_state = "chand"
	icon = 'icons/roguetown/misc/tallwide.dmi'
	density = FALSE
	brightness = 10
	pixel_x = -10
	pixel_y = -10
	layer = 2.0
	fueluse = 0
	soundloop = null
	crossfire = FALSE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/machinery/light/rogue/chand/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message("<span class='warning'>[user] snuffs [src].</span>")
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()


/obj/machinery/light/rogue/hearth
	name = "hearth"
	icon_state = "hearth1"
	base_state = "hearth"
	density = TRUE
	anchored = TRUE
	climbable = TRUE
	climb_time = 3 SECONDS
	layer = TABLE_LAYER
	climb_offset = 14
	on = FALSE
	cookonme = TRUE
	soundloop = /datum/looping_sound/fireloop
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	var/mob/living/carbon/human/lastuser
	var/datum/looping_sound/boilloop/boilloop

/obj/machinery/light/rogue/hearth/Initialize()
	boilloop = new(src, FALSE)
	. = ..()

/obj/machinery/light/rogue/hearth/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	else
		return !density

/obj/machinery/light/rogue/hearth/examine(mob/user)
	. = ..()
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				. += "There's \a [attachment.name] on it with \a [food.name] in it."
			else
				. += "There's \a [attachment.name] on it."
		else if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/isboiling = attachment.reagents.chem_temp > MIN_STEW_TEMPERATURE
			if(isboiling)
				. += "There's \a [attachment.name] on it, it is boiling." // This is common shorthand for the contents don't nitpick
			else
				. += "There's \a [attachment.name] on it. It is not boiling"
		. += span_notice("Right click to start fanning the flame and make it cook faster.")

/obj/machinery/light/rogue/hearth/attack_right(mob/user)
	var/datum/skill/craft/cooking/cs = user?.mind?.get_skill_level(/datum/skill/craft/cooking)
	var/cooktime_divisor = get_cooktime_divisor(cs)
	if(do_after(user, 2 SECONDS / cooktime_divisor, target = src))
		to_chat(user, span_info("I fan the flame on [src].")) // Until line combine is on by default gotta do this to avoid spam
		try_cook(cooktime_divisor)
		attack_right(user)

/obj/machinery/light/rogue/hearth/attackby(obj/item/W, mob/living/user, params)
	lastuser = user // For processing food
	var/datum/skill/craft/cooking/cs = lastuser?.mind?.get_skill_level(/datum/skill/craft/cooking)
	var/cooktime_divisor = get_cooktime_divisor(cs)

	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/bucket/pot))
			playsound(get_turf(user), 'sound/foley/dropsound/shovel_drop.ogg', 40, TRUE, -1)
			attachment = W
			user.doUnEquip(W)
			W.forceMove(src)
			update_icon()
			return
	else
		if(istype(W, /obj/item/reagent_containers/glass/bowl))
			to_chat(user, "<span class='notice'>Remove the pot from the hearth first.</span>")
			return
		if(istype(attachment, /obj/item/cooking/pan))
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(istype(W, /obj/item/reagent_containers/food/snacks/egg)) // added
					if(W.icon_state != "rawegg")
						playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
						sleep(25) // to get egg crack before frying hiss
						W.icon_state = "rawegg" // added
				if(!food)
					S.forceMove(src)
					food = S
					update_icon()
					playsound(src.loc, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 5)
					return
// Stew + Deep Frying code - refactored!!
		else if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/reagent_containers/glass/bucket/pot = attachment
			if(istype(W, /obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(S.fat_yield)
					if(pot.reagents.has_reagent(/datum/reagent/water))
						to_chat(user, span_warning("You can't render fat in a pot with water!"))
						return
					if(do_after(user, 2 SECONDS / cooktime_divisor, target = src))
						user.visible_message(span_info("[user] melts [S] in the pot.</span>"))
						qdel(S)
						pot.reagents.add_reagent(/datum/reagent/consumable/oil/tallow, S.fat_yield)
						return
				if(pot.reagents.has_reagent(/datum/reagent/consumable/oil/tallow) && S.deep_fried_type)
					if(!pot.reagents.has_reagent(/datum/reagent/consumable/oil/tallow, OIL_CONSUMED))
						to_chat(user, span_notice("Not enough tallow."))
						return
					if(pot.reagents.has_reagent(/datum/reagent/water))
						to_chat(user, span_warning("You can't deep fry in a pot with water!"))
						return
					if(do_after(user, DEEP_FRY_TIME / cooktime_divisor, target = src))
						user.visible_message(span_info("[user] deep fries [S] in the pot.</span>"))
						add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
						new S.deep_fried_type(src.loc)
						qdel(S)
						pot.reagents.remove_reagent(/datum/reagent/consumable/oil/tallow, OIL_CONSUMED)
						return
			for(var/datum/stew_recipe/R in GLOB.stew_recipes)
				for(var/I in R.inputs)
					if(istype(W, I))
						if(!pot.reagents.has_reagent(/datum/reagent/water, VOLUME_PER_STEW_COOK + VOLUME_PER_STEW_COOK_AFTER))
							to_chat(user, span_notice("Not enough water."))
							return
						if(pot.reagents.chem_temp < MIN_STEW_TEMPERATURE)
							to_chat(user, span_notice("[pot] isn't boiling!</span>"))
							return
						if(do_after(user, 2 SECONDS / cooktime_divisor, target = src))
							user.visible_message(span_info("[user] places [W] into the pot.</span>"))
							add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
							qdel(W)
							playsound(src.loc, 'sound/items/Fish_out.ogg', 20, TRUE)
							pot.reagents.remove_reagent(/datum/reagent/water, VOLUME_PER_STEW_COOK)
							sleep(R.cooktime / cooktime_divisor)
							playsound(src, "bubbles", 30, TRUE)
							pot.reagents.remove_reagent(/datum/reagent/water, VOLUME_PER_STEW_COOK_AFTER) // Remove water first prevent overfill
							pot.reagents.add_reagent(R.output, VOLUME_PER_STEW_COOK + VOLUME_PER_STEW_COOK_AFTER)
							return
	. = ..()

//////////////////////////////////

/obj/machinery/light/rogue/hearth/update_icon()
	cut_overlays()
	icon_state = "[base_state][on]"
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/I = attachment
			I.pixel_x = 0
			I.pixel_y = 0
			add_overlay(new /mutable_appearance(I))
			if(food)
				I = food
				I.pixel_x = 0
				I.pixel_y = 0
				add_overlay(new /mutable_appearance(I))

/obj/machinery/light/rogue/hearth/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				if(!user.put_in_active_hand(food))
					food.forceMove(user.loc)
				food = null
				update_icon()
			else
				if(!user.put_in_active_hand(attachment))
					attachment.forceMove(user.loc)
				attachment = null
				update_icon()
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			if(!user.put_in_active_hand(attachment))
				attachment.forceMove(user.loc)
			attachment = null
			update_icon()
			boilloop.stop()
	else
		if(on)
			var/mob/living/carbon/human/H = user
			if(istype(H))
				H.visible_message(span_info("[H] warms \his hand over the embers."))
				if(do_after(H, 50, target = src))
					var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
					to_chat(H, span_warning("HOT!"))
					if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
						H.update_damage_overlays()
			return TRUE

/obj/machinery/light/rogue/hearth/process()
	// Edge case is that this depends on the last person to put the pan on the hearth and not the last person to put the food on the pan
	var/datum/skill/craft/cooking/cs = lastuser?.mind?.get_skill_level(/datum/skill/craft/cooking)
	var/cooktime_divisor = get_cooktime_divisor(cs)

	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()
	if(on)
		try_cook(cooktime_divisor)

/obj/machinery/light/rogue/hearth/proc/try_cook(var/cooktime_divisor)
	if(initial(fueluse) > 0)
		if(fueluse > 0)
			fueluse = max(fueluse - 10, 0)
		if(fueluse == 0)
			burn_out()
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				var/obj/item/C = food.cooking(20 * cooktime_divisor, 20, src)
				if(C)
					qdel(food)
					food = C
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			if(attachment.reagents)
				attachment.reagents.expose_temperature(400, 0.033)
				if(attachment.reagents.chem_temp > MIN_STEW_TEMPERATURE)
					boilloop.start()
				else
					boilloop.stop()
	update_icon()


/obj/machinery/light/rogue/hearth/onkick(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_info("[user] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/hearth/Destroy()
	QDEL_NULL(boilloop)
	. = ..()

/obj/machinery/light/rogue/campfire
	name = "campfire"
	icon_state = "badfire1"
	base_state = "badfire"
	density = FALSE
	layer = 2.8
	brightness = 5
	on = FALSE
	fueluse = 15 MINUTES
	bulb_colour = "#da5e21"
	cookonme = TRUE
	max_integrity = 30
	soundloop = /datum/looping_sound/fireloop

/obj/machinery/light/rogue/campfire/process()
	..()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()

/obj/machinery/light/rogue/campfire/onkick(mob/user)
	if(isliving(user) && on)
		var/mob/living/L = user
		L.visible_message("<span class='info'>[L] snuffs [src].</span>")
		burn_out()

/obj/machinery/light/rogue/campfire/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
			H.visible_message("<span class='info'>[H] warms \his hand near the fire.</span>")

			if(do_after(H, 100, target = src))
				H.apply_status_effect(/datum/status_effect/buff/healing, 1)
				H.add_stress(/datum/stressevent/campfire)
				to_chat(H, "<span class='info'>The warmth of the fire comforts me, affording me a short rest.</span>")
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

/obj/machinery/light/rogue/campfire/densefire
	icon_state = "densefire1"
	base_state = "densefire"
	density = TRUE
	layer = 2.8
	brightness = 5
	climbable = TRUE
	on = FALSE
	fueluse = 30 MINUTES
	pass_flags = LETPASSTHROW
	bulb_colour = "#eea96a"
	max_integrity = 60

/obj/machinery/light/rogue/campfire/densefire/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	if(locate(/obj/machinery/light/rogue/firebowl) in get_turf(mover))
		return 1
	return !density


/obj/machinery/light/rogue/campfire/pyre
	name = "pyre"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "pyre1"
	base_state = "pyre"
	brightness = 10
	fueluse = 30 MINUTES
	layer = BELOW_MOB_LAYER
	buckleverb = "crucifie"
	can_buckle = 1
	buckle_lying = 0
	dir = NORTH
	buckle_requires_restraints = 1
	buckle_prevents_pull = 1


/obj/machinery/light/rogue/campfire/pyre/post_buckle_mob(mob/living/M)
	..()
	M.set_mob_offsets("bed_buckle", _x = 0, _y = 10)
	M.setDir(SOUTH)

/obj/machinery/light/rogue/campfire/pyre/post_unbuckle_mob(mob/living/M)
	..()
	M.reset_offsets("bed_buckle")

/obj/machinery/light/rogue/campfire/longlived
	fueluse = 180 MINUTES

#undef MIN_STEW_TEMPERATURE
#undef VOLUME_PER_STEW_COOK
#undef VOLUME_PER_STEW_COOK_AFTER
