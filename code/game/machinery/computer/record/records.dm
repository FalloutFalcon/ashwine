/obj/machinery/computer/records
	name = "records console"
	desc = "This can be used to check medical records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list()
	circuit = /obj/item/circuitboard/computer

/obj/machinery/computer/records/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(.)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Records")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/records/ui_data(mob/user)
	var/list/data = ..()

	var/has_access = (authenticated && isliving(user)) || isAdminGhostAI(user)
	data["authenticated"] = has_access
	if(!has_access)
		return data

	var/list/records = list()
	for(var/datum/data/record/target in SSdatacore.get_records(DATACORE_RECORDS_OUTPOST))
		records += list(list(
			age = target.fields[DATACORE_AGE],
			blood_type = target.fields[DATACORE_BLOOD_TYPE],
			crew_ref = REF(target),
			dna = target.fields[DATACORE_BLOOD_DNA],
			gender = target.fields[DATACORE_GENDER],
			disabilities = target.fields[DATACORE_DISABILITIES],
			physical_status = target.fields[DATACORE_PHYSICAL_HEALTH],
			mental_status = target.fields[DATACORE_MENTAL_HEALTH],
			name = target.fields[DATACORE_NAME],
			rank = target.fields[DATACORE_RANK],
			species = target.fields[DATACORE_SPECIES],
		))

	data["records"] = records

	return data

/obj/machinery/computer/records/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/datum/data/record/target
	if(params["crew_ref"])
		target = locate(params["crew_ref"]) in SSdatacore.get_records(DATACORE_RECORDS_OUTPOST)

	switch(action)
		if("login")
			authenticated = secure_login(usr)
			investigate_log("[key_name(usr)] [authenticated ? "successfully logged" : "failed to log"] into the [src].", INVESTIGATE_RECORDS)
			return TRUE

		if("logout")
			balloon_alert(usr, "logged out")
			playsound(src, 'sound/machines/terminal_off.ogg', 70, TRUE)
			authenticated = FALSE

			return TRUE

		if("edit_field")
			target = locate(params["ref"]) in SSdatacore.get_records(DATACORE_RECORDS_OUTPOST)
			var/field = params["field"]
			if(!field || !(field in target?.vars))
				return FALSE

			var/value = trim(params["value"], MAX_BROADCAST_LEN)
			investigate_log("[key_name(usr)] changed the field: \"[field]\" with value: \"[target.vars[field]]\" to new value: \"[value || "Unknown"]\"", INVESTIGATE_RECORDS)
			target.vars[field] = value || "Unknown"

			return TRUE

		if("view_record")
			if(!target)
				return FALSE

			playsound(src, "sound/machines/terminal_button0[rand(1, 8)].ogg", 50, TRUE)
			balloon_alert(usr, "viewing record for [target.fields[DATACORE_NAME]]")
			return TRUE

	return FALSE

/obj/machinery/computer/records/proc/secure_login(mob/user)
	if(!is_operational)
		return FALSE

	if(!allowed(user))
		balloon_alert(user, "access denied")
		return FALSE

	balloon_alert(user, "logged in")
	playsound(src, 'sound/machines/terminal_on.ogg', 70, TRUE)

	return TRUE
