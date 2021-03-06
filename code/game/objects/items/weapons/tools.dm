//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/* Tools!
 * Note: Multitools are /obj/item/device
 *
 * Contains:
 * 		Wrench
 * 		Screwdriver
 * 		Wirecutters
 * 		Welding Tool
 * 		Crowbar
 * 		Revolver Conversion Kit(made sense)
 */

/*
 * Wrench
 */
/obj/item/weapon/wrench
	name = "wrench"
	desc = "A wrench with common uses. Can be found in your hand."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrench"
	hitsound = "sound/weapons/smash.ogg"
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 5.0
	throwforce = 7.0
	w_class = 2.0
	m_amt = 150
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")

//we inherit a lot from wrench, so we change very little
/obj/item/weapon/wrench/socket
	name = "socket wrench"
	desc = "A wrench intended to be wrenchier than other wrenches. It's the wrenchiest."
	icon_state = "socket_wrench"
	w_class = 4.0 //big shit, to balance its power

/*
 * Screwdriver
 */
/obj/item/weapon/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwy with this."
	icon = 'icons/obj/items.dmi'
	icon_state = "screwdriver"
	hitsound = 'sound/weapons/toolhit.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	sharpness = 1
	slot_flags = SLOT_BELT
	force = 5.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	g_amt = 0
	m_amt = 75
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	attack_verb = list("stabbed")

/obj/item/weapon/screwdriver/suicide_act(mob/user)
	viewers(user) << pick("<span class='danger'>[user] is stabbing the [src.name] into \his temple! It looks like \he's trying to commit suicide.</span>", \
						"<span class='danger'>[user] is stabbing the [src.name] into \his heart! It looks like \he's trying to commit suicide.</span>")
	return(BRUTELOSS)

/obj/item/weapon/screwdriver/New()
	. = ..()

	switch(pick("red","blue","purple","brown","green","cyan","yellow"))
		if ("red")
			icon_state = "screwdriver2"
			item_state = "screwdriver"
		if ("blue")
			icon_state = "screwdriver"
			item_state = "screwdriver_blue"
		if ("purple")
			icon_state = "screwdriver3"
			item_state = "screwdriver_purple"
		if ("brown")
			icon_state = "screwdriver4"
			item_state = "screwdriver_brown"
		if ("green")
			icon_state = "screwdriver5"
			item_state = "screwdriver_green"
		if ("cyan")
			icon_state = "screwdriver6"
			item_state = "screwdriver_cyan"
		if ("yellow")
			icon_state = "screwdriver7"
			item_state = "screwdriver_yellow"

	if (prob(75))
		src.pixel_y = rand(0, 16)

/obj/item/weapon/screwdriver/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M))	return ..()
	if(user.zone_sel.selecting != "eyes" && user.zone_sel.selecting != "head")
		return ..()
	if((M_CLUMSY in user.mutations) && prob(50))
		M = user
	return eyestab(M,user)

