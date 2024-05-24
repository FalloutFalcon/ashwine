//Objects that spawn ghosts in as a certain role when they click on it, i.e. away mission bartenders.

//Ash walker eggs: Spawns in ash walker dens in lavaland. Ghosts become unbreathing lizards that worship the Necropolis and are advised to retrieve corpses to create more ash walkers.

/obj/structure/ash_walker_eggshell
	name = "ash walker egg"
	desc = "A man-sized yellow egg, spawned from some unfathomable creature. A humanoid silhouette lurks within. The egg shell looks resistant to temperature but otherwise rather brittle."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	max_integrity = 80
	var/obj/effect/mob_spawn/ghost_role/human/ash_walker/egg

/obj/structure/ash_walker_eggshell/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0) //lifted from xeno eggs
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/ash_walker_eggshell/attack_ghost(mob/user) //Pass on ghost clicks to the mob spawner
	if(egg)
		egg.attack_ghost(user)
	. = ..()

/obj/structure/ash_walker_eggshell/Destroy()
	if(!egg)
		return ..()
	var/mob/living/carbon/human/yolk = new /mob/living/carbon/human/(get_turf(src))
	yolk.fully_replace_character_name(null,random_unique_lizard_name(gender))
	yolk.set_species(/datum/species/lizard/ashwalker/kobold) //WS Edit - Kobold
	yolk.underwear = "Nude"
	yolk.equipOutfit(/datum/outfit/ashwalker)//this is an authentic mess we're making
	yolk.update_body()
	yolk.gib()
	QDEL_NULL(egg)
	return ..()


/obj/effect/mob_spawn/ghost_role/human/ash_walker
	name = "ash walker egg"
	desc = "A man-sized yellow egg, spawned from some unfathomable creature. A humanoid silhouette lurks within."
	mob_name = "an ash walker"
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	mob_species = /datum/species/lizard/ashwalker/kobold //WS Edit - Kobold
	outfit = /datum/outfit/ashwalker
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	you_are_text = "You are an ash walker. Your tribe worships the Necropolis."
	flavour_text = "The wastes are sacred ground, its monsters a blessed bounty. \
	The invaders from the past have died long ago. You will survive until the next \
	day, and the day after. Your way of life is important to you."
	assignedrole = "Ash Walker"
	var/datum/team/ashwalkers/team
	var/obj/structure/ash_walker_eggshell/eggshell


/obj/effect/mob_spawn/ghost_role/human/ash_walker/Destroy()
	eggshell = null
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ash_walker/allow_spawn(mob/user , silent = FALSE)
	if(!(user.key in team.players_spawned))//one per person unless you get a bonus spawn
		return TRUE
	if(!silent)
		to_chat(user, span_warning("You have exhausted your usefulness to the Necropolis."))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(null,random_unique_lizard_name(gender))
	to_chat(new_spawn, "<b>Drag the corpses of beasts and the dead to your nest. It will absorb them to create more of your kind. You have never seen a outsider before, as that was before your time.</b>")

	new_spawn.mind.add_antag_datum(/datum/antagonist/ashwalker, team)

	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.underwear = "Nude"
		H.update_body()
		ADD_TRAIT(H, TRAIT_PRIMITIVE, ROUNDSTART_TRAIT)
	team.players_spawned += (new_spawn.key)
	eggshell.egg = null
	QDEL_NULL(eggshell)

