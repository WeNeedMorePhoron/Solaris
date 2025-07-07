/obj/structure/roguemachine/hoardmaster
	name = "Hoardmaster"
	desc = "A gilded stonework statuette of a dragon."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "Hoardmaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	/// This should really be on roguemachine honestly.. actually; what was wrong with /obj/machinery other than requiring power. kinda malding about this
	var/upgrade_flags
	/// Our current category
	var/current_cat = "1"

/obj/structure/roguemachine/hoardmaster/Initialize()
	. = ..()
	update_icon()

/obj/structure/roguemachine/hoardmaster/examine(mob/user)
	. = ..()
	if(user.mind?.has_antag_datum(/datum/antagonist/bandit))
		. += span_info("I can use it to purchase goods at my leisure.")
		return
	else
		. += span_warning("Something about it makes me uneasy, like its eyes are following me.")
		return

/obj/structure/roguemachine/hoardmaster/Topic(href, href_list)
	. = ..()
	if(!HAS_TRAIT(usr, TRAIT_BANDIT))
		return
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(!ishuman(usr))
		return
	if(href_list["buy"])
		var/mob/M = usr
		var/datum/antagonist/bandit/B = M.mind.has_antag_datum(/datum/antagonist/bandit)
		var/path = text2path(href_list["buy"])
		if(!ispath(path, /datum/supply_pack))
			message_admins("[ADMIN_JMP(usr)] attempted to purchase something that wasn't a supply pack via the [src]! Possible HREF Exploit in use.")
			log_admin("[usr] attempted to purchase something that wasn't a supply pack via the [src]! Possible HREF Exploit in use.")
			return
		var/datum/supply_pack/PA = SSmerchant.supply_packs[path]
		var/cost = PA.cost
		if(B.favor >= cost)
			B.favor -= cost
			playsound(loc, 'sound/misc/hoardmasterpurchase.ogg', 80, FALSE, -1)
		else
			say("Earn your keep first!")
			return
		var/shoplength = PA.contains.len
		var/l
		for(l=1,l<=shoplength,l++)
			var/pathi = pick(PA.contains)
			new pathi(get_turf(M))
	if(href_list["changecat"])
		current_cat = href_list["changecat"]
	return attack_hand(usr)

/obj/structure/roguemachine/hoardmaster/attack_hand(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_BANDIT))
		return
	var/datum/antagonist/bandit/B = usr.mind.has_antag_datum(/datum/antagonist/bandit)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/contents
	contents = "<center>Wishes from the Dark<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>Your favor:</a> [B.favor]<BR>"


	var/list/unlocked_cats = list("Things")
	switch(usr.advjob)
		if("Brigand")
			unlocked_cats+="Brigand"
		if("Sellsword")
			unlocked_cats+="Sellsword"
		if("Sawbones")
			unlocked_cats+="Sawbones"
		if("Hedge Knight")
			unlocked_cats+="Knight"
		if("Rogue Mage")
			unlocked_cats+="Mage"
		if("Knave")
			unlocked_cats+="Knave"
		if("Iconoclast")
			unlocked_cats+="Iconoclast"
   
	if(current_cat == "1")
		contents += "<center>"
		for(var/X in unlocked_cats)
			contents += "<a href='?src=[REF(src)];changecat=[X]'>[X]</a><BR>"
		contents += "</center>"
	else
		contents += "<center>[current_cat]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == current_cat)
				pax += PA
		for(var/datum/supply_pack/PA in sortList(pax))
			contents += "[PA.name] [PA.contains.len > 1?"x[PA.contains.len]":""] - ([PA.cost])<a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><BR>"

	var/datum/browser/popup = new(user, "HOARDMASTER", "", 370, 600)
	popup.set_content(contents)
	popup.open()


/obj/structure/roguemachine/hoardbarrier //Blocks sprite locations
	name = ""
	desc = /obj/structure/roguemachine/hoardmaster::desc
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE
