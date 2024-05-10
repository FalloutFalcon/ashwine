//TODO: someone please get rid of this shit
/datum/datacore
	var/list/medical = list()
	var/medicalPrintCount = 0
	var/list/general = list()
	var/list/security = list()
	var/securityPrintCount = 0
	var/securityCrimeCounter = 0
	///This list tracks characters spawned in the world and cannot be modified in-game. Currently referenced by respawn_character().
	var/list/locked = list()

/datum/data
	var/name = "data"

/datum/data/record
	name = "record"
	var/list/fields = list()

/datum/data/record/Destroy()
	if(src in GLOB.data_core.medical)
		GLOB.data_core.medical -= src
	if(src in GLOB.data_core.security)
		GLOB.data_core.security -= src
	if(src in GLOB.data_core.general)
		GLOB.data_core.general -= src
	if(src in GLOB.data_core.locked)
		GLOB.data_core.locked -= src
	. = ..()

/datum/data/crime
	name = "crime"
	var/crimeName = ""
	var/crimeDetails = ""
	var/author = ""
	var/time = ""
	var/fine = 0
	var/paid = 0
	var/dataId = 0

/datum/datacore/proc/createCrimeEntry(cname = "", cdetails = "", author = "", time = "", fine = 0)
	var/datum/data/crime/c = new /datum/data/crime
	c.crimeName = cname
	c.crimeDetails = cdetails
	c.author = author
	c.time = time
	c.fine = fine
	c.paid = 0
	c.dataId = ++securityCrimeCounter
	return c

/**
 * Adds crime to security record.
 *
 * Is used to add single crime to someone's security record.
 * Arguments:
 * * id - record id.
 * * datum/data/crime/crime - premade array containing every variable, usually created by createCrimeEntry.
 */
/datum/datacore/proc/addCrime(id = "", datum/data/crime/crime)
	for(var/datum/data/record/R in security)
		if(R.fields[DATACORE_ID] == id)
			var/list/crimes = R.fields[DATACORE_CRIMES]
			crimes |= crime
			return

/**
 * Deletes crime from security record.
 *
 * Is used to delete single crime to someone's security record.
 * Arguments:
 * * id - record id.
 * * cDataId - id of already existing crime.
 */
/datum/datacore/proc/removeCrime(id, cDataId)
	for(var/datum/data/record/R in security)
		if(R.fields[DATACORE_ID] == id)
			var/list/crimes = R.fields[DATACORE_CRIMES]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crimes -= crime
					return

/**
 * Adds details to a crime.
 *
 * Is used to add or replace details to already existing crime.
 * Arguments:
 * * id - record id.
 * * cDataId - id of already existing crime.
 * * details - data you want to add.
 */
/datum/datacore/proc/addCrimeDetails(id, cDataId, details)
	for(var/datum/data/record/R in security)
		if(R.fields[DATACORE_ID] == id)
			var/list/crimes = R.fields[DATACORE_CRIMES]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crime.crimeDetails = details
					return

/datum/datacore/proc/manifest()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/N = i
		if(N.new_character)
			log_manifest(N.ckey,N.new_character.mind,N.new_character)
		if(ishuman(N.new_character))
			manifest_inject(N.new_character, N.client)
		CHECK_TICK

/datum/datacore/proc/manifest_modify(name, assignment)
	var/datum/data/record/foundrecord = find_record(DATACORE_NAME, name, GLOB.data_core.general)
	if(foundrecord)
		foundrecord.fields[DATACORE_RANK] = assignment

/datum/datacore/proc/get_manifest()
	var/list/manifest_out = list()
	var/list/departments = list(
		"Command" = GLOB.command_positions,
		"Security" = GLOB.security_positions,
		"Engineering" = GLOB.engineering_positions,
		"Medical" = GLOB.medical_positions,
		"Science" = GLOB.science_positions,
		"Supply" = GLOB.supply_positions,
		"Service" = GLOB.service_positions,
		"Silicon" = GLOB.nonhuman_positions
	)
	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields[DATACORE_NAME]
		var/rank = t.fields[DATACORE_RANK]
		var/has_department = FALSE
		for(var/department in departments)
			var/list/jobs = departments[department]
			if((rank in jobs))
				if(!manifest_out[department])
					manifest_out[department] = list()
				// Append to beginning of list if captain or department head
				if (rank == "Captain" || (department != "Command" && (rank in GLOB.command_positions)))
					manifest_out[department] = list(list(
						DATACORE_NAME = name,
						DATACORE_RANK = rank
					)) + manifest_out[department]
				else
					manifest_out[department] += list(list(
						DATACORE_NAME = name,
						DATACORE_RANK = rank
					))
				has_department = TRUE
		if(!has_department)
			if(!manifest_out["Misc"])
				manifest_out["Misc"] = list()
			manifest_out["Misc"] += list(list(
				DATACORE_NAME = name,
				DATACORE_RANK = rank
			))
	return manifest_out

