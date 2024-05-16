#define SHIP_SYSTEM_PASSIVE 1
#define SHIP_SYSTEM_ACTIVE 2

/obj/machinery/ship_system
	name = "ship system"
	desc = "A system that can be installed on a ship."
	var/system_type = SHIP_SYSTEM_ACTIVE
	var/on = TRUE
	var/cooldown = 10 SECONDS
	var/last_used = 0

/obj/machinery/ship_system/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	port.ship_systems |= WEAKREF(src)

/obj/machinery/ship_system/proc/trigger()
	if(!can_trigger())
		return
	last_used = world.time

/obj/machinery/ship_system/proc/can_trigger()
	if(last_used + cooldown > world.time)
		return FALSE
	return TRUE
