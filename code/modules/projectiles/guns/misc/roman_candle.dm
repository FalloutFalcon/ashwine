/obj/item/gun/ballistic/automatic/roman_candle
	name = "the gatling gun"
	icon_state = "rocketlauncher"
	desc = "A roman candle modeled after the PML-9"

	gun_firemodes = list(FIREMODE_BURST)
	default_firemode = FIREMODE_BURST
	burst_size = 100

	fire_sound = 'sound/weapons/gun/flamethrower/flamethrower_empty.ogg'
	has_safety = FALSE
	safety = FALSE

	recoil = 1
	recoil_unwielded = 2
	spread = 3
	spread_unwielded = 6

	default_ammo_type = /obj/item/ammo_box/magazine/internal/roman_candle
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/roman_candle,
	)

/obj/item/gun/ballistic/automatic/roman_candle/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	burst_delay = rand(0.1 SECONDS, 1 SECONDS)
	. = ..()

/obj/item/ammo_box/magazine/internal/roman_candle
	ammo_type = /obj/item/ammo_casing/caseless/roman_candle
	caliber = "firework"
	max_ammo = 100

/obj/item/ammo_casing/caseless/roman_candle
	name = "firework"
	projectile_type = /obj/projectile/bullet/roman_candle

/obj/projectile/bullet/roman_candle
	name = "firework"
	icon_state = "missile"
	hitsound = 'sound/weapons/flashbang.ogg'
	damage = 5
	spread = 50
	damage_type = BURN
	var/fuse

/obj/projectile/bullet/roman_candle/Initialize()
	. = ..()
	fuse = rand(3,9)

/obj/projectile/bullet/roman_candle/Move()
	. = ..()
	fuse--
	if(fuse < 0 && prob(25))
		var/turf/location = get_turf(src)
		if(location)
			new /obj/effect/particle_effect/smoke/random_color(location)

/obj/projectile/bullet/roman_candle/on_hit(atom/target, blocked = FALSE)
	..()
	if(prob(10))
		explosion(target, 0, 0, 1, 1, 0, flame_range = 1)

	return BULLET_ACT_HIT

/obj/effect/particle_effect/smoke/random_color

/obj/effect/particle_effect/smoke/random_color/Initialize()
	color = random_color()
	. = ..()