/datum/datacore/proc/get_manifest_html(monochrome = FALSE)
	var/list/manifest = get_manifest()
	var/dat = {"
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome?"black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: #488;"] }
		.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest" width='350px'>
	<tr class='head'><th>Name</th><th>Rank</th></tr>
	"}
	for(var/department in manifest)
		var/list/entries = manifest[department]
		dat += "<tr><th colspan=3>[department]</th></tr>"
		//JUST
		var/even = FALSE
		for(var/entry in entries)
			var/list/entry_list = entry
			dat += "<tr[even ? " class='alt'" : ""]><td>[entry_list[DATACORE_NAME]]</td><td>[entry_list[DATACORE_RANK]]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "")
	dat = replacetext(dat, "\t", "")
	return dat


/datum/datacore/proc/manifest_inject(mob/living/carbon/human/H, client/C)
	set waitfor = FALSE
	var/static/list/show_directions = list(SOUTH, WEST)
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		var/assignment
		if(H.mind.assigned_role)
			assignment = H.mind.assigned_role
		else if(H.job)
			assignment = H.job
		else
			assignment = "Unassigned"

		var/static/record_id_num = 1001
		var/id = num2hex(record_id_num++,6)
		if(!C)
			C = H.client
		var/image = get_id_photo(H, C, show_directions)
		var/datum/picture/pf = new
		var/datum/picture/ps = new
		pf.picture_name = "[H]"
		ps.picture_name = "[H]"
		pf.picture_desc = "This is [H]."
		ps.picture_desc = "This is [H]."
		pf.picture_image = icon(image, dir = SOUTH)
		ps.picture_image = icon(image, dir = WEST)
		var/obj/item/photo/photo_front = new(null, pf)
		var/obj/item/photo/photo_side = new(null, ps)

		//These records should ~really~ be merged or something
		//General Record
		var/datum/data/record/G = new()
		G.fields[DATACORE_ID] = id
		G.fields[DATACORE_NAME] = H.real_name
		G.fields[DATACORE_RANK] = assignment
		G.fields[DATACORE_AGE] = H.age
		G.fields[DATACORE_SPECIES] = H.dna.species.name
		G.fields[DATACORE_FINGERPRINT] = md5(H.dna.uni_identity)
		G.fields[DATACORE_PHYSICAL_HEALTH] = "Active"
		G.fields[DATACORE_MENTAL_HEALTH] = "Stable"
		G.fields[DATACORE_GENDER] = H.gender
		if(H.gender == "male")
			G.fields[DATACORE_GENDER] = "Male"
		else if(H.gender == "female")
			G.fields[DATACORE_GENDER] = "Female"
		else
			G.fields[DATACORE_GENDER] = "Other"
		G.fields[DATACORE_PHOTO] = photo_front
		G.fields[DATACORE_PHOTO_SIDE] = photo_side
		general += G

		//Medical Record
		var/datum/data/record/M = new()
		M.fields[DATACORE_ID] = id
		M.fields[DATACORE_NAME] = H.real_name
		M.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type.name
		M.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
		M.fields[DATACORE_MINOR_DISABILITIES] = "None"
		M.fields[DATACORE_MINOR_DISABILITIES_DETAILS] = "No minor disabilities have been declared."
		M.fields[DATACORE_DISABILITIES] = "None"
		M.fields[DATACORE_DISABILITIES_DETAILS] = "No major disabilities have been diagnosed."
		M.fields[DATACORE_ALLERGIES] = "None"
		M.fields[DATACORE_ALLERGIES_DETAILS] = "No allergies have been detected in this patient."
		M.fields[DATACORE_DISEASES] = "None"
		M.fields[DATACORE_DISABILITIES_DETAILS] = "No diseases have been diagnosed at the moment."
		M.fields[DATACORE_NOTES] = H.get_trait_string(medical)
		medical += M

		//Security Record
		var/datum/data/record/S = new()
		S.fields[DATACORE_ID] = id
		S.fields[DATACORE_NAME] = H.real_name
		S.fields[DATACORE_CRIMINAL_STATUS] = "None"
		S.fields[DATACORE_CRIMES] = list()
		S.fields[DATACORE_NOTES] = "No notes."
		security += S

		//Locked Record
		var/datum/data/record/L = new()
		L.fields[DATACORE_ID] = md5("[H.real_name][H.mind.assigned_role]")	//surely this should just be id, like the others?
		L.fields[DATACORE_NAME] = H.real_name
		L.fields[DATACORE_RANK] = H.mind.assigned_role
		L.fields[DATACORE_AGE] = H.age
		L.fields[DATACORE_GENDER] = H.gender
		if(H.gender == "male")
			G.fields[DATACORE_GENDER] = "Male"
		else if(H.gender == "female")
			G.fields[DATACORE_GENDER] = "Female"
		else
			G.fields[DATACORE_GENDER] = "Other"
		L.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type
		L.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
		L.fields[DATACORE_DNA_IDENTITY] = H.dna.uni_identity
		L.fields[DATACORE_SPECIES] = H.dna.species.type
		L.fields[DATACORE_DNA_FEATURES] = H.dna.features
		L.fields[DATACORE_IMAGE] = image
		L.fields[DATACORE_MINDREF] = H.mind
		locked += L
	return

/datum/datacore/proc/get_id_photo(mob/living/carbon/human/H, client/C, show_directions = list(SOUTH), datum/job/J)
	var/datum/preferences/P
	if(!C)
		C = H.client
	if(C)
		P = C.prefs
	return get_flat_human_icon(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, show_directions)
