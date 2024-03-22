/obj/machinery/bounty_machine
	name = "bounty macine"
	desc = "A machine that dispenses bounties."
	icon = 'icons/obj/vending.dmi'
	icon_state = "bounty"
	var/list/bountys = list(
		"3 Eggs",
		"3 Eggs",
		"3 Eggs"
	)
	var/bounty_count = 3

/obj/machinery/bounty_machine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BountyMachine")
		ui.open()

/obj/machinery/bounty_machine/ui_data(mob/user)
	var/list/data = list()
	data["bountys"] = bountys
	return data

/obj/machinery/bounty_machine/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("refresh")
			refresh_bountys()
	update_icon() // Not applicable to all objects.

/obj/machinery/bounty_machine/proc/refresh_bountys()
	bountys = list()

	for(var/i in 1 to bounty_count)
		var/rand_num = rand(1, 999)
		var/bounty =  num2text(rand_num) + " Eggs"
		if(bounty)
			bountys += bounty