/obj/effect/mob_spawn/ghost_role/human/ash_walker/Initialize(mapload, datum/team/ashwalkers/ashteam)
	. = ..()
	var/area/A = get_area(src)
	team = ashteam
	eggshell = new /obj/structure/ash_walker_eggshell(get_turf(loc))
	eggshell.egg = src
	src.forceMove(eggshell)
	if(A)
		notify_ghosts("An ash walker egg is ready to hatch in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_ASHWALKER)

/datum/outfit/ashwalker
	name ="Ashwalker"
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator/ash_walker

/obj/effect/mob_spawn/ghost_role/human/syndicate
	name = "Syndicate Operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/syndicate_empty
	assignedrole = "Space Syndicate"	//I know this is really dumb, but Syndicate operative is nuke ops

/datum/outfit/syndicate_empty
	name = "Syndicate Operative Empty"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate


/obj/effect/mob_spawn/ghost_role/human/pirate
	name = "space pirate sleeper"
	desc = "A cryo sleeper smelling faintly of rum."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_name = "a space pirate"
	mob_species = /datum/species/skeleton
	outfit = /datum/outfit/pirate/space
	anchored = TRUE
	density = FALSE
	show_flavor = FALSE //Flavour only exists for spawners menu
	you_are_text = "You are a space pirate."
	flavour_text = "The station refused to pay for your protection, protect the ship, siphon the credits from the station and raid it for even more loot."
	assignedrole = "Space Pirate"
	var/rank = "Mate"

/obj/effect/mob_spawn/ghost_role/human/pirate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(new_spawn.real_name,generate_pirate_name())

/obj/effect/mob_spawn/ghost_role/human/pirate/proc/generate_pirate_name()
	var/beggings = strings(PIRATE_NAMES_FILE, "beginnings")
	var/endings = strings(PIRATE_NAMES_FILE, "endings")
	return "[rank] [pick(beggings)][pick(endings)]"

/obj/effect/mob_spawn/ghost_role/human/pirate/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/ghost_role/human/pirate/captain
	rank = "Captain"
	outfit = /datum/outfit/pirate/space/captain

/obj/effect/mob_spawn/ghost_role/human/pirate/gunner
	rank = "Gunner"

/datum/outfit/syndicatespace
	name = "Syndicate Spacer"
	uniform = /obj/item/clothing/under/syndicate/combat
	mask = /obj/item/clothing/mask/gas/syndicate

/datum/outfit/syndicatespace/syndicrew
	name = "Syndicate Ship Crew Member"
	glasses = /obj/item/clothing/glasses/night
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	id = /obj/item/card/id/syndicate_command/crew_id
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicatespace/syndicaptain
	name = "Syndicate Ship Captain"
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	glasses = /obj/item/clothing/glasses/night
	head = /obj/item/clothing/head/HoS/beret/syndicate
	ears = /obj/item/radio/headset/syndicate/alt/captain
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/APS
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	id = /obj/item/card/id/syndicate_command/captain_id
	backpack_contents = list(/obj/item/documents/syndicate/red, /obj/item/paper/fluff/ruins/forgottenship/password)
	implants = list(/obj/item/implant/weapons_auth)

///Syndicate Listening Post

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "Syndicate Bioweapon Scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "You are a syndicate science technician, employed in a top secret research facility developing biological weapons."
	flavour_text = "Reports of potential Nanotrasen fleet movement in your sector prompted you to initiate Operation Smokescreen, killing base power and taking your crew into cryosleep. You've awoken an unknown amount of time later as base security initiates an emergency reboot. Keep vigilant for whatever reawoke you, continue your research as best you can, and try to keep a low profile."
	important_text = "Prevent yourself and any Syndicate assets from being taken by Corporate forces."
	outfit = /datum/outfit/lavaland_syndicate
	assignedrole = "Lavaland Syndicate"

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, TRUE, TRUE, LANGUAGE_MIND)

/datum/outfit/lavaland_syndicate
	name = "Lavaland Syndicate Agent"
	r_hand = /obj/item/gun/ballistic/automatic/sniper_rifle
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	r_pocket = /obj/item/gun/ballistic/automatic/pistol
	id = /obj/item/card/id/syndicate/anyone
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms
	name = "Syndicate Comms Agent"
	you_are_text = "You are a syndicate communications agent, employed in a top secret research facility developing biological weapons."
	flavour_text = "Reports of potential Nanotrasen fleet movement in your sector prompted you to initiate Operation Smokescreen, killing base power and taking your crew into cryosleep. You've awoken an unknown amount of time later as base security initiates an emergency reboot. Keep vigilant for whatever reawoke you, and try to keep a low profile. Use the communication equipment to monitor any local activity. Anyone nearby is presumed to be an agent of Nanotrasen: Sow disinformation to throw them off your trail. Do not let the base fall into enemy hands!"
	important_text = "Prevent yourself and any Syndicate assets from being taken by Corporate forces."
	outfit = /datum/outfit/lavaland_syndicate/comms

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	you_are_text = "You are a deep-cover syndicate agent, assigned to a small military listening post intended to keep an eye on Nanotrasen activity in the area. Increased military operations prompted you to follow Smokescreen protocol and go into cryosleep, leaving your base on minimal power."
	flavour_text = "Your base's emergency security system has reawoken you and brought the facility back to full power- It can only be presumed Nanotrasen personnel are close to locating you. Monitor any local activity as best you can, and try to keep a low profile. Use the communication equipment to attempt parlance, and sow disinformation to throw Nanotrasen off your trail."
	important_text = "Prevent yourself and any Syndicate assets from being taken by Corporate forces."

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space/Initialize()
	. = ..()
	if(prob(90)) //only has a 10% chance of existing, otherwise it'll just be a NPC syndie.
		new /mob/living/simple_animal/hostile/syndicate/ranged(get_turf(src))
		return INITIALIZE_HINT_QDEL

/datum/outfit/lavaland_syndicate/comms
	name = "Lavaland Syndicate Comms Agent"
	r_hand = /obj/item/melee/transforming/energy/sword/saber
	mask = /obj/item/clothing/mask/chameleon/gps
	suit = /obj/item/clothing/suit/armor/vest

/obj/item/clothing/mask/chameleon/gps/Initialize()
	. = ..()
	AddComponent(/datum/component/gps, "Encrypted Signal")
