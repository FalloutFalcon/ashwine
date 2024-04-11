////////Creation

/obj/item/guardiancreator
	name = "holoparasite injector"
	desc = "It contains an alien nanoswarm of unknown origin. Though capable of near sorcerous feats via use of hardlight holograms and nanomachines, it requires an organic host as a home base and source of fuel."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "combat_hypo"
	var/used = FALSE
	var/theme = "tech"
	var/mob_name = "Holoparasite"
	var/use_message = "<span class='holoparasite'>You start to power on the injector...</span>"
	var/used_message = "<span class='holoparasite'>The injector has already been used.</span>"
	var/failure_message = "<span class='holoparasite bold'>...ERROR. BOOT SEQUENCE ABORTED. AI FAILED TO INTIALIZE. PLEASE CONTACT SUPPORT OR TRY AGAIN LATER.</span>"
	var/list/possible_guardians = list("Assassin", "Chaos", "Charger", "Explosive", "Lightning", "Protector", "Ranged", "Standard", "Support", "Gravitokinetic")
	var/random = TRUE
	var/allowmultiple = FALSE
	var/allowguardian = FALSE

/obj/item/guardiancreator/attack_self(mob/living/user)
	if(isguardian(user) && !allowguardian)
		to_chat(user, "<span class='holoparasite'>[mob_name] chains are not allowed.</span>")
		return
	var/list/guardians = user.hasparasites()
	if(guardians.len && !allowmultiple)
		to_chat(user, "<span class='holoparasite'>You already have a [mob_name]!</span>")
		return
	if(used == TRUE)
		to_chat(user, "[used_message]")
		return
	used = TRUE
	to_chat(user, "[use_message]")
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to play as the [mob_name] of [user.real_name]?", ROLE_PAI, null, FALSE, 100, POLL_IGNORE_HOLOPARASITE)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		spawn_guardian(user, C.key)
	else
		to_chat(user, "[failure_message]")
		used = FALSE


/obj/item/guardiancreator/proc/spawn_guardian(mob/living/user, key)
	var/guardiantype = "Standard"
	if(random)
		guardiantype = pick(possible_guardians)
	else
		guardiantype = input(user, "Pick the type of [mob_name]", "[mob_name] Creation") as null|anything in sortList(possible_guardians)
		if(!guardiantype)
			to_chat(user, "[failure_message]" )
			used = FALSE
			return
	var/pickedtype = /mob/living/simple_animal/hostile/guardian/punch
	switch(guardiantype)

		if("Chaos")
			pickedtype = /mob/living/simple_animal/hostile/guardian/fire

		if("Standard")
			pickedtype = /mob/living/simple_animal/hostile/guardian/punch

		if("Ranged")
			pickedtype = /mob/living/simple_animal/hostile/guardian/ranged

		if("Support")
			pickedtype = /mob/living/simple_animal/hostile/guardian/healer

		if("Explosive")
			pickedtype = /mob/living/simple_animal/hostile/guardian/bomb

		if("Lightning")
			pickedtype = /mob/living/simple_animal/hostile/guardian/beam

		if("Protector")
			pickedtype = /mob/living/simple_animal/hostile/guardian/protector

		if("Charger")
			pickedtype = /mob/living/simple_animal/hostile/guardian/charger

		if("Assassin")
			pickedtype = /mob/living/simple_animal/hostile/guardian/assassin

		if("Dextrous")
			pickedtype = /mob/living/simple_animal/hostile/guardian/dextrous

		if("Gravitokinetic")
			pickedtype = /mob/living/simple_animal/hostile/guardian/gravitokinetic

	var/list/guardians = user.hasparasites()
	if(guardians.len && !allowmultiple)
		to_chat(user, "<span class='holoparasite'>You already have a [mob_name]!</span>" )
		used = FALSE
		return
	var/mob/living/simple_animal/hostile/guardian/G = new pickedtype(user, theme)
	G.name = mob_name
	G.summoner = user
	G.key = key
	G.mind.enslave_mind_to_creator(user)
	log_game("[key_name(user)] has summoned [key_name(G)], a [guardiantype] holoparasite.")
	switch(theme)
		if("tech")
			to_chat(user, "[G.tech_fluff_string]")
			to_chat(user, "<span class='holoparasite'><b>[G.real_name]</b> is now online!</span>")
		if("carp")
			to_chat(user, "[G.carp_fluff_string]")
			to_chat(user, "<span class='holoparasite'><b>[G.real_name]</b> has been caught!</span>")
		if("miner")
			to_chat(user, "[G.miner_fluff_string]")
			to_chat(user, "<span class='holoparasite'><b>[G.real_name]</b> has appeared!</span>")
	add_verb(user, list(/mob/living/proc/guardian_comm, \
						/mob/living/proc/guardian_recall, \
						/mob/living/proc/guardian_reset))
	G?.client.init_verbs()

