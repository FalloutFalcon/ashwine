/obj/effect/mob_spawn/corpse/human/assistant
	name = "Assistant"
	outfit = /datum/outfit/job/assistant
	icon_state = "corpsegreytider"

/obj/effect/mob_spawn/corpse/human/assistant/husked
	husk = TRUE

/obj/effect/mob_spawn/corpse/human/cargo_tech
	name = "Cargo Tech"
	outfit = /datum/outfit/job/cargo_tech
	icon_state = "corpsecargotech"

/obj/effect/mob_spawn/corpse/human/cook
	name = "Cook"
	outfit = /datum/outfit/job/cook
	icon_state = "corpsecook"

/obj/effect/mob_spawn/corpse/human/cook/husked
	husk = TRUE

/obj/effect/mob_spawn/corpse/human/doctor
	name = "Doctor"
	outfit = /datum/outfit/job/doctor
	icon_state = "corpsedoctor"

/obj/effect/mob_spawn/corpse/human/engineer
	name = "Engineer"
	outfit = /datum/outfit/job/engineer
	icon_state = "corpseengineer"

/obj/effect/mob_spawn/corpse/human/clown
	name = "Clown"
	outfit = /datum/outfit/job/clown
	icon_state = "corpseclown"

/obj/effect/mob_spawn/corpse/human/scientist
	name = "Scientist"
	outfit = /datum/outfit/job/scientist
	icon_state = "corpsescientist"

/obj/effect/mob_spawn/corpse/human/miner
	name = "Shaft Miner"
	outfit = /datum/outfit/job/miner
	icon_state = "corpseminer"

/obj/effect/mob_spawn/corpse/human/plasmaman
	mob_species = /datum/species/plasmaman
	outfit = /datum/outfit/plasmaman

/obj/effect/mob_spawn/corpse/human/botanist
	outfit = /datum/outfit/job/botanist
	icon_state = "corpsehuman"

/obj/effect/mob_spawn/corpse/human/botanist/husked
	husk = TRUE

/obj/effect/mob_spawn/corpse/human/sec
	outfit = /datum/outfit/job/security
	icon_state = "corpsehuman"

/obj/effect/mob_spawn/corpse/human/hop
	outfit = /datum/outfit/job/head_of_personnel
	icon_state = "corpsehuman"

/obj/effect/mob_spawn/corpse/human/janitor
	outfit = /datum/outfit/job/janitor
	icon_state = "corpsehuman"

/obj/effect/mob_spawn/corpse/human/bartender
	name = "Space Bartender"
	icon_state = "corpsebartender"
	id_job = "Bartender"
	id_access_list = list(ACCESS_BAR)
	outfit = /datum/outfit/spacebartender

/datum/outfit/spacebartender
	name = "Space Bartender"
	uniform = /obj/item/clothing/under/rank/civilian/bartender
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	suit = /obj/item/clothing/suit/armor/vest
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	id = /obj/item/card/id

/obj/effect/mob_spawn/corpse/human/bartender/husked
	husk = TRUE

/obj/effect/mob_spawn/corpse/human/beach
	outfit = /datum/outfit/beachbum

/datum/outfit/beachbum
	name = "Beach Bum"
	glasses = /obj/item/clothing/glasses/sunglasses
	r_pocket = /obj/item/storage/wallet/random
	l_pocket = /obj/item/reagent_containers/food/snacks/pizzaslice/dank
	uniform = /obj/item/clothing/under/pants/jeans
	id = /obj/item/card/id

/datum/outfit/beachbum/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.dna.add_mutation(STONER)

/obj/effect/mob_spawn/corpse/human/bridgeofficer
	name = "Bridge Officer"
	id_job = "Bridge Officer"
	id_access_list = list(ACCESS_CENT_CAPTAIN)
	outfit = /datum/outfit/nanotrasenbridgeofficercorpse

