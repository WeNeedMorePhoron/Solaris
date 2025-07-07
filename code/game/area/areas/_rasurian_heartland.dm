/// Technically the basetype for any CentCom Z-level content. Just go with it; it's the status quo because some dumbass wrote this comment smugly not wanting to fix their own techdebt.
/area/rasurian_heartland
	name = "The Rasurian Heartland"
	icon_state = "rasura"
	has_gravity = STANDARD_GRAVITY
	ambientsounds = null
	always_unpowered = TRUE
	poweralm = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	noteleport = TRUE
	blob_allowed = FALSE //Should go without saying, no blobs should take over centcom as a win condition.
	flags_1 = NONE
	brief_descriptor = "somewhere far, far away"