/obj/item/weapon/screwdriver/attackby(var/obj/O)
	if(istype(O, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = O
		var/mob/M = usr
		if(ishuman(M) && !M.restrained() && !M.stat && !M.paralysis && ! M.stunned)
			if(!istype(M.loc,/turf)) return
			if(C.amount < 10)
				usr << "<span class='warning'>You need at least 10 lengths to make a bolas wire!</span>"
				return
			var/obj/item/weapon/legcuffs/bolas/cable/B = new /obj/item/weapon/legcuffs/bolas/cable(usr.loc)
			qdel(src)
			B.icon_state = "cbolas_[C._color]"
			B.cable_color = C._color
			B.screw_state = item_state
			B.screw_istate = icon_state
			M << "<span class='notice'>You wind some cable around the screwdriver handle to make a bolas wire.</span>"
			C.use(10)
		else
			usr << "<span class='warning'>You cannot do that.</span>"
	else
		..()
/*
 * Wirecutters
 */
/obj/item/weapon/wirecutters
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/items.dmi'
	icon_state = "cutters"
	hitsound = 'sound/weapons/toolhit.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	sharpness = 1
	slot_flags = SLOT_BELT
	force = 6.0
	throw_speed = 2
	throw_range = 9
	w_class = 2.0
	m_amt = 80
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("pinched", "nipped")

/obj/item/weapon/wirecutters/New()
	. = ..()

	if(prob(50))
		icon_state = "cutters-y"
		item_state = "cutters_yellow"

/obj/item/weapon/wirecutters/attack(mob/living/carbon/C as mob, mob/user as mob)
	if((C.handcuffed) && (istype(C.handcuffed, /obj/item/weapon/handcuffs/cable)))
		usr.visible_message("\The [usr] cuts \the [C]'s restraints with \the [src]!",\
		"You cut \the [C]'s restraints with \the [src]!",\
		"You hear cable being cut.")
		C.handcuffed.loc = null	//garbage collector awaaaaay
		C.handcuffed = null
		C.update_inv_handcuffed()
		return
	else
		..()
/*
 * Welding Tool
 */
/obj/item/weapon/weldingtool
	name = "welding tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	hitsound = 'sound/weapons/toolhit.ogg'
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT

	//Amount of OUCH when it's thrown
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	sharpness = 0.8
	heat_production = 3800

	//Cost to make in the autolathe
	m_amt = 70
	g_amt = 30
	w_type = RECYK_MISC
	melt_temperature = MELTPOINT_PLASTIC

	//R&D tech level
	origin_tech = "engineering=1"

	//Welding tool specific stuff
	var/welding = 0 	//Whether or not the welding tool is off(0), on(1) or currently welding(2)
	var/status = 1 		//Whether the welder is secured or unsecured (able to attach rods to it to make a flamethrower)
	var/max_fuel = 20 	//The max amount of fuel the welder can hold

/obj/item/weapon/weldingtool/suicide_act(mob/user)
	user.visible_message("<span class='danger'>[user] is burning \his face off with the [src.name]! It looks like \he's  trying to commit suicide!</span>")
	return (FIRELOSS|OXYLOSS)

/obj/item/weapon/weldingtool/New()
	. = ..()
	create_reagents(max_fuel)
	reagents.add_reagent("fuel", max_fuel)

/obj/item/weapon/weldingtool/examine(mob/user)
	..()
	user << "It contains [get_fuel()]/[src.max_fuel] units of fuel!"

/obj/item/weapon/weldingtool/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/screwdriver))
		if(welding)
			user << "<span class='warning'>Stop welding first!</span>"
			return
		status = !status
		if(status)
			user << "<span class='notice'>You resecure the welder.</span>"
		else
			user << "<span class='notice'>The welder can now be attached and modified.</span>"
		src.add_fingerprint(user)
		return

	if((!status) && (istype(W,/obj/item/stack/rods)))
		var/obj/item/stack/rods/R = W
		R.use(1)
		var/obj/item/weapon/flamethrower/F = new/obj/item/weapon/flamethrower(user.loc)
		src.loc = F
		F.weldtool = src
		if (user.client)
			user.client.screen -= src
		if (user.r_hand == src)
			user.u_equip(src)
		else
			user.u_equip(src)
		src.master = F
		src.layer = initial(src.layer)
		user.u_equip(src)
		if (user.client)
			user.client.screen -= src
		src.loc = F
		src.add_fingerprint(user)
		return

	..()
	return


/obj/item/weapon/weldingtool/process()
	switch(welding)
		//If off
		if(0)
			if(src.icon_state != "welder") //Check that the sprite is correct, if it isnt, it means toggle() was not called
				src.force = 3
				src.damtype = "brute"
				src.icon_state = "welder"
				src.hitsound = "sound/weapons/toolhit.ogg"
				src.welding = 0
			processing_objects.Remove(src)
			return
		//Welders left on now use up fuel, but lets not have them run out quite that fast
		if(1)
			if(src.icon_state != "welder1") //Check that the sprite is correct, if it isnt, it means toggle() was not called
				src.force = 15
				src.damtype = "fire"
				src.icon_state = "welder1"
				src.hitsound = "sound/weapons/welderattack.ogg"
			if(prob(5))
				remove_fuel(1)

		//If you're actually actively welding, use fuel faster.
		//Is this actually used or set anywhere? - Nodrak
		if(2)
			if(prob(75))
				remove_fuel(1)


	//I'm not sure what this does. I assume it has to do with starting fires...
	//...but it doesnt check to see if the welder is on or not.
	var/turf/location = src.loc
	if(istype(location, /mob/))
		var/mob/M = location
		if(M.l_hand == src || M.r_hand == src)
			location = get_turf(M)
	if (istype(location, /turf))
		location.hotspot_expose(700, 5,surfaces=istype(loc,/turf))


