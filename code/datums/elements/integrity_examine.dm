
/datum/element/integrity_examine

/datum/element/integrity_examine/Attach(obj/target)
	. = ..()
	if(!isobj(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/element/integrity_examine/Detach(obj/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_PARENT_EXAMINE)

/datum/element/integrity_examine/proc/on_examine(obj/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/healthpercent = round((source.obj_integrity/source.max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			examine_list += span_info("It looks slightly damaged.")
		if(25 to 50)
			examine_list += span_info("It appears heavily damaged.")
		if(0 to 25)
			examine_list += span_warning("It's falling apart!")
