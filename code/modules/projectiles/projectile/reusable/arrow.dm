/obj/projectile/bullet/reusable/arrow
	name = "Arrow"
	desc = "Woosh!"
	damage = 50
	range = 14
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow

/obj/projectile/bullet/reusable/arrow/wood
	name = "Wooden arrow"
	damage = 15
	ammo_type = /obj/item/ammo_casing/caseless/arrow/wood

/obj/projectile/bullet/reusable/arrow/ash
	name = "Ashen arrow"
	desc = "Fire Hardened arrow."
	damage = 25
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ash

/obj/projectile/bullet/reusable/arrow/bone //AP for ashwalkers
	name = "Bone arrow"
	desc = "An arrow made from bone and sinew."
	damage = 25
	armour_penetration = 40
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bone

/obj/projectile/bullet/reusable/arrow/bronze
	name = "Bronze arrow"
	desc = "Bronze tipped arrow"
	damage = 20
	armour_penetration = 10
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bronze

// Rebar (Rebar Crossbow)
/obj/projectile/bullet/rebar
	name = "rebar"
	icon_state = "rebar"
	damage = 30
	speed = 0.4
	armour_penetration = 10
	wound_bonus = -20
	bare_wound_bonus = 20
	embedding = list(embed_chance=60, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=2, rip_time=10)
	embed_falloff_tile = -5
	wound_falloff_tile = -2
	shrapnel_type = /obj/item/stack/rods
