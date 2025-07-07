/obj/effect/mapping_helpers/access
	layer = WALL_OBJ_LAYER
	icon_state = "access_helper"
	var/our_lockid = null

/obj/effect/mapping_helpers/access/Initialize()
	. = ..()
	if(!our_lockid)
		CRASH("No lockid configured for [src]!")
	var/obj/structure/mineral_door/our_door = locate(/obj/structure/mineral_door) in loc
	if(our_door.lockid != null)
		log_mapping("[src] at [AREACOORD(src)] tried to set lockid, but lockid was already set!")
		return
	our_door.lockid = our_lockid
	if(GLOB.lockids[our_lockid])
		our_door.lockhash = GLOB.lockids[our_lockid]
	else
		our_door.lockhash = rand(100,999)
		while(our_door.lockhash in GLOB.lockhashes)
			our_door.lockhash = rand(100,999)
		GLOB.lockhashes += our_door.lockhash
		GLOB.lockids[our_lockid] = our_door.lockhash

/// ANTAGONIST ///
/obj/effect/mapping_helpers/access/antag
	color = JCOLOR_ANTAG

/obj/effect/mapping_helpers/access/antag/bandit
	our_lockid = /obj/item/roguekey/bandit::lockid

/obj/effect/mapping_helpers/access/antag/underking
	our_lockid = /obj/item/roguekey/underking::lockid

/obj/effect/mapping_helpers/access/antag/vampire
	our_lockid = /obj/item/roguekey/vampire::lockid

/// CHAPEL OF LIGHTS ///
/obj/effect/mapping_helpers/access/church
	color = JCOLOR_CHURCH
	our_lockid = /obj/item/roguekey/church::lockid

/obj/effect/mapping_helpers/access/church/priest
	our_lockid = /obj/item/roguekey/priest::lockid

/obj/effect/mapping_helpers/access/church/graveyard
	our_lockid = /obj/item/roguekey/graveyard::lockid

/obj/effect/mapping_helpers/access/church/deacon
	our_lockid = /obj/item/roguekey/deacon::lockid

/// GARRISON ///
/obj/effect/mapping_helpers/access/garrison
	color = JCOLOR_SOLDIER
	our_lockid = /obj/item/roguekey/garrison::lockid

/obj/effect/mapping_helpers/access/garrison/warden
	our_lockid = /obj/item/roguekey/warden::lockid

/obj/effect/mapping_helpers/access/garrison/dungeon
	our_lockid = /obj/item/roguekey/dungeon::lockid

/obj/effect/mapping_helpers/access/garrison/sheriff
	our_lockid = /obj/item/roguekey/sheriff::lockid

/obj/effect/mapping_helpers/access/garrison/armory
	our_lockid = /obj/item/roguekey/armory::lockid

/// MAGE'S UNIVERSITY ///
/obj/effect/mapping_helpers/access/mages_university
	color = JCOLOR_MAGES
	our_lockid = /obj/item/roguekey/mages_university::lockid

/obj/effect/mapping_helpers/access/mages_university/archive
	our_lockid = /obj/item/roguekey/archive::lockid

/obj/effect/mapping_helpers/access/mages_university/private
	our_lockid = /obj/item/roguekey/mages_university/private::lockid

/obj/effect/mapping_helpers/access/mages_university/head_mage
	our_lockid = /obj/item/roguekey/mages_university/head_mage::lockid

/obj/effect/mapping_helpers/access/mages_university/tower
	our_lockid = /obj/item/roguekey/tower::lockid

/obj/effect/mapping_helpers/access/mages_university/artificer
	our_lockid = /obj/item/roguekey/artificer::lockid

/// NOBILITY ///
/obj/effect/mapping_helpers/access/noble
	color = JCOLOR_NOBLE
	our_lockid = /obj/item/roguekey/manor::lockid

/// EXCLUSIVE TO THE MASTER KEY. USE THIS SPARINGLY.
/obj/effect/mapping_helpers/access/noble/lord
	our_lockid = /obj/item/roguekey/lord::lockid

