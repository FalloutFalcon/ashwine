/obj/effect/proc_holder/spell/targeted/summon_wealth
	name = "Summon wealth"
	desc = "The reward for selling your soul."
	invocation_type = "none"
	include_user = TRUE
	range = -1
	clothes_req = FALSE
	school = "conjuration"
	charge_max = 100
	cooldown_min = 10
	action_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	action_icon_state = "moneybag"


/obj/effect/proc_holder/spell/targeted/summon_wealth/cast(list/targets, mob/user = usr)
	for(var/mob/living/carbon/C in targets)
		if(user.dropItemToGround(user.get_active_held_item()))
			var/obj/item = pick(
					new /obj/item/coin/gold(user.drop_location()),
					new /obj/item/coin/diamond(user.drop_location()),
					new /obj/item/coin/silver(user.drop_location()),
					new /obj/item/clothing/accessory/medal/gold(user.drop_location()),
					new /obj/item/stack/sheet/mineral/gold(user.drop_location()),
					new /obj/item/stack/sheet/mineral/silver(user.drop_location()),
					new /obj/item/stack/sheet/mineral/diamond(user.drop_location()),
					new /obj/item/holochip(user.drop_location(), 1000))
			C.put_in_hands(item)

/obj/effect/proc_holder/spell/targeted/view_range
	name = "Distant vision"
	desc = "The reward for selling your soul."
	invocation_type = "none"
	include_user = TRUE
	range = -1
	clothes_req = FALSE
	charge_max = 50
	cooldown_min = 10
	action_icon = 'icons/mob/actions/actions_silicon.dmi'
	action_icon_state = "camera_jump"
	var/ranges = list(7,8,9,10)

/obj/effect/proc_holder/spell/targeted/view_range/cast(list/targets, mob/user = usr)
	for(var/mob/C in targets)
		if(!C.client)
			continue
		C.client.view_size.setTo((input("Select view range:", "Range", 4) in ranges) - 7)

/obj/effect/proc_holder/spell/targeted/conjure_item/spellpacket/robeless
	clothes_req = FALSE
