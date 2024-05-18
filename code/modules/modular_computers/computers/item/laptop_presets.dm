/obj/item/modular_computer/laptop/preset
	var/list/datum/computer_file/program/default_programs = list()

/obj/item/modular_computer/laptop/preset/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(new /obj/item/computer_hardware/hard_drive)
	install_component(new /obj/item/computer_hardware/network_card)
	install_programs()


/obj/item/modular_computer/laptop/preset/proc/install_programs()
	var/obj/item/computer_hardware/hard_drive/hard_drive = all_components[MC_HDD]
	for(var/program in default_programs)
		hard_drive.store_file(new program())

/obj/item/modular_computer/laptop/preset/civilian
	desc = "A low-end laptop often used for personal recreation."
	default_programs = list(/datum/computer_file/program/chatclient)

/obj/item/modular_computer/laptop/preset/civilian/rilena
	name = "RILENA:LMR laptop"
	desc = "A laptop themed around the popular combination webcomic and video game series RILENA."
	icon_state = "laptop-closed_rilena"
	icon_state_powered = "laptop_rilena"
	icon_state_unpowered = "laptop-off_rilena"
	icon_state_closed = "laptop-closed_rilena"