/obj/item/weapon/weldingtool/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity) return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && !src.welding)
		O.reagents.trans_to(src, max_fuel)
		user << "<span class='notice'>Welder refueled</span>"
		playsound(get_turf(src), 'sound/effects/refill.ogg', 50, 1, -6)
		return
	else if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && src.welding)
		message_admins("[key_name_admin(user)] triggered a fueltank explosion.")
		log_game("[key_name(user)] triggered a fueltank explosion.")
		user << "<span class='warning'>That was stupid of you.</span>"
		var/obj/structure/reagent_dispensers/fueltank/tank = O
		tank.explode()
		return
	if (src.welding)
		remove_fuel(1)
		var/turf/location = get_turf(user)
		if (istype(location, /turf))
			location.hotspot_expose(700, 50, 1,surfaces=1)
			if(isliving(O))
				var/mob/living/L = O
				L.IgniteMob()
	return


/obj/item/weapon/weldingtool/attack_self(mob/user as mob)
	toggle()
	return

//Returns the amount of fuel in the welder
/obj/item/weapon/weldingtool/proc/get_fuel()
	return reagents.get_reagent_amount("fuel")


//Removes fuel from the welding tool. If a mob is passed, it will perform an eyecheck on the mob. This should probably be renamed to use()
/obj/item/weapon/weldingtool/proc/remove_fuel(var/amount = 1, var/mob/M = null)
	if(!welding || !check_fuel())
		return 0
	if(get_fuel() >= amount)
		reagents.remove_reagent("fuel", amount)
		check_fuel()
		if(M)
			eyecheck(M)
		return 1
	else
		if(M)
			M << "<span class='notice'>You need more welding fuel to complete this task.</span>"
		return 0

//Returns whether or not the welding tool is currently on.
/obj/item/weapon/weldingtool/proc/isOn()
	return src.welding


/obj/item/weapon/weldingtool/is_hot()
	if(isOn())
		return heat_production
	return 0


/obj/item/weapon/weldingtool/is_sharp()
	if(isOn())
		return sharpness
	return 0

//Sets the welding state of the welding tool. If you see W.welding = 1 anywhere, please change it to W.setWelding(1)
//so that the welding tool updates accordingly
/obj/item/weapon/weldingtool/proc/setWelding(var/temp_welding)
	//If we're turning it on
	if(temp_welding > 0)
		if (remove_fuel(1))
			usr << "<span class='notice'>\The [src] switches on.</span>"
			src.force = 15
			src.damtype = "fire"
			src.icon_state = "welder1"
			processing_objects.Add(src)
		else
			usr << "<span class='notice'>Need more fuel!</span>"
			src.welding = 0
			return
	//Otherwise
	else
		usr << "<span class='notice'>\The [src] switches off.</span>"
		src.force = 3
		src.damtype = "brute"
		src.icon_state = "welder"
		src.welding = 0

//Turns off the welder if there is no more fuel (does this really need to be its own proc?)
/obj/item/weapon/weldingtool/proc/check_fuel()
	if((get_fuel() <= 0) && welding)
		toggle(1)
		return 0
	return 1


//Toggles the welder off and on
/obj/item/weapon/weldingtool/proc/toggle(var/message = 0)
	if(!status)	return
	src.welding = !( src.welding )
	if (src.welding)
		if (remove_fuel(1))
			usr << "<span class='notice'>You switch the [src] on.</span>"
			src.force = 15
			src.damtype = "fire"
			src.icon_state = "welder1"
			processing_objects.Add(src)
		else
			usr << "<span class='notice'>Need more fuel!</span>"
			src.welding = 0
			return
	else
		if(!message)
			usr << "<span class='notice'>You switch the [src] off.</span>"
		else
			usr << "<span class='notice'>\The [src] shuts off!</span>"
		src.force = 3
		src.damtype = "brute"
		src.icon_state = "welder"
		src.welding = 0

//Decides whether or not to damage a player's eyes based on what they're wearing as protection
//Note: This should probably be moved to mob
/obj/item/weapon/weldingtool/proc/eyecheck(mob/user as mob)
	if(!iscarbon(user))	return 1
	var/safety = user:eyecheck()
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/datum/organ/internal/eyes/E = H.internal_organs_by_name["eyes"]
		if(!E)
			return
		if(H.species.flags & IS_SYNTHETIC)
			return
		if(safety < 2)
			switch(safety)
				if(1)
					usr << "<span class='warning'>Your eyes sting a little.</span>"
					E.damage += rand(1, 2)
					if(E.damage > 12)
						user.eye_blurry += rand(3,6)
				if(0)
					usr << "<span class='warning'>Your eyes burn.</span>"
					E.damage += rand(2, 4)
					if(E.damage > 10)
						E.damage += rand(4,10)
				if(-1)
					usr << "<span class='warning'>Your thermals intensify the welder's glow. Your eyes itch and burn severely.</span>"
					user.eye_blurry += rand(12,20)
					E.damage += rand(12, 16)
			if(E.damage > 10 && safety < 2)
				user << "<span class='warning'>Your eyes are really starting to hurt. This can't be good for you!</span>"
			if (E.damage >= E.min_broken_damage)
				user << "<span class='warning'>You go blind!</span>"
				user.sdisabilities |= BLIND
			else if (E.damage >= E.min_bruised_damage)
				user << "<span class='warning'>You go blind!</span>"
				user.eye_blind = 5
				user.eye_blurry = 5
				user.disabilities |= NEARSIGHTED
				spawn(100)
					user.disabilities &= ~NEARSIGHTED
	return


