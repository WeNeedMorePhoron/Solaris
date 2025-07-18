GLOBAL_LIST_EMPTY(redstone_objs)


/obj/structure
	var/redstone_structure = FALSE //If you want the structure to interact with player built redstone
	var/redstone_id
	var/list/redstone_attached = list()

/obj/structure/LateInitialize()
	. = ..()
	if(redstone_id)
		for(var/obj/structure/S in GLOB.redstone_objs)
			if(S.redstone_id == redstone_id)
				redstone_attached |= S
				S.redstone_attached |= src

/obj/structure/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(!redstone_structure)
		return
	if(!istype(I, /obj/item/contraption/linker))
		return
	var/obj/item/contraption/linker/multitool = I
	if(!multitool.current_charge)
		return
	if(user.mind?.get_skill_level(/datum/skill/craft/engineering) < 3)
		to_chat(user, span_warning("I have no idea how to use [multitool]!"))
		return
	user.visible_message("[user] starts tinkering with [src].", "You start tinkering with [src].")
	if(!do_after(user, 3 SECONDS, src))
		return
	//var/turf/front = get_turf(src)
	if(isstructure(multitool.buffer))
		var/obj/structure/buffer_structure = multitool.buffer
		if(src == buffer_structure)
			to_chat(user, "You uncalibrate [src] from all its connections.")
			for(var/obj/structure/O in redstone_attached)
				O.redstone_attached -= src
				redstone_attached -= O
			GLOB.redstone_objs -= src
			return
		buffer_structure.redstone_attached |= src
		redstone_attached |= buffer_structure
		GLOB.redstone_objs |= src
		GLOB.redstone_objs |= buffer_structure
		to_chat(user, "You calibrate [src] to the output of [buffer_structure].")
	else
		to_chat(user, "You store the internal schematics of [src] on [multitool].")
		multitool.set_buffer(src)
	multitool.charge_deduction(src, user, 1)

/obj/structure/vv_edit_var(var_name, var_value)
	switch (var_name)
		if ("redstone_id")
			update_redstone_id(var_value)
			datum_flags |= DF_VAR_EDITED
			return TRUE

	return ..()

/obj/structure/proc/update_redstone_id(new_id)
	if(new_id)
		GLOB.redstone_objs |= src
		redstone_attached = list()
		redstone_id = new_id
		for(var/obj/structure/S in GLOB.redstone_objs)
			if(S == src)
				continue
			if(S.redstone_id == redstone_id)
				redstone_attached |= S
				S.redstone_attached |= src


/obj/structure/proc/redstone_triggered(mob/user)
	return

/obj/structure/lever
	name = "lever"
	desc = "I want to pull it."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "leverfloor0"
	density = FALSE
	anchored = TRUE
	max_integrity = 3000
	var/toggled = FALSE
	redstone_structure = TRUE

/obj/structure/lever/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		var/used_time = 100 - (L.STASTR * 10)
		user.visible_message(span_warning("[user] pulls the lever."))
		log_game("[key_name(user)] pulled the lever with redstone id \"[redstone_id]\"")
		if(do_after(user, used_time, target = user))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		user.visible_message("<span class='warning'>[user] kicks the lever!</span>")
		playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
		if(prob(L.STASTR * 4))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/wall
	icon_state = "leverwall0"

/obj/structure/lever/hidden
	icon = null