/obj/item/guardiancreator/choose
	random = FALSE

/obj/item/paper/guides/antag/guardian
	name = "Holoparasite Guide"
	default_raw_text = {"<b>A list of Holoparasite Types</b><br>

<br>
<b>Assassin</b>: Does medium damage and takes full damage, but can enter stealth, causing its next attack to do massive damage and ignore armor. However, it becomes briefly unable to recall after attacking from stealth.<br>
<br>
<b>Chaos</b>: Ignites enemies on touch and causes them to hallucinate all nearby people as the parasite. Automatically extinguishes the user if they catch on fire.<br>
<br>
<b>Charger</b>: Moves extremely fast, does medium damage on attack, and can charge at targets, damaging the first target hit and forcing them to drop any items they are holding.<br>
<br>
<b>Dexterous</b>: Does low damage on attack, but is capable of holding items and storing a single item within it. It will drop items held in its hands when it recalls, but it will retain the stored item.<br>
<br>
<b>Explosive</b>: High damage resist and medium power attack that may explosively teleport targets. Can turn any object, including objects too large to pick up, into a bomb, dealing explosive damage to the next person to touch it. The object will return to normal after the trap is triggered or after a delay.<br>
<br>
<b>Lightning</b>: Attacks apply lightning chains to targets. Has a lightning chain to the user. Lightning chains shock everything near them, doing constant damage.<br>
<br>
<b>Protector</b>: Causes you to teleport to it when out of range, unlike other parasites. Has two modes; Combat, where it does and takes medium damage, and Protection, where it does and takes almost no damage but moves slightly slower.<br>
<br>
<b>Ranged</b>: Has two modes. Ranged; which fires a constant stream of weak, armor-ignoring projectiles. Scout; Cannot attack, but can move through walls and is quite hard to see. Can lay surveillance snares, which alert it when crossed, in either mode.<br>
<br>
<b>Standard</b>: Devastating close combat attacks and high damage resist. Can smash through weak walls.<br>
<br>
<b>Gravitokinetic</b>: Attacks will apply crushing gravity to the target. Can target the ground as well to slow targets advancing on you, but this will affect the user.<br>
<br>
"}

/obj/item/storage/box/syndie_kit/guardian
	name = "holoparasite injector kit"

/obj/item/storage/box/syndie_kit/guardian/PopulateContents()
	new /obj/item/guardiancreator/choose(src) //WS Edit - Dextrous Guardians
	new /obj/item/paper/guides/antag/guardian(src)

/obj/item/guardiancreator/carp
	name = "holocarp fishsticks"
	desc = "Fishsticks with tiny nanites "
	icon = 'icons/obj/food/food.dmi'
	icon_state = "fishfingers"
	theme = "carp"
	mob_name = "Holocarp"
	use_message = "<span class='holoparasite'>You put the fishsticks in your mouth...</span>"
	used_message = "<span class='holoparasite'>Someone's already taken a bite out of these fishsticks! Ew.</span>"
	failure_message = "<span class='holoparasite bold'>You couldn't catch any carp spirits from the seas of Lake Carp. Maybe there are none, maybe you fucked up.</span>"
	allowmultiple = TRUE

/obj/item/guardiancreator/carp/choose
	random = FALSE

/obj/item/guardiancreator/miner
	name = "dusty shard"
	desc = "Seems to be a very old rock, may have originated from a strange meteor."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "dustyshard"
	theme = "miner"
	mob_name = "Power Miner"
	use_message = "<span class='holoparasite'>You pierce your skin with the shard...</span>"
	used_message = "<span class='holoparasite'>This shard seems to have lost all its' power...</span>"
	failure_message = "<span class='holoparasite bold'>The shard hasn't reacted at all. Maybe try again later...</span>"

/obj/item/guardiancreator/miner/choose
	random = FALSE
	name = "glimmering shard"
	desc = "Seems to be a very old rock, may have originated from a strange meteor. <b>This one looks exceptionally pure.</b>"
	possible_guardians = list("Assassin", "Chaos", "Charger", "Dextrous", "Explosive", "Lightning", "Protector", "Ranged", "Standard", "Support")
	allowmultiple = TRUE//if you *somehow* get the extremely rare minerchoose guardian(25% chance to spawn, for an item in a table of around 30 options) while you already have a guardian, you can stack it. The ultimate gambling.