/obj/item/weapon/weldingtool/largetank
	name = "Industrial Welding Tool"
	max_fuel = 40
	m_amt = 70
	g_amt = 60
	origin_tech = "engineering=2"

/obj/item/weapon/weldingtool/hugetank
	name = "Upgraded Welding Tool"
	max_fuel = 80
	w_class = 3.0
	m_amt = 70
	g_amt = 120
	origin_tech = "engineering=3"

/obj/item/weapon/weldingtool/experimental
	name = "Experimental Welding Tool"
	max_fuel = 40
	w_class = 3.0
	m_amt = 70
	g_amt = 120
	origin_tech = "engineering=4;plasmatech=3"
	icon_state = "ewelder"
	var/last_gen = 0



/obj/item/weapon/weldingtool/experimental/proc/fuel_gen()//Proc to make the experimental welder generate fuel, optimized as fuck -Sieve
	var/gen_amount = ((world.time-last_gen)/25)
	reagents += (gen_amount)
	if(reagents > max_fuel)
		reagents = max_fuel

/*
 * Crowbar
 */

/obj/item/weapon/crowbar
	name = "crowbar"
	desc = "Used to hit floors"
	icon = 'icons/obj/items.dmi'
	icon_state = "crowbar"
	hitsound = "sound/weapons/toolhit.ogg"
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BELT
	force = 5.0
	throwforce = 7.0
	item_state = "crowbar"
	w_class = 2.0
	m_amt = 50
	w_type = RECYK_METAL
	melt_temperature = MELTPOINT_STEEL
	origin_tech = "engineering=1"
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")

	suicide_act(mob/user)
		viewers(user) << "<span class='danger'>[user] is smashing \his head in with the [src.name]! It looks like \he's  trying to commit suicide!</span>"
		return (BRUTELOSS)

/obj/item/weapon/crowbar/red
	desc = "Rise and shine."
	icon = 'icons/obj/items.dmi'
	icon_state = "red_crowbar"
	item_state = "crowbar_red"

	suicide_act(mob/user)
		viewers(user) << "<span class='danger'>[user] is smashing \his head in with the [src.name]! It looks like \he's done waiting for half life three!</span>"
		return (BRUTELOSS)


/obj/item/weapon/weldingtool/attack(mob/M as mob, mob/user as mob)
	if(hasorgans(M))
		if(can_operate(M))
			if(do_surgery(M, user, src))
				return
		var/datum/organ/external/S = M:organs_by_name[user.zone_sel.selecting]
		if (!S) return
		if(!(S.status & ORGAN_ROBOT) || user.a_intent != I_HELP)
			return ..()
		if(S.brute_dam)
			S.heal_damage(15,0,0,1)
			if(user != M)
				user.visible_message("<span class='attack'>\The [user] patches some dents on \the [M]'s [S.display_name] with \the [src]</span>",\
				"<span class='attack'>You patch some dents on \the [M]'s [S.display_name]</span>",\
				"You hear a welder.")
			else
				user.visible_message("<span class='attack'>\The [user] patches some dents on their [S.display_name] with \the [src]</span>",\
				"<span class='attack'>You patch some dents on your [S.display_name]</span>",\
				"You hear a welder.")
		else
			user << "Nothing to fix!"
	else
		return ..()

/obj/item/weapon/conversion_kit
	name = "\improper Revolver Conversion Kit"
	desc = "A professional conversion kit used to convert any knock off revolver into the real deal capable of shooting lethal .357 rounds without the possibility of catastrophic failure"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "kit"
	flags = FPRINT
	siemens_coefficient = 1
	w_class = 2.0
	w_type = RECYK_MISC
	origin_tech = "combat=2"
	var/open = 0

	New()
		..()
		update_icon()

	update_icon()
		icon_state = "[initial(icon_state)]_[open]"

	attack_self(mob/user as mob)
		open = !open
		user << "<span class='notice'>You [open?"open" : "close"] the conversion kit.</span>"
		update_icon()