/datum/outfit/nanotrasenbridgeofficercorpse
	name = "Bridge Officer Corpse"
	ears = /obj/item/radio/headset/heads/head_of_personnel
	uniform = /obj/item/clothing/under/rank/centcom/official
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id

/obj/effect/mob_spawn/corpse/human/commander
	name = "Commander"
	id_job = "Commander"
	id_access_list = list(ACCESS_CENT_CAPTAIN, ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_STORAGE)
	outfit = /datum/outfit/nanotrasencommandercorpse

/datum/outfit/nanotrasencommandercorpse
	name = "\improper Nanotrasen Private Security Commander"
	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	ears = /obj/item/radio/headset/heads/captain
	glasses = /obj/item/clothing/glasses/eyepatch
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	head = /obj/item/clothing/head/centhat
	gloves = /obj/item/clothing/gloves/tackler/combat
	shoes = /obj/item/clothing/shoes/combat/swat
	r_pocket = /obj/item/lighter
	id = /obj/item/card/id

/obj/effect/mob_spawn/corpse/human/nanotrasensoldier
	name = "\improper Nanotrasen LP Security Specialist"
	id_job = "Private Security Force"
	id_access_list = list(ACCESS_CENT_CAPTAIN, ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_STORAGE, ACCESS_SECURITY, ACCESS_MECH_SECURITY)
	outfit = /datum/outfit/job/nanotrasen/security/lp

/obj/effect/mob_spawn/corpse/human/skeleton
	name = "skeletal remains"
	mob_name = "skeleton"
	mob_species = /datum/species/skeleton

/obj/effect/mob_spawn/corpse/human/zombie
	name = "rotting corpse"
	mob_name = "zombie"
	mob_species = /datum/species/zombie

//Meant for simple animals to drop lootable human bodies.

//If someone can do this in a neater way, be my guest-Kor

//This has to be separate from the Away Mission corpses, because New() doesn't work for those, and initialize() doesn't work for these.

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

//List of different corpse types

/obj/effect/mob_spawn/corpse/human/syndicatesoldier
	name = "Syndicate Operative"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatesoldiercorpse

/datum/outfit/syndicatesoldiercorpse
	name = "Syndicate Operative Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/swat
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/corpse/human/syndicatecommando
	name = "Syndicate Commando"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatecommandocorpse

/datum/outfit/syndicatecommandocorpse
	name = "Syndicate Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/corpse/human/syndicateramzi
	name = "Ramzi's Clique Commando"
	id_job = "Cutthroat"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicateramzicorpse

/datum/outfit/syndicateramzicorpse
	name = "Ramzi's Clique Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate/gorlex
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/syndicate


/obj/effect/mob_spawn/corpse/human/syndicatestormtrooper
	name = "Syndicate Stormtrooper"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatestormtroopercorpse

/datum/outfit/syndicatestormtroopercorpse
	name = "Syndicate Stormtrooper Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen/harness
	id = /obj/item/card/id/syndicate


/obj/effect/mob_spawn/corpse/human/clown/corpse
	skin_tone = "caucasian1"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/obj/effect/mob_spawn/corpse/human/pirate
	name = "Pirate"
	skin_tone = "caucasian1" //all pirates are white because it's easier that way
	outfit = /datum/outfit/piratecorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/piratecorpse
	name = "Pirate Corpse"
	uniform = /obj/item/clothing/under/costume/pirate
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/eyepatch
	head = /obj/item/clothing/head/bandana


/obj/effect/mob_spawn/corpse/human/pirate/ranged
	name = "Pirate Gunner"
	outfit = /datum/outfit/piratecorpse/ranged

/datum/outfit/piratecorpse/ranged
	name = "Pirate Gunner Corpse"
	suit = /obj/item/clothing/suit/pirate
	head = /obj/item/clothing/head/pirate


