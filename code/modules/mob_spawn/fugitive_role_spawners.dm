

/obj/effect/mob_spawn/ghost_role/human/fugitive
	assignedrole = "Fugitive Hunter"
	flavour_text = "" //the flavor text will be the backstory argument called on the antagonist's greet, see hunter.dm for details
	show_flavor = FALSE
	density = TRUE
	var/back_story = "error"

/obj/effect/mob_spawn/ghost_role/human/fugitive/Initialize(mapload)
	. = ..()
	notify_ghosts("Hunters are waking up looking for refugees!", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_FUGITIVE)

/obj/effect/mob_spawn/ghost_role/human/fugitive/spacepol
	name = "police pod"
	desc = "A small sleeper typically used to put people to sleep for briefing on the mission."
	mob_name = "a spacepol officer"
	flavour_text = "Justice has arrived. I am a member of the Spacepol!"
	back_story = "space cop"
	outfit = /datum/outfit/spacepol
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/russian
	name = "russian pod"
	flavour_text = "Ay blyat. I am a space-russian smuggler! We were mid-flight when our cargo was beamed off our ship!"
	back_story = "russian"
	desc = "A small sleeper typically used to make long distance travel a bit more bearable."
	mob_name = "russian"
	outfit = /datum/outfit/frontier/hunter
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty
	name = "bounty hunter pod"
	flavour_text = "We got a new bounty on some fugitives, dead or alive."
	back_story = "bounty hunters"
	desc = "A small sleeper typically used to make long distance travel a bit more bearable."
	mob_name = "bounty hunter"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/Destroy()
	var/obj/structure/fluff/empty_sleeper/S = new(drop_location())
	S.setDir(dir)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/armor
	outfit = /datum/outfit/bountyarmor

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/hook
	outfit = /datum/outfit/bountyhook

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/synth
	outfit = /datum/outfit/bountysynth