/obj/structure/lever/hidden/proc/feel_button(mob/living/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		user.visible_message("<span class='warning'>[user] presses a hidden button.</span>")
		user.log_message("pulled the lever with redstone id \"[redstone_id]\"", LOG_GAME)
		for(var/obj/structure/O in redstone_attached)
			spawn(0) O.redstone_triggered(user)
		toggled = !toggled
		playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/hidden/onkick(mob/user) // nice try
	return FALSE

/obj/structure/lever/wall/attack_hand(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/lever/wall/onkick(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/pressure_plate //vanderlin port
	name = "pressure plate"
	desc = "Be careful. Stepping on this could either mean a bomb exploding or a door closing on you."
	icon = 'icons/roguetown/misc/traps.dmi'
	icon_state = "pressureplate"
	max_integrity = 45 // so it gets destroyed when used to explode a bomb
	density = FALSE
	anchored = TRUE
	redstone_structure = TRUE

/obj/structure/pressure_plate/Crossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		var/mob/living/L = AM
		to_chat(L, "<span class='info'>I feel something click beneath me.</span>")
		AM.log_message("has activated a pressure plate", LOG_GAME)
		playsound(src, 'sound/misc/pressurepad_down.ogg', 65, extrarange = 2)

/obj/structure/pressure_plate/Uncrossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		triggerplate()

/obj/structure/pressure_plate/proc/triggerplate()
	playsound(src, 'sound/misc/pressurepad_up.ogg', 65, extrarange = 2)
	for(var/obj/structure/O in redstone_attached)
		spawn(0) O.redstone_triggered()
/*
/obj/structure/pressure_plate/attack_hand(mob/user) //commented out for now, they're stuposed to be anchored structures for dungeons. End of vanderlin traps port. Maybe an artificer subtype craft in the future.
	. = ..()
	if(user.used_intent.type == INTENT_HARM)
		playsound(loc, 'sound/combat/hits/punch/punch (1).ogg', 100, FALSE, -1)
		triggerplate()
		anchored = !anchored
*/

/obj/structure/activator
	name = "activator"
	desc = "A strange structure with an opening for an item on the top with an arrow etched into it pointing to where it is possibly aiming."
	icon = 'icons/roguetown/misc/engineering_structure.dmi'
	icon_state = "activator"
	max_integrity = 45 // so it gets destroyed when used to explode a bomb
	//w_class = WEIGHT_CLASS_HUGE // mechanical stuff is usually pretty heavy.
	density = TRUE
	anchored = TRUE
	redstone_structure = TRUE
	var/obj/item/containment
	var/obj/item/quiver/ammo // used if the contained item is a bow or crossbow
	var/datum/intent/used_intent = null //fooling it to think we're a person
	var/mind = null //fooling it to think we're a person
	var/firedirection = NORTH //fire direction, we'll start north

/obj/structure/activator/Initialize()
	. = ..()
	update_icon()

/obj/structure/activator/ComponentInitialize()
	. = ..()
	//AddComponent(/datum/component/simple_rotation, ROTATION_REQUIRE_WRENCH|ROTATION_IGNORE_ANCHORED) //from vanderline, we don't have these flags here
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src, PROC_REF(can_user_rotate)),CALLBACK(src, PROC_REF(can_be_rotated)),null)

/obj/structure/activator/proc/changeNext_move()
	return

/obj/structure/activator/proc/can_user_rotate(mob/user)
	var/mob/living/L = user
	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
		else
			return TRUE
	else if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/structure/activator/proc/can_be_rotated(mob/user)
	return TRUE

/obj/structure/activator/update_icon()
	. = ..()
	cut_overlays()
	if(!containment)
		add_overlay("activator-e")

/obj/structure/activator/attack_hand(mob/user)
	. = ..()
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	sleep(7)
	if(containment)
		playsound(src, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		containment.forceMove(get_turf(src))
		containment = null
	if(ammo)
		playsound(src, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		ammo.forceMove(get_turf(src))
		ammo = null
	update_icon()
	return TRUE

/obj/structure/activator/attack_right(mob/user)
	if (user.rmb_intent)
		sleep(1)
		switch(firedirection)
			if(WEST)
				say("Mode: NORTH")
				playsound(loc, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				firedirection = NORTH
			if(NORTH)
				say("Mode: EAST")
				playsound(loc, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				firedirection = EAST
			if(EAST)
				say("Mode: SOUTH")
				playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
				firedirection = SOUTH
			if(SOUTH)
				say("Mode: WEST")
				playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
				firedirection = WEST
		return

/obj/structure/activator/attackby(obj/item/I, mob/user, params)
	if(!containment && (istype(I, /obj/item/gun/ballistic/revolver/grenadelauncher) || istype(I, /obj/item/bomb) || istype(I, /obj/item/flint)))
		if(!user.transferItemToLoc(I, src))
			return ..()
		containment = I
		playsound(src, 'sound/misc/chestclose.ogg', 25)
		update_icon()
		return TRUE
	if(!ammo && istype(I, /obj/item/quiver))
		if(!user.transferItemToLoc(I, src))
			return
		playsound(src, 'sound/misc/chestclose.ogg', 25)
		ammo = I
		return TRUE
	return ..()

/obj/structure/activator/redstone_triggered(mob/user)
	if(!containment)
		return
	if(istype(containment, /obj/item/bomb))
		var/obj/item/bomb/bomba = containment
		bomba.light()
	if(istype(containment, /obj/item/flint))
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_step(src, firedirection)
		S.set_up(1, 1, front)
		S.start()
	if(istype(containment, /obj/item/gun/ballistic/revolver/grenadelauncher))
		if(!ammo)
			return
		if(ammo.arrows.len)
			var/obj/item/gun/ballistic/revolver/grenadelauncher/B = containment
			var/obj/item/ammo_box/gun_magazine = B.mag_type
			var/obj/item/ammo_casing/caseless/gun_ammo = initial(gun_magazine?.ammo_type)
			//var/mob/living/liveactivator = src //tricking the shooting system to think this is a person
			for(var/obj/item/ammo_casing/BT in ammo.arrows)
				if(istype(BT, gun_ammo))
					ammo.arrows -= BT
					BT.fire_casing(get_step(src, firedirection), src, null, null, null, BODY_ZONE_CHEST, 0,  src)
					ammo.contents -= BT
					ammo.update_icon()
					break


/obj/structure/floordoor
	name = "floorhatch"
	desc = "A handy floor hatch for people who need privacy upstairs."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "floorhatch1"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_OPEN_TURF_LAYER
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	var/togg = FALSE
	var/base_state = "floorhatch"
	max_integrity = 0
	redstone_structure = TRUE
/*
/obj/structure/floordoor/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 100)
	return ..()
*/
/obj/structure/floordoor/obj_break(damage_flag)
	obj_flags = null
	..()

/obj/structure/floordoor/redstone_triggered(mob/user)
	if(obj_broken)
		return
	togg = !togg
	if(togg)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
	else
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/structure/floordoor/open
		icon_state = "floorhatch0"
		base_state = "floorhatch"
		togg = TRUE
		obj_flags = null

/obj/structure/floordoor/gatehatch
	name = ""
	desc = ""
	base_state = ""
	icon_state = ""
	var/changing_state = FALSE
	var/delay2open = 0
	var/delay2close = 0
	max_integrity = 0
	nomouseover = TRUE
	mouse_opacity = 0

/obj/structure/floordoor/gatehatch/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 40)
	return ..()

/obj/structure/floordoor/gatehatch/redstone_triggered(mob/user)
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	togg = !togg
	if(togg)
		sleep(delay2open)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
		sleep(40-delay2open)
		changing_state = FALSE
	else
		sleep(delay2close)
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
		sleep(40-delay2close)
		changing_state = FALSE

/obj/structure/floordoor/gatehatch/inner
	delay2open = 10
	delay2close = 30

/obj/structure/floordoor/gatehatch/outer
	delay2open = 30
	delay2close = 10

/obj/structure/kybraxor
	name = "Kybraxor the Devourer"
	desc = "The mad duke's hungriest pet."
	density = FALSE
	nomouseover = TRUE
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "kybraxor1"
	redstone_id = "gatelava"
	var/openn = FALSE
	var/changing_state = FALSE
	layer = ABOVE_OPEN_TURF_LAYER
	max_integrity = 0

/obj/structure/kybraxor/redstone_triggered(mob/user)
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	openn = !openn
	if(openn)
		playsound(src, 'sound/misc/kybraxorop.ogg', 100, FALSE)
		flick("kybraxoropening",src)
		sleep(40)
		icon_state = "kybraxor0"
		changing_state = FALSE
	else
		playsound(src, 'sound/misc/kybraxor.ogg', 100, FALSE)
		flick("kybraxorclosing",src)
		sleep(40)
		icon_state = "kybraxor1"
		changing_state = FALSE
