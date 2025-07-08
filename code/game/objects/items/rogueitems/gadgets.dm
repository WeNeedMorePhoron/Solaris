/obj/item/storage/gadget
	name = "gadget"
	desc = "A gadget of some sort."
	icon = 'icons/roguetown/items/gadgets.dmi'
	icon_state = "gadget"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_HIP
	dropshrink = 0.75
	resistance_flags = FIRE_PROOF


/obj/item/storage/gadget/messkit
	name = "mess kit"
	desc = "A small, portable mess kit. It can be used to cook food."
	slot_flags = ITEM_SLOT_HIP
	icon_state = "messkit"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	component_type = /datum/component/storage/concrete/roguetown/messkit

/obj/item/storage/gadget/messkit/PopulateContents()
	new /obj/item/cooking/platter(src)
	new /obj/item/reagent_containers/glass/bowl(src)
	new /obj/item/cooking/pan(src)
	new /obj/item/kitchen/spoon/plastic(src)
	new /obj/item/kitchen/fork(src)

/obj/item/storage/gadget/smokingpouch
	name = "Smoking Pouch"
	desc = "A small leather roll that holds everything a smoker needs."
	slot_flags = ITEM_SLOT_HIP
	icon_state = "smokingpouch"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	component_type = /datum/component/storage/concrete/roguetown/smokingpouch

/obj/item/storage/gadget/smokingpouch/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry(src)
	new /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry(src)
	new /obj/item/clothing/mask/cigarette/pipe(src)
	new /obj/item/paper(src)
	new /obj/item/paper(src)

/obj/item/folding_table_stored
	name = "folding table"
	desc = "A folding table, useful for setting up a temporary workspace."
	icon = 'icons/roguetown/items/gadgets.dmi'
	icon_state = "foldingTableStored"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	grid_height = 32
	grid_width = 64

/obj/item/folding_table_stored/attack_self(mob/user)
	. = ..()
	//deploy the table if the user clicks on it with an open turf in front of them
	var/turf/target_turf = get_step(user,user.dir)
	if(target_turf.is_blocked_turf(TRUE) || (locate(/mob/living) in target_turf))
		return NONE
	if(isopenturf(target_turf))
		to_chat(user, "Open turf detected, deploying folding table.")
		deploy_folding_table(user, target_turf)
		return TRUE
	return NONE

/obj/item/folding_table_stored/proc/deploy_folding_table(mob/user, atom/location)
	to_chat(user, "<span class='notice'>You deploy the folding table.</span>")
	new /obj/structure/table/wood/folding(location)
	qdel(src)