/obj/effect/mapping_helpers/access/noble/royal
	our_lockid = /obj/item/roguekey/royal::lockid

/obj/effect/mapping_helpers/access/noble/heir
	our_lockid = /obj/item/roguekey/heir::lockid

/obj/effect/mapping_helpers/access/noble/hand
	our_lockid = /obj/item/roguekey/hand::lockid

/obj/effect/mapping_helpers/access/noble/steward
	our_lockid = /obj/item/roguekey/steward::lockid

/obj/effect/mapping_helpers/access/noble/vault
	our_lockid = /obj/item/roguekey/vault::lockid

/// PEASANTRY ///
/obj/effect/mapping_helpers/access/peasant
	color = JCOLOR_PEASANT

/obj/effect/mapping_helpers/access/peasant/villagechief
	our_lockid = /obj/item/roguekey/velder::lockid

/obj/effect/mapping_helpers/access/peasant/farm
	our_lockid = /obj/item/roguekey/farm::lockid

/obj/effect/mapping_helpers/access/peasant/adventurers_guild
	our_lockid = /obj/item/roguekey/adventurers_guild::lockid

/obj/effect/mapping_helpers/access/peasant/stalli
	our_lockid = /obj/item/roguekey/apartments/stall1::lockid

/obj/effect/mapping_helpers/access/peasant/stallii
	our_lockid = /obj/item/roguekey/apartments/stall2::lockid

/obj/effect/mapping_helpers/access/peasant/stalliii
	our_lockid = /obj/item/roguekey/apartments/stall3::lockid

/obj/effect/mapping_helpers/access/peasant/stablei
	our_lockid = /obj/item/roguekey/apartments/stable1::lockid

/obj/effect/mapping_helpers/access/peasant/stableii
	our_lockid = /obj/item/roguekey/apartments/stable2::lockid

/// RASURA ///
/obj/effect/mapping_helpers/access/rasura
	color = JCOLOR_SLOP
	our_lockid = /obj/item/roguekey/rasura

/obj/effect/mapping_helpers/access/rasura/noble
	our_lockid = /obj/item/roguekey/rasura/noble

/// YEOMEN ///
/obj/effect/mapping_helpers/access/yeomen
	color = JCOLOR_YEOMAN

/obj/effect/mapping_helpers/access/yeomen/merchant
	our_lockid = /obj/item/roguekey/merchant::lockid

/obj/effect/mapping_helpers/access/yeomen/merchant/shop
	our_lockid = /obj/item/roguekey/shop::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern
	our_lockid = /obj/item/roguekey/tavern::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/innkeeper
	our_lockid = /obj/item/roguekey/tavernkeep::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomi
	our_lockid = /obj/item/roguekey/roomi::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomii
	our_lockid = /obj/item/roguekey/roomii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomiii
	our_lockid = /obj/item/roguekey/roomiii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomiv
	our_lockid = /obj/item/roguekey/roomiv::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomv
	our_lockid = /obj/item/roguekey/roomv::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomvi
	our_lockid = /obj/item/roguekey/roomvi::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomvii
	our_lockid = /obj/item/roguekey/roomvii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/roomviii
	our_lockid = /obj/item/roguekey/roomviii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/fancyroomi
	our_lockid = /obj/item/roguekey/fancyroomi::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/fancyroomii
	our_lockid = /obj/item/roguekey/fancyroomii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/fancyroomiii
	our_lockid = /obj/item/roguekey/fancyroomiii::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/fancyroomiv
	our_lockid = /obj/item/roguekey/fancyroomiv::lockid

/obj/effect/mapping_helpers/access/yeomen/tavern/fancyroomv
	our_lockid = /obj/item/roguekey/fancyroomv::lockid

/obj/effect/mapping_helpers/access/yeomen/janitor
	our_lockid = /obj/item/roguekey/janitor::lockid

/obj/effect/mapping_helpers/access/yeomen/tailor
	our_lockid = /obj/item/roguekey/tailor::lockid

/obj/effect/mapping_helpers/access/yeomen/blacksmith
	our_lockid = /obj/item/roguekey/blacksmith::lockid
