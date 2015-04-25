//oo oo ah ah
/mob/living/simple_animal/gorilla
	name = "Space Gorilla"
	desc = "A space gorilla."
	icon_state = "spacegoriilla"
	icon_living = "spacegorilla"
	icon_dead = "deadgorilla"
	gender = MALE
	speak = list("OOH OOH AH AH!", "BANANA")
	speak_emote = list("chimpers")
	emote_hear = list("chimpers", "grunts")
	emote_see = list("pounds his chest", "grunts OOH OOH AH AH")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	species = /mob/living/simple_animal/gorilla
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pats"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"


/mob/living/simple_animal/gorilla/Gorillionaire
	name = "Gorilla Gorillionaire"
	desc = "A sentient gorilla who has made gorillions of dollars, known to be the richest being in the entire universe. Has bought the Milky Way Galaxy and runs his own gameshow, Who wants to be a gorillionaire?"
	icon_state = "gorillionaire"
	icon_living = "gorillionaire"
	icon_dead = "deadgorilla"
	gender = MALE
	speak = list("I'm the king of the jungle baby, wanna be my queen?", "Ooh ooh ah ah! I got dollas!", "I got Gorillions more of where that came from")