/obj/effect/mob_spawn/corpse/human/frontier
	name = "Frontiersman"
	outfit = /datum/outfit/frontier
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/frontier
	name = "Frontiersman Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec/frontier
	gloves = /obj/item/clothing/gloves/color/black

/obj/effect/mob_spawn/corpse/human/frontier/ranged
	outfit = /datum/outfit/frontier

/obj/effect/mob_spawn/corpse/human/frontier/ranged/trooper
	outfit = /datum/outfit/frontier/trooper

/datum/outfit/frontier/trooper
	name = "Frontiersman Armored Corpse"
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	head = /obj/item/clothing/head/helmet/bulletproof/x11/frontier


/obj/effect/mob_spawn/corpse/human/frontier/ranged/officer
	name = "Frontiersman Officer"
	outfit = /datum/outfit/frontier/officer

/datum/outfit/frontier/officer
	name = "Frontiersman Officer Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	suit = /obj/item/clothing/suit/armor/frontier
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset
	head = /obj/item/clothing/head/caphat/frontier

/obj/effect/mob_spawn/corpse/human/frontier/ranged/trooper/heavy
	outfit = /datum/outfit/frontier/trooper/heavy

/datum/outfit/frontier/trooper/heavy
	name = "Frontiersman Heavy Corpse"
	suit = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	back = /obj/item/minigunpack

/obj/effect/mob_spawn/corpse/human/frontier/ranged/trooper/heavy/gunless
	outfit = /datum/outfit/frontier/trooper/heavy/gunless

/datum/outfit/frontier/trooper/heavy/gunless
	name = "Frontiersman Heavy Corpse (Gunless)"
	back = null

/obj/effect/mob_spawn/corpse/human/wizard
	name = "Space Wizard Corpse"
	outfit = /datum/outfit/wizardcorpse
	hairstyle = "Bald"
	facial_hairstyle = "Long Beard"
	skin_tone = "caucasian1"

/datum/outfit/wizardcorpse
	name = "Space Wizard Corpse"
	uniform = /obj/item/clothing/under/color/lightpurple
	suit = /obj/item/clothing/suit/wizrobe
	shoes = /obj/item/clothing/shoes/sandal/magic
	head = /obj/item/clothing/head/wizard


/obj/effect/mob_spawn/corpse/human/nanotrasensoldier
	name = "\improper Nanotrasen Private Security Officer"
	id_job = "Private Security Force"
	outfit = /datum/outfit/nanotrasensoldiercorpse2
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/nanotrasensoldiercorpse2
	name = "NT Private Security Officer Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id

/obj/effect/mob_spawn/corpse/human/nanotrasenassaultsoldier
	name = "Nanotrasen Private Security Officer"
	id_job = "Nanotrasen Assault Force"
	outfit = /datum/outfit/nanotrasenassaultsoldiercorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/nanotrasenassaultsoldiercorpse
	name = "NT Assault Officer Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id

/obj/effect/mob_spawn/corpse/human/cat_butcher
	name = "The Cat Surgeon"
	id_job = "Cat Surgeon"
	id_access_list = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)
	hairstyle = "Cut Hair"
	facial_hairstyle = "Watson Mustache"
	skin_tone = "caucasian1"
	outfit = /datum/outfit/cat_butcher

/datum/outfit/cat_butcher
	name = "Cat Butcher Uniform"
	uniform = /obj/item/clothing/under/rank/medical/doctor/green
	suit = /obj/item/clothing/suit/apron/surgical
	shoes = /obj/item/clothing/shoes/sneakers/white
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack/satchel/med
	id = /obj/item/card/id
	glasses = /obj/item/clothing/glasses/hud/health

/obj/effect/mob_spawn/corpse/human/solgov/sonnensoldner
	name = "SolGov Sonnensoldner"
	id_job = "SolGov Sonnensoldner"
	outfit = /datum/outfit/job/solgov/sonnensoldner
	id_access_list = list(ACCESS_SOLGOV)
