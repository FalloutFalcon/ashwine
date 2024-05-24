/obj/effect/corpse_spawner
	name = "Corpse Spawner"
	icon = 'icons/effects/mapping_helpers.dmi' // These aren't *really* mapping helpers but it fits the most with it's common usage (to help place corpses in maps)
	icon_state = "corpsehuman" // So it shows up in the map editor
	var/mob_type = null
	var/mob_name = ""
	var/mob_gender = null
	var/roundstart = FALSE
	var/instant = TRUE
	var/faction = null
	var/random = FALSE		//Don't set a name or gender, just go random
	var/brute_damage = 0
	var/oxy_damage = 0
	var/burn_damage = 0
	var/datum/disease/disease = null //Do they start with a pre-spawned disease?
	var/mob_color //Change the mob's color
	var/assignedrole

/obj/effect/corpse_spawner/Initialize(mapload)
	. = ..()
	if(instant || (roundstart && (mapload || (SSticker && SSticker.current_state > GAME_STATE_SETTING_UP))))
		INVOKE_ASYNC(src, PROC_REF(create))

/obj/effect/corpse_spawner/proc/equip(mob/M)
	return

/obj/effect/corpse_spawner/proc/create(newname)
	var/mob/living/M = new mob_type(get_turf(src)) //living mobs only
	if(!random || newname)
		if(newname)
			M.real_name = newname
		else
			M.real_name = mob_name ? mob_name : M.name
		if(!mob_gender)
			mob_gender = pick(MALE, FEMALE)
		M.gender = mob_gender
	if(faction)
		M.faction = list(faction)
	if(disease)
		M.ForceContractDisease(new disease)
	M.death(TRUE) //Kills the new mob

	M.adjustOxyLoss(oxy_damage)
	M.adjustBruteLoss(brute_damage)
	M.adjustFireLoss(burn_damage)
	M.color = mob_color
	equip(M)
	qdel(src)

// Base version - place these on maps/templates.
/obj/effect/corpse_spawner/human
	mob_type = /mob/living/carbon/human
	//Human specific stuff.
	var/mob_species = null		//Set to make them a mutant race such as lizard or skeleton. Uses the datum typepath instead of the ID.
	var/datum/outfit/outfit = /datum/outfit	//If this is a path, it will be instanced in Initialize()
	//All of these only affect the ID that the outfit has placed in the ID slot
	var/id_job = null			//Such as "Clown" or "Chef." This just determines what the ID reads as, not their access
	var/id_access_list = null	//Allows you to manually add access to an ID card.

	var/husk = null
	//these vars are for lazy mappers to override parts of the outfit
	//these cannot be null by default, or mappers cannot set them to null if they want nothing in that slot
	var/uniform = -1
	var/r_hand = -1
	var/l_hand = -1
	var/suit = -1
	var/shoes = -1
	var/gloves = -1
	var/ears = -1
	var/glasses = -1
	var/mask = -1
	var/head = -1
	var/belt = -1
	var/r_pocket = -1
	var/l_pocket = -1
	var/back = -1
	var/id = -1
	var/neck = -1
	var/backpack_contents = -1
	var/suit_store = -1

	var/hairstyle
	var/facial_hairstyle
	var/skin_tone

/obj/effect/corpse_spawner/human/Initialize()
	if(ispath(outfit))
		outfit = new outfit()
	if(!outfit)
		outfit = new /datum/outfit
	return ..()

/obj/effect/corpse_spawner/human/equip(mob/living/carbon/human/H)
	if(mob_species)
		H.set_species(mob_species)
	if(husk)
		H.Drain()
	H.underwear = "Nude"
	H.undershirt = "Nude"
	H.socks = "Nude"
	if(hairstyle)
		H.hairstyle = hairstyle
	else
		H.hairstyle = random_hairstyle(H.gender)
	if(facial_hairstyle)
		H.facial_hairstyle = facial_hairstyle
	else
		H.facial_hairstyle = random_facial_hairstyle(H.gender)
	if(skin_tone)
		H.skin_tone = skin_tone
	else
		H.skin_tone = random_skin_tone()
	H.update_hair()
	H.update_body()
	if(outfit)
		var/static/list/slots = list("uniform", "r_hand", "l_hand", "suit", "shoes", "gloves", "ears", "glasses", "mask", "head", "belt", "r_pocket", "l_pocket", "back", "id", "neck", "backpack_contents", "suit_store")
		for(var/slot in slots)
			var/T = vars[slot]
			if(!isnum(T))
				outfit.vars[slot] = T
		H.equipOutfit(outfit)
		// We don't want corpse PDAs to show up in the messenger list.
		var/obj/item/pda/PDA = locate(/obj/item/pda) in H
		if(PDA)
			PDA.toff = TRUE
		// Using crew monitors to find corpses while creative makes finding certain ruins too easy.
		var/obj/item/clothing/under/C = H.w_uniform
		if(istype(C))
			C.sensor_mode = NO_SENSORS

	var/obj/item/card/id/W = H.wear_id
	if(W)
		if(H.age)
			W.registered_age = H.age
		if(id_access_list)
			if(!islist(W.access))
				W.access = list()
			W.access |= id_access_list
		if(id_job)
			W.assignment = id_job
		W.registered_name = H.real_name
		W.update_label()
