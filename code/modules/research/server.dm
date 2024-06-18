/obj/machinery/rnd/server
	desc = "An old server, dont run it too hard."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "RD-server-on"
	var/datum/techweb/stored_research
	var/datum/network/connected_network

/obj/machinery/rnd/server/Initialize()
	. = ..()
	if (circuit)
		return
	circuit = new /obj/item/circuitboard/machine/rdserver() // For servers on maps
	circuit.apply_default_parts(src)
	create_research_server()

/obj/machinery/rnd/server/on_construction()
	. = ..()
	create_research_server()

/obj/machinery/rnd/server/proc/create_research_server()
	var/obj/item/circuitboard/machine/rdserver/board = circuit
	name = "\improper [board.server_id] server"
	SSresearch.servers |= src
	stored_research = new(board.server_id)

/obj/machinery/rnd/server/Destroy()
	SSresearch.servers -= src
	return ..()

/obj/machinery/rnd/server/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/multitool/multi = I
	multi.buffer = src
	to_chat(user, span_notice("[src] stored in [I]."))
	return TRUE

/datum/network
	var/id
	var/list/connected_devices = list()

/datum/network/New(new_id)
	id = new_id

/datum/network/proc/connect_device(device)
	connected_devices |= device
	RegisterSignal(device, COSMIG_PARTENT_QDELETING, PROF_REF(disconnect_device))

/datum/network/proc/disconnect_device(device)
	connected_devices -= device
	if(!length(connected_devices))
		qdel()
