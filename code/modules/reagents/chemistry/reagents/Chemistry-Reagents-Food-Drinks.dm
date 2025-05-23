/* Food */


/datum/reagent/nutriment/glucose
	name = "Glucose"
	id = "glucose"
	taste_description = "sweetness"
	color = "#FFFFFF"

	injectable = 1

/datum/reagent/nutriment/protein // Bad for Skrell!
	name = "animal protein"
	id = "protein"
	taste_description = "some sort of meat"
	color = "#440000"

/datum/reagent/nutriment/protein/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	switch(alien)
		if(IS_SKRELL)
			M.adjustToxLoss(0.5 * removed)
		if(IS_TESHARI)
			..(M, alien, removed*1.2) // Teshari get a bit more nutrition from meat.
		if(IS_UNATHI)
			..(M, alien, removed*2.25) //Unathi get most of their nutrition from meat.
		if(IS_CHIMERA)
			..(M, alien, removed*4) //Xenochimera are obligate carnivores.
		else
			..()

/datum/reagent/nutriment/protein/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien && alien == IS_SKRELL)
		M.adjustToxLoss(2 * removed)
		return
	..()

/datum/reagent/nutriment/protein/egg // Also bad for skrell.
	name = "egg yolk"
	id = "egg"
	taste_description = "egg"
	color = "#FFFFAA"

/datum/reagent/nutriment/protein/murk
	name = "murkfin protein"
	id = "murk_protein"
	taste_description = "mud"
	color = "#664330"

/datum/reagent/nutriment/honey
	name = "Honey"
	id = "honey"
	description = "A golden yellow syrup, loaded with sugary sweetness."
	taste_description = "sweetness"
	nutriment_factor = 10
	color = "#FFFF00"

/datum/reagent/nutriment/honey/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

	var/effective_dose = metabolism.total_processed_dose

	if(alien == IS_UNATHI)
		if(effective_dose < 2)
			if(effective_dose == metabolism_rate * 2 || prob(5))
				M.emote("yawn")
		else if(effective_dose < 5)
			M.eye_blurry = max(M.eye_blurry, 10)
		else if(effective_dose < 20)
			if(prob(50))
				M.afflict_paralyze(20 * 2)
			M.drowsyness = max(M.drowsyness, 20)
		else
			M.afflict_sleeping(20 * 20)
			M.drowsyness = max(M.drowsyness, 60)

/datum/reagent/nutriment/mayo
	name = "mayonnaise"
	id = "mayo"
	description = "A thick, savory sauce."
	taste_description = "unmistakably mayonnaise"
	nutriment_factor = 10
	color = "#FFFFFF"

/datum/reagent/nutriment/flour
	name = "Flour"
	id = "flour"
	description = "This is what you rub all over yourself to pretend to be a ghost."
	taste_description = "chalky wheat"
	reagent_state = REAGENT_SOLID
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/nutriment/flour/on_touch_turf(turf/target, remaining, allocated, data)
	. = ..()
	var/turf/T = target
	if(!istype(T, /turf/space))
		new /obj/effect/debris/cleanable/flour(T)

/datum/reagent/nutriment/flour/vitapaste
	name = "NutriFlour"
	id = "nutriflour"
	description = "A nutritionally-fortified flour compound. It tastes like worse flour."
	taste_description = "weird chalky wheat"
	nutriment_factor = 20

/datum/reagent/nutriment/coffee
	name = "Coffee Powder"
	id = "coffeepowder"
	description = "A bitter powder made by grinding coffee beans."
	taste_description = "bitterness"
	taste_mult = 1.3
	nutriment_factor = 1
	color = "#482000"

/datum/reagent/nutriment/tea
	name = "Tea Powder"
	id = "teapowder"
	description = "A dark, tart powder made from black tea leaves."
	taste_description = "tartness"
	taste_mult = 1.3
	nutriment_factor = 1
	color = "#101000"

/datum/reagent/nutriment/coco
	name = "Coco Powder"
	id = "coco"
	description = "A fatty, bitter paste made from coco beans."
	taste_description = "bitterness"
	taste_mult = 1.3
	reagent_state = REAGENT_SOLID
	nutriment_factor = 5
	color = "#302000"

/datum/reagent/nutriment/instantjuice
	name = "Juice Powder"
	id = "instantjuice"
	description = "Dehydrated, powdered juice of some kind."
	taste_mult = 1.3
	nutriment_factor = 1

/datum/reagent/nutriment/instantjuice/grape
	name = "Grape Juice Powder"
	id = "instantgrape"
	description = "Dehydrated, powdered grape juice."
	taste_description = "dry grapes"
	color = "#863333"

/datum/reagent/nutriment/instantjuice/orange
	name = "Orange Juice Powder"
	id = "instantorange"
	description = "Dehydrated, powdered orange juice."
	taste_description = "dry oranges"
	color = "#e78108"

/datum/reagent/nutriment/instantjuice/watermelon
	name = "Watermelon Juice Powder"
	id = "instantwatermelon"
	description = "Dehydrated, powdered watermelon juice."
	taste_description = "dry sweet watermelon"
	color = "#b83333"

/datum/reagent/nutriment/instantjuice/apple
	name = "Apple Juice Powder"
	id = "instantapple"
	description = "Dehydrated, powdered apple juice."
	taste_description = "dry sweet apples"
	color = "#c07c40"

/datum/reagent/nutriment/soysauce
	name = "Soysauce"
	id = "soysauce"
	description = "A salty sauce made from the soy plant."
	taste_description = "umami"
	taste_mult = 1.1
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 2
	color = "#792300"

/datum/reagent/nutriment/ketchup
	name = "Ketchup"
	id = "ketchup"
	description = "Ketchup, catsup, whatever. It's tomato paste."
	taste_description = "ketchup"
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 5
	color = "#731008"

/datum/reagent/nutriment/rice
	name = "Rice"
	id = "rice"
	description = "Enjoy the great taste of nothing."
	taste_description = "rice"
	taste_mult = 0.4
	reagent_state = REAGENT_SOLID
	nutriment_factor = 1
	color = "#FFFFFF"

/datum/reagent/nutriment/cherryjelly
	name = "Cherry Jelly"
	id = "cherryjelly"
	description = "Totally the best. Only to be spread on foods with excellent lateral symmetry."
	taste_description = "cherry"
	taste_mult = 1.3
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 1
	color = "#801E28"

/datum/reagent/nutriment/peanutoil
	name = "Peanut Oil"
	id = "peanutoil"
	description = "An oil derived from various types of nuts."
	taste_description = "nuts"
	taste_mult = 0.3
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 15
	color = "#4F3500"

// todo: reagent effects
/datum/reagent/nutriment/peanutoil/on_touch_turf(turf/target, remaining, allocated, data)
	. = ..()
	if(allocated >= 5)
		if(istype(target, /turf/simulated))
			var/turf/simulated/sim_target = target
			sim_target.wet_floor()
		. = max(., 5)

/datum/reagent/nutriment/peanutbutter
	name = "Peanut Butter"
	id = "peanutbutter"
	description = "A butter derived from various types of nuts."
	taste_description = "peanuts"
	taste_mult = 0.5
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 30
	color = "#4F3500"

/datum/reagent/nutriment/vanilla
	name = "Vanilla Extract"
	id = "vanilla"
	description = "Vanilla extract. Tastes suspiciously like boring ice-cream."
	taste_description = "vanilla"
	taste_mult = 5
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 2
	color = "#0F0A00"

/datum/reagent/nutriment/durian
	name = "Durian Paste"
	id = "durianpaste"
	description = "A strangely sweet and savory paste."
	taste_description = "sweet and savory"
	color = "#757631"

	glass_name = "durian paste"
	glass_desc = "Durian paste. It smells horrific."

/datum/reagent/nutriment/durian/on_touch_mob(mob/target, remaining, allocated, data, zone)
	. = ..()
	if(!target.isSynthetic())
		var/message = pick("Oh god, it smells disgusting here.", "What is that stench?", "That's an awful odor.")
		to_chat(target, "<span class='alien'>[message]</span>")
		if(prob(clamp(allocated, 5, 90)))
			if(iscarbon(target))
				var/mob/living/carbon/living_target = target
				living_target.vomit()

/datum/reagent/nutriment/durian/on_touch_turf(turf/target, remaining, allocated, data)
	var/obj/effect/debris/cleanable/chemcoating/C = new /obj/effect/debris/cleanable/chemcoating(target)
	var/amount_used = C.reagents.add_reagent(id, allocated)
	allocated -= amount_used
	return ..() + amount_used

/datum/reagent/nutriment/virus_food
	name = "Virus Food"
	id = "virusfood"
	description = "A mixture of water, milk, and oxygen. Virus cells can use this mixture to reproduce."
	taste_description = "vomit"
	taste_mult = 2
	reagent_state = REAGENT_LIQUID
	nutriment_factor = 2
	color = "#899613"

/datum/reagent/nutriment/sprinkles
	name = "Sprinkles"
	id = "sprinkles"
	description = "Multi-colored little bits of sugar, commonly found on donuts. Loved by cops."
	taste_description = "sugar"
	nutriment_factor = 1
	color = "#FF00FF"

/datum/reagent/nutriment/mint
	name = "Mint"
	id = "mint"
	description = "Also known as Mentha."
	taste_description = "mint"
	reagent_state = REAGENT_LIQUID
	color = "#CF3600"

/datum/reagent/nutriment/taropowder
	name = "Taro Powder"
	id = "taropowder"
	description = "A sweet starchy powder made by grinding taro root."
	taste_description = "sweet purpo"
	taste_mult = 1.3
	nutriment_factor = 1
	color = "#a17d92"

/datum/reagent/nutriment/matchapowder
	name = "Matcha Powder"
	id = "matchapowder"
	description = "An aromatic green tea powder."
	taste_description = "grassy green"
	taste_mult = 1.3
	nutriment_factor = 1
	color = "#05703e"

/datum/reagent/lipozine // The anti-nutriment.
	name = "Lipozine"
	id = "lipozine"
	description = "A chemical compound that causes a powerful fat-burning reaction."
	taste_description = "mothballs"
	reagent_state = REAGENT_LIQUID
	color = "#BBEDA4"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/lipozine/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	M.nutrition = max(M.nutrition - 10 * removed, 0)
	M.overeatduration = 0
	if(M.nutrition < 0)
		M.nutrition = 0

/* Non-food stuff like condiments */

/datum/reagent/sodiumchloride
	name = "Table Salt"
	id = "sodiumchloride"
	description = "A salt made of sodium chloride. Commonly used to season food."
	taste_description = "salt"
	reagent_state = REAGENT_SOLID
	color = "#FFFFFF"
	overdose = REAGENTS_OVERDOSE
	ingest_met = REM

/datum/reagent/sodiumchloride/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		M.adjustFireLoss(removed)

/datum/reagent/sodiumchloride/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	var/pass_mod = rand(3,5)
	var/passthrough = (removed - (removed/pass_mod)) //Some may be nullified during consumption, between one third and one fifth.
	legacy_affect_blood(M, alien, passthrough, metabolism)

/datum/reagent/blackpepper
	name = "Black Pepper"
	id = "blackpepper"
	description = "A powder ground from peppercorns. *AAAACHOOO*"
	taste_description = "pepper"
	reagent_state = REAGENT_SOLID
	ingest_met = REM
	color = "#000000"

/datum/reagent/enzyme
	name = "Universal Enzyme"
	id = "enzyme"
	description = "A universal enzyme used in the preperation of certain chemicals and foods."
	taste_description = "sweetness"
	taste_mult = 0.7
	reagent_state = REAGENT_LIQUID
	color = "#365E30"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/frostoil
	name = "Frost Oil"
	id = "frostoil"
	description = "A special oil that noticably chills the body. Extracted from Ice Peppers."
	taste_description = "mint"
	taste_mult = 1.5
	reagent_state = REAGENT_LIQUID
	ingest_met = REM
	color = "#B31008"

/datum/reagent/frostoil/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	M.bodytemperature = max(M.bodytemperature - 10 * TEMPERATURE_DAMAGE_COEFFICIENT, 215)
	if(prob(1))
		M.emote("shiver")
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/capsaicin, 5)

/datum/reagent/frostoil/cryotoxin //A longer lasting version of frost oil.
	name = "Cryotoxin"
	id = "cryotoxin"
	description = "Lowers the body's internal temperature."
	reagent_state = REAGENT_LIQUID
	color = "#B31008"
	metabolism_rate = REM * 0.5

/datum/reagent/capsaicin
	name = "Capsaicin Oil"
	id = "capsaicin"
	description = "This is what makes chilis hot."
	taste_description = "hot peppers"
	taste_mult = 1.5
	reagent_state = REAGENT_LIQUID
	ingest_met = REM
	color = "#B31008"

/datum/reagent/capsaicin/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(0.5 * removed)

/datum/reagent/capsaicin/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	if(alien == IS_NARAMADI)
		return
	if(alien == IS_UNATHI)
		return
	if(alien == IS_ALRAUNE) //cit change: it wouldn't affect plants that much.
		M.bodytemperature += rand(10, 25)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return

	if(metabolism.total_processed_dose < 5 && (metabolism.cycles_so_far == 1 || prob(5)))
		to_chat(M, "<span class='danger'>Your insides feel uncomfortably hot!</span>")
	if(metabolism.total_processed_dose >= 5)
		M.apply_effect(2, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/frostoil, 5)

/datum/reagent/hexaisin
	name = "Hexaisin"
	id = "hexaisin"
	description = "A common chemical found in various plant life in the Moghes regions."
	taste_description = "pleasant fire"
	taste_mult = 1.5
	reagent_state = REAGENT_LIQUID
	ingest_met = REM
	color = "#B31008"

/datum/reagent/hexaisin/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_UNATHI)
		return
	if(alien == IS_NARAMADI)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
	if(metabolism.cycles_so_far == 1)
		to_chat(M, "<span class='danger'>You feel like your insides are burning!</span>")
	else
		M.apply_effect(3, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/frostoil, 5)

/datum/reagent/condensedcapsaicin
	name = "Condensed Capsaicin"
	id = "condensedcapsaicin"
	description = "A chemical agent used for self-defense and in police work."
	taste_description = "fire"
	taste_mult = 10
	reagent_state = REAGENT_LIQUID
	touch_met = 50 // Get rid of it quickly
	ingest_met = REM
	color = "#B31008"

/datum/reagent/condensedcapsaicin/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(0.5 * removed)

/datum/reagent/condensedcapsaicin/legacy_affect_touch(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	var/eyes_covered = 0
	var/mouth_covered = 0

	var/head_covered = 0
	var/arms_covered = 0 //These are used for the effects on slime-based species.
	var/legs_covered = 0
	var/hands_covered = 0
	var/feet_covered = 0
	var/chest_covered = 0
	var/groin_covered = 0

	var/obj/item/safe_thing = null

	var/effective_strength = 5

	if(alien == IS_SKRELL)	//Larger eyes means bigger targets.
		effective_strength = 8

	if(alien == IS_ALRAUNE) //cit change: plants find the base form tasty, still mildly inconvenient to be affected by this.
		effective_strength = 4

	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
		if(!H.internal_organs_by_name[O_EYES])
			eyes_covered = TRUE
			safe_thing = "Lack of eyes"
		if(H.head)
			if(H.head.body_cover_flags & EYES)
				eyes_covered = 1
				safe_thing = H.head
			if((H.head.body_cover_flags & FACE) && !(H.head.clothing_flags & FLEXIBLEMATERIAL))
				mouth_covered = 1
				safe_thing = H.head
		if(H.wear_mask)
			if(!eyes_covered && H.wear_mask.body_cover_flags & EYES)
				eyes_covered = 1
				safe_thing = H.wear_mask
			if(!mouth_covered && (H.wear_mask.body_cover_flags & FACE) && !(H.wear_mask.clothing_flags & FLEXIBLEMATERIAL))
				mouth_covered = 1
				safe_thing = H.wear_mask
		if(H.glasses && H.glasses.body_cover_flags & EYES)
			if(!eyes_covered)
				eyes_covered = 1
				if(!safe_thing)
					safe_thing = H.glasses
		if(alien == IS_SLIME)
			for(var/obj/item/clothing/C in H.get_equipped_items())
				if(C.body_cover_flags & HEAD)
					head_covered = 1
				if(C.body_cover_flags & UPPER_TORSO)
					chest_covered = 1
				if(C.body_cover_flags & LOWER_TORSO)
					groin_covered = 1
				if(C.body_cover_flags & LEGS)
					legs_covered = 1
				if(C.body_cover_flags & ARMS)
					arms_covered = 1
				if(C.body_cover_flags & HANDS)
					hands_covered = 1
				if(C.body_cover_flags & FEET)
					feet_covered = 1
				if(head_covered && chest_covered && groin_covered && legs_covered && arms_covered && hands_covered && feet_covered)
					break
	if(eyes_covered && mouth_covered)
		to_chat(M, "<span class='warning'>Your [safe_thing] protects you from the pepperspray!</span>")
		if(alien != IS_SLIME)
			return
	else if(eyes_covered)
		to_chat(M, "<span class='warning'>Your [safe_thing] protects you from most of the pepperspray!</span>")
		M.eye_blurry = max(M.eye_blurry, effective_strength * 3)
		M.apply_status_effect(/datum/status_effect/sight/blindness, effective_strength )
		M.afflict_stun(20 * 5)
		M.afflict_paralyze(20 * 5)
		if(alien != IS_SLIME)
			return
	else if(mouth_covered) // Mouth cover is better than eye cover
		to_chat(M, "<span class='warning'>Your [safe_thing] protects your face from the pepperspray!</span>")
		M.eye_blurry = max(M.eye_blurry, effective_strength)
		if(alien != IS_SLIME)
			return
	else// Oh dear :D
		to_chat(M, "<span class='warning'>You're sprayed directly in the eyes with pepperspray!</span>")
		M.eye_blurry = max(M.eye_blurry, effective_strength * 5)
		M.apply_status_effect(/datum/status_effect/sight/blindness, effective_strength * 2 )
		M.afflict_stun(20 * 5)
		M.afflict_paralyze(20 * 5)
		if(alien != IS_SLIME)
			return
	if(alien == IS_SLIME)
		if(!head_covered)
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your head burns!</span>")
			M.apply_effect(5 * effective_strength, AGONY, 0)
		if(!chest_covered)
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your chest burns!</span>")
			M.apply_effect(5 * effective_strength, AGONY, 0)
		if(!groin_covered && prob(75))
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your groin burns!</span>")
			M.apply_effect(3 * effective_strength, AGONY, 0)
		if(!arms_covered && prob(45))
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your arms burns!</span>")
			M.apply_effect(3 * effective_strength, AGONY, 0)
		if(!legs_covered && prob(45))
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your legs burns!</span>")
			M.apply_effect(3 * effective_strength, AGONY, 0)
		if(!hands_covered && prob(20))
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your hands burns!</span>")
			M.apply_effect(effective_strength / 2, AGONY, 0)
		if(!feet_covered && prob(20))
			if(prob(33))
				to_chat(M, "<span class='warning'>The exposed flesh on your feet burns!</span>")
			M.apply_effect(effective_strength / 2, AGONY, 0)

/datum/reagent/condensedcapsaicin/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_NARAMADI) //Moghes species with exception of Zaddat (for obvious reasons) are immune to taste and ingested effects of Capsaisin and Condensed variants.
		return
	if(alien == IS_UNATHI) //If you want to know why, look at Hexaisin. They are still affected by pepperspray, but not drinking it.
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
	if(metabolism.cycles_so_far == 1)
		to_chat(M, "<span class='danger'>You feel like your insides are burning!</span>")
	else
		M.apply_effect(4, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/frostoil, 5)

/* Drinks */

/datum/reagent/drink
	name = "Drink"
	id = "drink"
	description = "Uh, some kind of drink."
	ingest_met = REM
	reagent_state = REAGENT_LIQUID
	color = "#E78108"
	var/nutrition = 0 // Per unit
	var/hydration = 6 //Per unit
	var/adj_dizzy = 0 // Per tick
	var/adj_drowsy = 0
	var/adj_sleepy = 0
	var/adj_temp = 0
	var/water_based = TRUE

/datum/reagent/drink/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	var/strength_mod = 1
	if(alien == IS_SLIME && water_based)
		strength_mod = 3
	M.adjustToxLoss(removed * strength_mod) // Probably not a good idea; not very deadly though
	return

/datum/reagent/drink/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	M.adjust_nutrition(nutrition * removed)
	M.adjust_hydration(hydration * removed)
	M.dizziness = max(0, M.dizziness + adj_dizzy)
	M.drowsyness = max(0, M.drowsyness + adj_drowsy)
	M.adjust_sleeping(20 * adj_sleepy)

	if(adj_temp > 0 && M.bodytemperature < 310) // 310 is the normal bodytemp. 310.055
		M.bodytemperature = min(310, M.bodytemperature + (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))
	if(adj_temp < 0 && M.bodytemperature > 310)
		M.bodytemperature = min(310, M.bodytemperature - (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))
	var/is_vampire = M.species.is_vampire
	if(is_vampire)
		handle_vampire(M, alien, removed, is_vampire)

/datum/reagent/drink/legacy_affect_overdose(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

// Juices

/datum/reagent/drink/juice/banana
	name = "Banana Juice"
	id = "banana"
	description = "The raw essence of a banana."
	taste_description = "banana"
	color = "#C3AF00"

	glass_name = "Banana Juice"
	glass_desc = "The raw essence of a banana. HONK!"

/datum/reagent/drink/juice/berry
	name = "Berry Juice"
	id = "berryjuice"
	description = "A delicious blend of several different kinds of berries."
	taste_description = "berries"
	color = "#990066"

	glass_name = "Berry Juice"
	glass_desc = "Berry juice. Or maybe it's jam. Who cares?"

/datum/reagent/drink/juice/pineapple
	name = "Pineapple Juice"
	id = "pineapplejuice"
	description = "A sour but refreshing juice from a pineapple."
	taste_description = "pineapple"
	color = "#C3AF00"

	glass_name = "Pineapple Juice"
	glass_desc = "Pineapple juice. Or maybe it's spineapple. Who cares?"

/datum/reagent/drink/juice/carrot
	name = "Carrot juice"
	id = "carrotjuice"
	description = "It is just like a carrot but without crunching."
	taste_description = "carrots"
	color = "#FF8C00" // rgb: 255, 140, 0

	glass_name = "Carrot Juice"
	glass_desc = "It is just like a carrot but without crunching."

/datum/reagent/drink/juice/carrot/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	M.reagents.add_reagent("imidazoline", removed * 0.2)

/datum/reagent/drink/juice
	name = "Grape Juice"
	id = "grapejuice"
	description = "It's grrrrrape!"
	taste_description = "grapes"
	nutrition=1 // also applies to all of the other juices

	color = "#863333"

	glass_name = "Grape Juice"
	glass_desc = "It's grrrrrape!"

/datum/reagent/drink/juice/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

	var/effective_dose = metabolism.total_processed_dose

	if(alien == IS_UNATHI)
		if(effective_dose < 2)
			if(effective_dose == metabolism_rate * 2 || prob(5))
				M.emote("yawn")
		else if(effective_dose < 5)
			M.eye_blurry = max(M.eye_blurry, 10)
		else if(effective_dose < 20)
			if(prob(50))
				M.afflict_paralyze(20 * 2)
			M.drowsyness = max(M.drowsyness, 20)
		else
			M.afflict_sleeping(20 * 20)
			M.drowsyness = max(M.drowsyness, 60)

/datum/reagent/drink/juice/lemon
	name = "Lemon Juice"
	id = "lemonjuice"
	description = "This juice is VERY sour."
	taste_description = "sourness"
	taste_mult = 1.1
	color = "#AFAF00"

	glass_name = "Lemon Juice"
	glass_desc = "Sour..."

/datum/reagent/drink/juice/apple
	name = "Apple Juice"
	id = "applejuice"
	description = "The most basic juice."
	taste_description = "crispness"
	taste_mult = 1.1
	color = "#E2A55F"

	glass_name = "Apple Juice"
	glass_desc = "An earth favorite."

/datum/reagent/drink/juice/lime
	name = "Lime Juice"
	id = "limejuice"
	description = "The sweet-sour juice of limes."
	taste_description = "sourness"
	taste_mult = 1.8
	color = "#365E30"

	glass_name = "Lime Juice"
	glass_desc = "A glass of sweet-sour lime juice"

/datum/reagent/drink/juice/lime/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(-0.5 * removed)

/datum/reagent/drink/juice/orange
	name = "Orange juice"
	id = "orangejuice"
	description = "Both delicious AND rich in Vitamin C, what more do you need?"
	taste_description = "oranges"
	color = "#E78108"

	glass_name = "orange juice"
	glass_desc = "Vitamins! Yay!"

/datum/reagent/drink/juice/orange/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.adjustOxyLoss(-2 * removed)

/datum/reagent/toxin/poisonberryjuice // It has more in common with toxins than drinks... but it's a juice
	name = "Poison Berry Juice"
	id = "poisonberryjuice"
	description = "A tasty juice blended from various kinds of very deadly and toxic berries."
	taste_description = "berries"
	color = "#863353"
	strength = 5

	glass_name = "Poison Berry Juice"
	glass_desc = "A glass of deadly juice."

/datum/reagent/drink/juice/potato
	name = "Potato Juice"
	id = "potatojuice"
	description = "Juice of the potato. Bleh."
	taste_description = "potatoes"
	nutrition = 2

	color = "#302000"

	glass_name = "Potato Juice"
	glass_desc = "Juice from a potato. Bleh."

/datum/reagent/drink/juice/tomato
	name = "Tomato Juice"
	id = "tomatojuice"
	description = "Tomatoes made into juice. What a waste of big, juicy tomatoes, huh?"
	taste_description = "tomatoes"
	color = "#731008"

	glass_name = "Tomato Juice"
	glass_desc = "Are you sure this is tomato juice?"

/datum/reagent/drink/juice/tomato/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.heal_organ_damage(0, 0.5 * removed)

/datum/reagent/drink/juice/watermelon
	name = "Watermelon Juice"
	id = "watermelonjuice"
	description = "Delicious juice made from watermelon."
	taste_description = "sweet watermelon"
	color = "#B83333"

	glass_name = "Watermelon Juice"
	glass_desc = "Delicious juice made from watermelon."

/datum/reagent/drink/juice/eroot
	name = "Earthen-Root Juice"
	id = "eroot"
	description = "Juice extracted from earthen-root, a plant native to Adhomai."
	color = "#4D8F53"
	taste_description = "sweetness"

	glass_icon_state = "bluelagoon"
	glass_name = "glass of earthen-root juice"
	glass_desc = "Juice extracted from earthen-root, a plant native to Adhomai."

/datum/reagent/drink/juice/kompot_taj
	name = "Adhomai Kompot"
	id = "kompot_taj"
	description = "Also known as Ashomar'darr Adhomai, this traditional beverage made from boiling Adhomai Holly in water."
	color = "#a51919"
	taste_description = "a bitter sweet fruitiness"

	glass_icon_state = "berryjuice"
	glass_name = "glass of Adhomai Kompot"
	glass_desc = "A beverage made by boiling berries native to Adhomai in water."


// Everything else

/datum/reagent/drink/milk
	name = "Milk"
	id = "milk"
	description = "An opaque white liquid produced by the mammary glands of mammals."
	taste_description = "milk"
	color = "#DFDFDF"
	var/contains_lactose = TRUE
	nutrition=5

	glass_name = "Milk"
	glass_desc = "White and nutritious goodness!"

	cup_icon_state = "cup_cream"
	cup_name = "Cup of Milk"
	cup_desc = "White and nutritious goodness!"

/datum/reagent/drink/milk/evaporated
	name = "Evaporated Milk"
	id = "evapmilk"
	description = "Milk with much of its water boiled away. Has far beter shelf life then regular milk."
	taste_description = "milk"
	color = "#f7f8d2"
	nutrition=5

	glass_name = "Evaporate Milk"
	glass_desc = "Thick, Creamy, White, and nutritious goodness!"

	cup_icon_state = "cup_cream"
	cup_name = "Cup of Evaporated Milk"
	cup_desc = "Thick, Creamy, White, and nutritious goodness!"

/datum/reagent/drink/milk/chocolate
	name =  "Chocolate Milk"
	id = "chocolate_milk"
	description = "A delicious mixture of perfectly healthy mix and terrible chocolate."
	taste_description = "chocolate milk"
	color = "#74533b"
	cup_icon_state = "cup_brown"
	cup_name = "Cup of Chocolate Milk"
	cup_desc = "Deliciously fattening!"

	glass_name = "Chocolate Milk"
	glass_desc = "Deliciously fattening!"

/datum/reagent/drink/milk/chocolate/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_ALRAUNE) //cit change: choccy is full of natural easily digestible plant fats
		M.nutrition += removed * 5

/datum/reagent/drink/milk/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	if(alien == IS_ALRAUNE) //cit change: milk good for plant.
		M.nutrition += removed * 3
	M.heal_organ_damage(0.5 * removed, 0)
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/capsaicin, 10 * removed)
	if(contains_lactose == TRUE && alien == IS_NARAMADI) //Species-wide lactose intolerance, also funny that cheeses can't drink milk.
		if(prob(5))
			to_chat(M, SPAN_WARNING("You feel nauseous!"))
			return
		if(prob(20))
			var/mob/living/L = M
			L.vomit()
	return

/datum/reagent/drink/milk/cream
	name = "Cream"
	id = "cream"
	description = "The fatty, still liquid part of milk. Why don't you mix this with sum scotch, eh?"
	taste_description = "thick milk"
	color = "#DFD7AF"
	nutrition=10

	glass_name = "Cream"
	glass_desc = "Ewwww..."

	cup_icon_state = "cup_cream"
	cup_name = "Cup of Cream"
	cup_desc = "Ewwww..."

/datum/reagent/drink/milk/soymilk
	name = "Soy Milk"
	id = "soymilk"
	description = "An opaque white liquid made from soybeans."
	taste_description = "soy milk"
	color = "#DFDFC7"
	contains_lactose = FALSE

	glass_name = "Soy Milk"
	glass_desc = "White and nutritious soy goodness!"

	cup_icon_state = "cup_cream"
	cup_name = "Cup of Milk"
	cup_desc = "White and nutritious goodness!"

/datum/reagent/drink/milk/coconutmilk
	name = "Coconut Milk"
	id = "coconutmilk"
	description = "An opaque white liquid made from the white inner flesh of a coconut."
	taste_description = "creamy coconut"
	color = "#cecece"
	contains_lactose = FALSE

	glass_name = "Coconut Milk"
	glass_desc = "An opaque white liquid made from the white inner flesh of a coconut."

	cup_icon_state = "cup_cream"
	cup_name = "Cup of Milk"
	cup_desc = "An opaque white liquid made from the white inner flesh of a coconut."

/datum/reagent/drink/tea
	name = "Tea"
	id = "tea"
	description = "Tasty black tea, it has antioxidants, it's good for you!"
	taste_description = "black tea"
	color = "#832700"
	adj_dizzy = -2
	adj_drowsy = -1
	adj_sleepy = -3
	adj_temp = 20

	glass_name = "Tea"
	glass_desc = "Tasty black tea, it has antioxidants, it's good for you!"

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Tea"
	cup_desc = "Tasty black tea, it has antioxidants, it's good for you!"

/datum/reagent/drink/tea/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(-0.5 * removed)

/datum/reagent/drink/tea/icetea
	name = "Iced Tea"
	id = "icetea"
	description = "No relation to a certain rap artist/ actor."
	taste_description = "sweet tea"
	color = "#AC7F24" // rgb: 16, 64, 56
	adj_temp = -5

	glass_name = "Iced Tea"
	glass_desc = "No relation to a certain rap artist/ actor."
	glass_special = list(DRINK_ICE)

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Iced Tea"
	cup_desc = "No relation to a certain rap artist/ actor."

/datum/reagent/drink/tea/icetea/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= 0.5
		if(M.bodytemperature < T0C)
			M.bodytemperature += 0.5

/datum/reagent/drink/tea/icetea/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= 0.5
		if(M.bodytemperature < T0C)
			M.bodytemperature += 0.5

/datum/reagent/drink/tea/minttea
	name = "Mint Tea"
	id = "minttea"
	description = "A tasty mixture of mint and tea. It's apparently good for you!"
	color = "#A8442C"
	taste_description = "black tea with tones of mint"

	glass_name = "Mint Tea"
	glass_desc = "A tasty mixture of mint and tea. It's apparently good for you!"

	cup_name = "Cup of Mint Tea"
	cup_desc = "A tasty mixture of mint and tea. It's apparently good for you!"

/datum/reagent/drink/tea/lemontea
	name = "Lemon Tea"
	id = "lemontea"
	description = "A tasty mixture of lemon and tea. It's apparently good for you!"
	color = "#FC6A00"
	taste_description = "black tea with tones of lemon"
	nutrition=1

	glass_name = "Lemon Tea"
	glass_desc = "A tasty mixture of lemon and tea. It's apparently good for you!"

	cup_name = "Cup of Lemon Tea"
	cup_desc = "A tasty mixture of lemon and tea. It's apparently good for you!"

/datum/reagent/drink/tea/limetea
	name = "Lime Tea"
	id = "limetea"
	description = "A tasty mixture of lime and tea. It's apparently good for you!"
	color = "#DE4300"
	taste_description = "black tea with tones of lime"
	nutrition=1

	glass_name = "Lime Tea"
	glass_desc = "A tasty mixture of lime and tea. It's apparently good for you!"

	cup_name = "Cup of Lime Tea"
	cup_desc = "A tasty mixture of lime and tea. It's apparently good for you!"

/datum/reagent/drink/tea/orangetea
	name = "Orange Tea"
	id = "orangetea"
	description = "A tasty mixture of orange and tea. It's apparently good for you!"
	color = "#FB4F06"
	taste_description = "black tea with tones of orange"
	nutrition=1

	glass_name = "Orange Tea"
	glass_desc = "A tasty mixture of orange and tea. It's apparently good for you!"

	cup_name = "Cup of Orange Tea"
	cup_desc = "A tasty mixture of orange and tea. It's apparently good for you!"

/datum/reagent/drink/tea/berrytea
	name = "Berry Tea"
	id = "berrytea"
	description = "A tasty mixture of berries and tea. It's apparently good for you!"
	color = "#A60735"
	taste_description = "black tea with tones of berries"
	nutrition=1

	glass_name = "Berry Tea"
	glass_desc = "A tasty mixture of berries and tea. It's apparently good for you!"

	cup_name = "Cup of Berry Tea"
	cup_desc = "A tasty mixture of berries and tea. It's apparently good for you!"

/datum/reagent/drink/tea/icetea/milktea
	name = "Milk Tea"
	id = "milktea"
	description = "Sweet iced tea cut with milk."
	taste_description = "sweet, silky smooth tea"
	color = "#ffffff"
	nutrition=3

	glass_name = "Milk Tea"
	glass_desc = "Sweet iced tea cut with milk."

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Milk Tea"
	cup_desc = "Sweet iced tea cut with milk."

/datum/reagent/drink/tea/icetea/milktea/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)	//Milk tea and its variants inherit the properties of both iced tea and milk.
	..()
	if(alien == IS_DIONA)
		return
	if(alien == IS_ALRAUNE) //cit change: milk good for plant.
		M.nutrition += removed * 3
	M.heal_organ_damage(0.5 * removed, 0)
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/capsaicin, 10 * removed)

/datum/reagent/drink/tea/icetea/milktea/honeybubbletea
	name = "Honey Bubble Tea"
	id = "honeybubbletea"
	description = "Chilled milk tea with chewy tapioca pearls and a spoonful of honey."
	taste_description = "sweet, silky smooth tea and notes of honey"
	color = "#ffffff"
	nutrition=5

	glass_name = "Honey Bubble Tea"
	glass_desc = "Chilled milk tea with chewy tapioca pearls and a spoonful of honey."

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Honey Bubble Tea"
	cup_desc = "Chilled milk tea with chewy tapioca pearls and a spoonful of honey."

/datum/reagent/drink/tea/icetea/milktea/matchabubbletea
	name = "Matcha Bubble Tea"
	id = "matchabubbletea"
	description = "Chilled milk and green tea with chewy tapioca pearls."
	taste_description = "sweet, silky smooth green tea"
	color = "#1db883"
	nutrition=5

	glass_name = "Matcha Bubble Tea"
	glass_desc = "Chilled milk and green tea with chewy tapioca pearls. It's GREEN!"

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Matcha Bubble Tea"
	cup_desc = "Chilled milk and green tea with chewy tapioca pearls. It's GREEN!"

/datum/reagent/drink/tea/icetea/milktea/tarobubbletea
	name = "Taro Bubble Tea"
	id = "tarobubbletea"
	description = "Chilled milk tea with chewy tapioca pearls and taro."
	taste_description = "incredibly sweet, silky smooth tea"
	color = "#b87098"
	nutrition=5

	glass_name = "Taro Bubble Tea"
	glass_desc = "Chilled milk tea with chewy tapioca pearls and taro. It's PURPLE!"

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Taro Bubble Tea"
	cup_desc = "Chilled milk tea with chewy tapioca pearls and taro. It's PURPLE!"

/datum/reagent/drink/tea/icetea/milktea/cocoabubbletea
	name = "Chocolate Bubble Tea"
	id = "cocoabubbletea"
	description = "Chilled milk tea with chewy tapioca pearls and a spoonful of chocolate mixed in."
	taste_description = "sweet, silky smooth tea and notes of chocolate"
	color = "#754a2e"
	nutrition=5

	glass_name = "Chocolate Bubble Tea"
	glass_desc = "Chilled milk tea with chewy tapioca pearls and a spoonful of chocolate mixed in."

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Chocolate Bubble Tea"
	cup_desc = "Chilled milk tea with chewy tapioca pearls and a spoonful of chocolate mixed in."

/datum/reagent/drink/tea/icetea/milktea/mochabubbletea
	name = "Mocha Bubble Tea"
	id = "mochabubbletea"
	description = "Super sweet mix of milk, tea, coffee, and chocolate, topped off with a generous helping of whipped cream."
	taste_description = "barista's ire and sugarmilk overload"
	color = "#5c2c0c"
	nutrition=5

	glass_name = "Mocha Bubble Tea"
	glass_desc = "Super sweet mix of milk, tea, coffee, and chocolate, topped off with a generous helping of whipped cream. That seems like a lot of sugar. You're going to put that in you?"

	cup_icon_state = "cup_tea"
	cup_name = "Cup of Mocha Bubble Tea"
	cup_desc = "Super sweet mix of milk, tea, coffee, and chocolate, topped off with a generous helping of whipped cream. That seems like a lot of sugar. You're going to put that in you?"

/datum/reagent/drink/coconutwater
	name = "Coconut Water"
	id = "coconutwater"
	description = "A fresh clear liquid found within coconuts."
	taste_description = "tropical, somewhat buttery water"
	color = "#fafafa70"
	nutrition=1

	glass_name = "Coconut Water"
	glass_desc = "A fresh clear liquid found within coconuts."

/datum/reagent/drink/coffee
	name = "Coffee"
	id = "coffee"
	description = "Coffee is a brewed drink prepared from roasted seeds, commonly called coffee beans, of the coffee plant."
	taste_description = "coffee"
	taste_mult = 1.3
	color = "#482000"
	adj_dizzy = -5
	adj_drowsy = -3
	adj_sleepy = -2
	adj_temp = 25
	overdose = 45

	cup_icon_state = "cup_coffee"
	cup_name = "Cup of Coffee"
	cup_desc = "Don't drop it, or you'll send scalding liquid and ceramic shards everywhere."

	glass_name = "Coffee"
	glass_desc = "Don't drop it, or you'll send scalding liquid and glass shards everywhere."


/datum/reagent/drink/coffee/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	..()
	if(adj_temp > 0)
		metabolism.legacy_current_holder.remove_reagent(/datum/reagent/frostoil, 10 * removed)

/datum/reagent/drink/coffee/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

/datum/reagent/drink/coffee/legacy_affect_overdose(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	M.make_jittery(5)

/datum/reagent/drink/coffee/icecoffee
	name = "Iced Coffee"
	id = "icecoffee"
	description = "Coffee and ice, refreshing and cool."
	color = "#102838"
	adj_temp = -5

	glass_name = "Iced Coffee"
	glass_desc = "A drink to perk you up and refresh you!"
	glass_special = list(DRINK_ICE)

/datum/reagent/drink/coffee/icecoffee/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= 0.5
		if(M.bodytemperature < T0C)
			M.bodytemperature += 0.5

/datum/reagent/drink/coffee/icecoffee/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= 0.5
		if(M.bodytemperature < T0C)
			M.bodytemperature += 0.5

/datum/reagent/drink/coffee/soy_latte
	name = "Soy Latte"
	id = "soy_latte"
	description = "A nice and tasty beverage while you are reading your hippie books."
	taste_description = "creamy coffee"
	color = "#C65905"
	adj_temp = 5
	nutrition=1

	glass_desc = "A nice and refreshing beverage while you are reading."
	glass_name = "Soy Latte"
	glass_desc = "A nice and refrshing beverage while you are reading."

	cup_icon_state = "cup_latte"
	cup_name = "Cup of Soy Latte"
	cup_desc = "A nice and refreshing beverage while you are reading."

/datum/reagent/drink/coffee/soy_latte/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	M.heal_organ_damage(0.5 * removed, 0)

/datum/reagent/drink/coffee/cafe_latte
	name = "Cafe Latte"
	id = "cafe_latte"
	description = "A nice, strong and tasty beverage while you are reading."
	taste_description = "bitter cream"
	color = "#C65905"
	adj_temp = 5
	nutrition=1

	glass_name = "Cafe Latte"
	glass_desc = "A nice, strong and refreshing beverage while you are reading."

	cup_icon_state = "cup_latte"
	cup_name = "Cup of Cafe Latte"
	cup_desc = "A nice and refreshing beverage while you are reading."

/datum/reagent/drink/coffee/cafe_latte/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	M.heal_organ_damage(0.5 * removed, 0)

/datum/reagent/drink/hot_coco
	name = "Hot Chocolate"
	id = "hot_coco"
	description = "Made with love! And cocoa beans."
	taste_description = "creamy chocolate"
	reagent_state = REAGENT_LIQUID
	color = "#403010"
	nutrition = 2
	adj_temp = 5

	glass_name = "Hot Chocolate"
	glass_desc = "Made with love! And cocoa beans."

	cup_icon_state = "cup_coco"
	cup_name = "Cup of Hot Chocolate"
	cup_desc = "Made with love! And cocoa beans."

/datum/reagent/drink/hot_coco/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_ALRAUNE) //cit change: choccy is full of natural easily digestible plant fats
		M.nutrition += removed * 5

/datum/reagent/drink/soda/sodawater
	name = "Soda Water"
	id = "sodawater"
	description = "A can of club soda. Why not make a scotch and soda?"
	taste_description = "carbonated water"
	color = "#619494"
	adj_dizzy = -5
	adj_drowsy = -3
	adj_temp = -5

	glass_name = "Soda Water"
	glass_desc = "Soda water. Why not make a scotch and soda?"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/grapesoda
	name = "Grape Soda"
	id = "grapesoda"
	description = "Grapes made into a fine drank."
	taste_description = "grape soda"
	color = "#421C52"
	adj_drowsy = -3
	nutrition=5

	glass_name = "Grape Soda"
	glass_desc = "Looks like a delicious drink!"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/tonic
	name = "Tonic Water"
	id = "tonic"
	description = "It tastes strange but at least the quinine keeps the Space Malaria at bay."
	taste_description = "tart and fresh"
	color = "#619494"
	nutrition=1

	adj_dizzy = -5
	adj_drowsy = -3
	adj_sleepy = -2
	adj_temp = -5

	glass_name = "Tonic Water"
	glass_desc = "Quinine tastes funny, but at least it'll keep that Space Malaria away."

/datum/reagent/drink/soda/lemonade
	name = "Lemonade"
	id = "lemonade"
	description = "Oh the nostalgia..."
	taste_description = "lemonade"
	color = "#FFFF00"
	adj_temp = -5
	nutrition=3

	glass_name = "Lemonade"
	glass_desc = "Oh the nostalgia..."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/melonade
	name = "Melonade"
	id = "melonade"
	description = "Oh the.. nostalgia?"
	taste_description = "watermelon"
	color = "#FFB3BB"
	adj_temp = -5
	nutrition=3

	glass_name = "Melonade"
	glass_desc = "Oh the.. nostalgia?"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/appleade
	name = "Appleade"
	id = "appleade"
	description = "Applejuice, improved."
	taste_description = "sparkling apples"
	color = "#FFD1B3"
	adj_temp = -5
	nutrition=3

	glass_name = "Appleade"
	glass_desc = "Applejuice, improved."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/pineappleade
	name = "Pineappleade"
	id = "pineappleade"
	description = "Spineapple, juiced up."
	taste_description = "sweet`n`sour pineapples"
	color = "#FFFF00"
	adj_temp = -5
	nutrition=3

	glass_name = "Pineappleade"
	glass_desc = "Spineapple, juiced up."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/kiraspecial
	name = "Kira Special"
	id = "kiraspecial"
	description = "Long live the guy who everyone had mistaken for a girl. Baka!"
	taste_description = "fruity sweetness"
	color = "#CCCC99"
	adj_temp = -5
	nutrition=2

	glass_name = "Kira Special"
	glass_desc = "Long live the guy who everyone had mistaken for a girl. Baka!"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/brownstar
	name = "Brown Star"
	id = "brownstar"
	description = "It's not what it sounds like..."
	taste_description = "orange and cola soda"
	color = "#9F3400"
	adj_temp = -2
	nutrition=3

	glass_name = "Brown Star"
	glass_desc = "It's not what it sounds like..."

/datum/reagent/drink/soda/mintapplesparkle
	name = "Mint Apple Sparkle"
	id = "mintapplesparkle"
	description = "Delicious appleade with a touch of mint."
	taste_description = "minty apples"
	color = "#FDDA98"
	nutrition=3

	glass_name = "Mint Apple Sparkle"
	glass_desc = "Delicious appleade with a touch of mint."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/orangeale
	name = "Orange Ale"
	id = "orangeale"
	description = "A combination of orange juice and ginger ale that suprisingly works well. "
	taste_description = "sparkling orange juice in overdrive"
	color = "#e88e06"
	adj_temp = -2
	nutrition=3

	glass_name = "Orange Ale"
	glass_desc = "an overwhelmingly fizzy combination of orange juice and ginger ale."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/milkshake
	name = "Milkshake"
	id = "milkshake"
	description = "Glorious brainfreezing mixture."
	taste_description = "vanilla milkshake"
	color = "#AEE5E4"
	adj_temp = -9
	var/contains_lactose = TRUE //in place in case someone makes adds milkshakes with soymilk or coconut milk
	nutrition=10

	glass_name = "Milkshake"
	glass_desc = "Glorious brainfreezing mixture."

/datum/reagent/drink/milkshake/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

	var/effective_dose = metabolism.total_processed_dose / 2

	if(alien == IS_UNATHI)
		if(effective_dose < 2)
			if(effective_dose == metabolism_rate * 2 || prob(5))
				M.emote("yawn")
		else if(effective_dose < 5)
			M.eye_blurry = max(M.eye_blurry, 10)
		else if(effective_dose < 20)
			if(prob(50))
				M.afflict_paralyze(20 * 2)
			M.drowsyness = max(M.drowsyness, 20)
		else
			M.afflict_sleeping(20 * 20)
			M.drowsyness = max(M.drowsyness, 60)
	if(contains_lactose == TRUE && alien == IS_NARAMADI)
		if(prob(5))
			to_chat(M, SPAN_WARNING("You feel nauseous!"))
			return
		if(prob(20))
			var/mob/living/L = M
			L.vomit()
	return


/datum/reagent/drink/milkshake/chocoshake
	name = "Chocolate Milkshake"
	id = "chocoshake"
	description = "A refreshing chocolate milkshake."
	taste_description = "cold refreshing chocolate and cream"
	color = "#8e6f44" // rgb(142, 111, 68)
	adj_temp = -9
	nutrition=10

	glass_name = "Chocolate Milkshake"
	glass_desc = "A refreshing chocolate milkshake, just like mom used to make."

/datum/reagent/drink/milkshake/chocoshake/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_ALRAUNE) //cit change: it wouldn't affect plants that much.
		M.nutrition += removed * 5

/datum/reagent/drink/milkshake/berryshake
	name = "Berry Milkshake"
	id = "berryshake"
	description = "A refreshing berry milkshake."
	taste_description = "cold refreshing berries and cream"
	color = "#ffb2b2" // rgb(255, 178, 178)
	adj_temp = -9
	nutrition=10

	glass_name = "Berry Milkshake"
	glass_desc = "A refreshing berry milkshake, just like mom used to make."

/datum/reagent/drink/milkshake/coffeeshake
	name = "Coffee Milkshake"
	id = "coffeeshake"
	description = "A refreshing coffee milkshake."
	taste_description = "cold energizing coffee and cream"
	color = "#8e6f44" // rgb(142, 111, 68)
	adj_temp = -9
	adj_dizzy = -5
	adj_drowsy = -3
	adj_sleepy = -2
	nutrition=8

	glass_name = "Coffee Milkshake"
	glass_desc = "An energizing coffee milkshake, perfect for hot days at work.."

/datum/reagent/drink/milkshake/coffeeshake/legacy_affect_overdose(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	M.make_jittery(5)

/datum/reagent/drink/milkshake/peanutshake
	name = "Peanut Milkshake"
	id = "peanutmilkshake"
	description = "Savory cream in an ice-cold stature."
	taste_description = "cold peanuts and cream"
	color = "#8e6f44"
	nutrition=10

	glass_name = "Peanut Milkshake"
	glass_desc = "Savory cream in an ice-cold stature."

/datum/reagent/drink/rewriter
	name = "Rewriter"
	id = "rewriter"
	description = "The secret of the sanctuary of the Libarian..."
	taste_description = "citrus and coffee"
	color = "#485000"
	adj_temp = -5
	nutrition=2

	glass_name = "Rewriter"
	glass_desc = "The secret of the sanctuary of the Libarian..."

/datum/reagent/drink/rewriter/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	M.make_jittery(5)

/datum/reagent/drink/soda/nuka_cola
	name = "Nuka Cola"
	id = "nuka_cola"
	description = "Cola, cola never changes."
	taste_description = "cola"
	color = "#100800"
	adj_temp = -5
	adj_sleepy = -2
	nutrition=1

	glass_name = "Nuka-Cola"
	glass_desc = "Don't cry, Don't raise your eye, It's only nuclear wasteland"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/nuka_cola/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	M.add_chemical_effect(CE_SPEEDBOOST, 1)
	M.make_jittery(20)
	M.druggy = max(M.druggy, 30)
	M.dizziness += 5
	M.drowsyness = 0

/datum/reagent/drink/grenadine
	name = "Grenadine Syrup"
	id = "grenadine"
	description = "Made in the modern day with proper pomegranate substitute. Who uses real fruit, anyways?"
	taste_description = "100% pure pomegranate"
	color = "#FF004F"
	water_based = FALSE
	nutrition=1

	glass_name = "Grenadine Syrup"
	glass_desc = "Sweet and tangy, a bar syrup used to add color and flavor to drinks."

/datum/reagent/drink/soda
	name = "Space Cola"
	id = "cola"
	description = "A refreshing beverage."
	taste_description = "cola"
	reagent_state = REAGENT_LIQUID
	color = "#100800"
	adj_drowsy = -3
	adj_temp = -5
	nutrition=3 // Also applies to other sodas, unless otherwise specified

	glass_name = "Space Cola"
	glass_desc = "A glass of refreshing Space Cola."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/cherry
	name = "Space Cola Cherry"
	id = "cherrycola"
	description = "A refreshing cherry-flavored beverage."
	taste_description = "cherry cola"

	glass_name = "Space Cola Cherry"
	glass_desc = "A glass of refreshing Space Cola Cherry."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/coffee
	name = "Space Cola Coffee"
	id = "coffeecola"
	description = "An energizing blend of Space Cola and coffee."
	taste_description = "caffeinated cola"

	glass_name = "Space Cola Coffee"
	glass_desc = "A glass of energizing Space Cola Coffee."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/spacemountainwind
	name = "Mountain Wind"
	id = "spacemountainwind"
	description = "Blows right through you like a space wind."
	taste_description = "sweet citrus soda"
	color = "#102000"
	adj_drowsy = -7
	adj_sleepy = -1
	adj_temp = -5

	glass_name = "Space Mountain Wind"
	glass_desc = "Space Mountain Wind. As you know, there are no mountains in space, only wind."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/astral_wind
	name = "Astral Wind"
	id = "astral_wind"
	description = "The soda is spiked with spices, lending it an unusual flavour."
	taste_description = "bittersweet acidity"
	color = "#002010"
	adj_drowsy = -7
	adj_sleepy = -2
	adj_temp = -8

	glass_name = "Astral Wind"
	glass_desc = "Astral Wind. It's a touch more solid than most drinks."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/solar_wind
	name = "Solar Wind"
	id = "solar_wind"
	description = "The spices have reacted energetically, making the soda give off a warm orange hue."
	taste_description = "Ultraviolet heat"
	color = "#002010"
	adj_drowsy = -10
	adj_sleepy = -5
	adj_temp = 15

	glass_name = "Solar Wind"
	glass_desc = "Solar Wind. Even the glass feels like it's been soaking up the sun."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/vortex_chill
	name = "Vortex Chill"
	id = "vortex_chill"
	description = "A splash of mint, and the temperature rapidly drops"
	taste_description = "the wind-chill of the universe"
	color = "#002010"
	adj_drowsy = -10
	adj_sleepy = -5
	adj_temp = -15

	glass_name = "Vortex Chill"
	glass_desc = "Vortex Chill. Despite lacking ice it's constantly flowing cold."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/dr_gibb
	name = "Dr. Gibb"
	id = "dr_gibb"
	description = "A delicious blend of 42 different flavors."
	taste_description = "cherry soda"
	color = "#102000"
	adj_drowsy = -6
	adj_temp = -5

	glass_name = "Dr. Gibb"
	glass_desc = "Dr. Gibb. Not as dangerous as the name might imply."

/datum/reagent/drink/soda/dr_gibb/cherry
	name = "Dr. Gibb Cherry"
	id = "dr_gibbcherry"
	description = "A delicious blend of 42 different flavors, but mostly cherry."
	taste_description = "extra cherry soda"

	glass_name = "Dr. Gibb Cherry"
	glass_desc = "A delicious blend of 42 different flavors."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/space_up
	name = "Space-Up"
	id = "space_up"
	description = "Tastes like a hull breach in your mouth."
	taste_description = "citrus soda"
	color = "#202800"
	adj_temp = -8

	glass_name = "Space-up"
	glass_desc = "Space-up. It helps keep your cool."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/lemon_lime
	name = "Lemon Lime"
	id = "lemon_lime"
	description = "A tangy substance made of 0.5% natural citrus!"
	taste_description = "tangy lime and lemon soda"
	color = "#878F00"
	adj_temp = -8

	glass_name = "Lemon Lime Soda"
	glass_desc = "A tangy substance made of 0.5% natural citrus!"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/gingerale
	name = "Ginger Ale"
	id = "gingerale"
	description = "The original."
	taste_description = "somewhat tangy ginger ale"
	color = "#edcf8f"
	adj_temp = -8

	glass_name = "Ginger Ale"
	glass_desc = "The original, refreshing not-actually-ale."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/kyocola
	name = "KyoCola"
	id = "kyocola"
	description = "Imported straight from Osaka IV."
	taste_description = "cough syrup and cola"
	color = "#271402"

	glass_name = "KyoCola"
	glass_desc = "A glass of imported Japanese KyoCola."

/datum/reagent/drink/soda/kyocola/fire
	name = "KyoCola Fire"
	id = "kyocolafire"
	description = "Cool imported cola mixed with firey hot spices."
	taste_description = "cough syrup, capsaicin, and cola"
	color = "#271402"

	glass_name = "KyoCola Fire"
	glass_desc = "A glass of spicy Japanese KyoCola Fire."

/datum/reagent/drink/soda/kyocola/cherry
	name = "KyoCola Sakura"
	id = "kyocolacherry"
	description = "Originally a limited flavor, brought back by popular demand."
	taste_description = "cough syrup, cherry blossoms, and cola"
	color = "#271402"

	glass_name = "KyoCola Sakura"
	glass_desc = "A glass of limited edition KyoCola Sakura."

/datum/reagent/drink/soda/kyocola/blue
	name = "KyoCola Blue"
	id = "kyocolablue"
	description = "A limited edition KyoCola flavor praised for its refreshing taste."
	taste_description = "cough syrup, violets, and cola"
	color = "#271402"

	glass_name = "KyoCola Blue"
	glass_desc = "A glass of limited edition KyoCola Blue."

/datum/reagent/drink/shirley_temple
	name = "Shirley Temple"
	id =  "shirley_temple"
	description = "A sweet concotion hated even by its namesake."
	taste_description = "sweet tonic cherries"
	color = "#EF304F"
	adj_temp = -8
	nutrition=2

	glass_name = "Shirley Temple"
	glass_desc = "A sweet concotion hated even by its namesake."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/roy_rogers
	name = "Roy Rogers"
	id = "roy_rogers"
	description = "I'm a cowboy, on a steel horse I ride."
	taste_description = "cola and fruit"
	color = "#4F1811"
	adj_temp = -8
	nutrition=2

	glass_name = "Roy Rogers"
	glass_desc = "I'm a cowboy, on a steel horse I ride"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/collins_mix
	name = "Collins Mix"
	id = "collins_mix"
	description = "Best hope it isn't a hoax."
	taste_description = "Particularly fizzy lemon-lime soda"
	color = "#D7D0B3"
	adj_temp = -8
	nutrition=3

	glass_name = "Collins Mix"
	glass_desc = "Best hope it isn't a hoax."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/arnold_palmer
	name = "Arnold Palmer"
	id = "arnold_palmer"
	description = "Tastes just like the old man."
	taste_description = "lemon and sweet tea"
	color = "#AF5517"
	adj_temp = -8
	nutrition=1

	glass_name = "Arnold Palmer"
	glass_desc = "Tastes just like the old man."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/doctor_delight
	name = "The Doctor's Delight"
	id = "doctorsdelight"
	description = "A gulp a day keeps the MediBot away. That's probably for the best."
	taste_description = "homely fruit smoothie"
	reagent_state = REAGENT_LIQUID
	color = "#FF8CFF"
	nutrition = 1

	glass_name = "The Doctor's Delight"
	glass_desc = "A healthy mixture of juices, guaranteed to keep you healthy until the next toolboxing takes place."

/datum/reagent/drink/doctor_delight/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.adjustOxyLoss(-4 * removed)
	M.heal_organ_damage(2 * removed, 2 * removed)
	M.adjustToxLoss(-2 * removed)
	if(M.dizziness)
		M.dizziness = max(0, M.dizziness - 15)
	if(M.confused)
		M.Confuse(-5)

/datum/reagent/drink/dry_ramen
	name = "Dry Ramen"
	id = "dry_ramen"
	description = "Space age food, since August 25, 1958. Contains dried noodles, vegetables, and chemicals that boil in contact with water."
	taste_description = "dry cheap noodles"
	reagent_state = REAGENT_SOLID
	nutrition = 5
	color = "#302000"

	glass_name = "Dry Ramen"
	glass_desc = "A glass of dry noodles. Wait, why did you put this into a glass?"

/datum/reagent/drink/hot_ramen
	name = "Hot Ramen"
	id = "hot_ramen"
	description = "The noodles are boiled, the flavors are artificial, just like being back in school."
	taste_description = "noodles and salt"
	reagent_state = REAGENT_LIQUID
	color = "#302000"
	nutrition = 10
	adj_temp = 5

	glass_name = "Hot Ramen"
	glass_desc = "A glass of spicy noodles. Wait, why did you put this into a glass?"

/datum/reagent/drink/hell_ramen
	name = "Hell Ramen"
	id = "hell_ramen"
	description = "The noodles are boiled, the flavors are artificial, just like being back in school."
	taste_description = "noodles and spice"
	taste_mult = 1.7
	reagent_state = REAGENT_LIQUID
	color = "#302000"
	nutrition = 10

	glass_name = "Hell Ramen"
	glass_desc = "A glass of extremely spicy noodles. Wait, why did you put this into a glass?"

/datum/reagent/drink/hell_ramen/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.bodytemperature += 10 * TEMPERATURE_DAMAGE_COEFFICIENT

/datum/reagent/drink/sweetsundaeramen
	name = "Dessert Ramen"
	id = "dessertramen"
	description = "How many things can you add to a cup of ramen before it begins to question its existance?"
	taste_description = "unbearable sweetness"
	color = "#4444FF"
	nutrition = 15

	glass_name = "Sweet Sundae Ramen"
	glass_desc = "How many things can you add to a cup of ramen before it begins to question its existance?"

/datum/reagent/drink/ice
	name = "Ice"
	id = "ice"
	description = "Frozen water, your dentist wouldn't like you chewing this."
	taste_description = "ice"
	reagent_state = REAGENT_SOLID
	color = "#619494"
	adj_temp = -5
	hydration = 9

	glass_name = "Ice"
	glass_desc = "Generally, you're supposed to put something else in there too..."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/ice/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= rand(1,3)
		if(M.bodytemperature < T0C)
			M.bodytemperature += rand(1,3)

/datum/reagent/drink/ice/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SLIME)
		if(M.bodytemperature > T0C)
			M.bodytemperature -= rand(1,3)
		if(M.bodytemperature < T0C)
			M.bodytemperature += rand(1,3)

/datum/reagent/drink/nothing
	name = "Nothing"
	id = "nothing"
	description = "Absolutely nothing."
	taste_description = "nothing"

	glass_name = "Nothing"
	glass_desc = "Absolutely nothing."

/datum/reagent/drink/dreamcream
	name = "Dream Cream"
	id = "dreamcream"
	description = "A smoothy, silky mix of honey and dairy."
	taste_description = "sweet, soothing dairy"
	color = "#fcfcc9" // rgb(252, 252, 201)
	nutrition=10

	glass_name = "Dream Cream"
	glass_desc = "A smoothy, silky mix of honey and dairy."

/datum/reagent/drink/soda/vilelemon
	name = "Vile Lemon"
	id = "vilelemon"
	description = "A fizzy, sour lemonade mix."
	taste_description = "fizzy, sour lemon"
	color = "#c6c603" // rgb(198, 198, 3)
	nutrition=2

	glass_name = "Vile Lemon"
	glass_desc = "A sour, fizzy drink with lemonade and lemonlime."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/entdraught
	name = "Ent's Draught"
	id = "entdraught"
	description = "A natural, earthy combination of all things peaceful."
	taste_description = "fresh rain and sweet memories"
	color = "#3a6617" // rgb(58, 102, 23)
	nutrition=2

	glass_name = "Ent's Draught"
	glass_desc = "You can almost smell the tranquility emanating from this."

/datum/reagent/drink/lovepotion
	name = "Love Potion"
	id = "lovepotion"
	description = "Creamy strawberries and sugar, simple and sweet."
	taste_description = "strawberries and cream"
	color = "#fc8a8a" // rgb(252, 138, 138)
	nutrition=5

	glass_name = "Love Potion"
	glass_desc = "Love me tender, love me sweet."

/datum/reagent/drink/oilslick
	name = "Oil Slick"
	id = "oilslick"
	description = "A viscous, but sweet, ooze."
	taste_description = "honey"
	color = "#FDF5E6" // rgb(253,245,230)
	water_based = FALSE
	nutrition=10

	glass_name = "Oil Slick"
	glass_desc = "A concoction that should probably be in an engine, rather than your stomach."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/slimeslammer
	name = "Slick Slimes Slammer"
	id = "slimeslammer"
	description = "A viscous, but savory, ooze."
	taste_description = "peanuts`n`slime"
	color = "#93604D"
	water_based = FALSE
	nutrition=10

	glass_name = "Slick Slime Slammer"
	glass_desc = "A concoction that should probably be in an engine, rather than your stomach. Still."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/eggnog
	name = "Eggnog"
	id = "eggnog"
	description = "A creamy, rich beverage made out of whisked eggs, milk and sugar, for when you feel like celebrating the winter holidays."
	taste_description = "thick cream and vanilla"
	color = "#fff3c1" // rgb(255, 243, 193)
	nutrition=8

	glass_name = "Eggnog"
	glass_desc = "You can't egg-nore the holiday cheer all around you"

/datum/reagent/drink/nuclearwaste
	name = "Nuclear Waste"
	id = "nuclearwaste"
	description = "A viscous, glowing slurry."
	taste_description = "sour honey drops"
	color = "#7FFF00" // rgb(127,255,0)
	water_based = FALSE
	nutrition=2

	glass_name = "Nuclear Waste"
	glass_desc = "Sadly, no super powers."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/nuclearwaste/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.bloodstr.add_reagent("radium", 0.3)

/datum/reagent/drink/nuclearwaste/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.ingested.add_reagent("radium", 0.25)

/datum/reagent/drink/sodaoil //Mixed with normal drinks to make a 'potable' version for Prometheans if mixed 1-1. Dilution is key.
	name = "Soda Oil"
	id = "sodaoil"
	description = "A thick, bubbling soda."
	taste_description = "chewy water"
	color = "#F0FFF0" // rgb(245,255,250)
	water_based = FALSE
	nutrition=3

	glass_name = "Soda Oil"
	glass_desc = "A pitiful sludge that looks vaguely like a soda.. if you look at it a certain way."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/sodaoil/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(M.bloodstr) // If, for some reason, they are injected, dilute them as well.
		for(var/datum/reagent/R in M.ingested.get_reagent_datums())
			if(istype(R, /datum/reagent/drink))
				var/datum/reagent/drink/D = R
				if(D.water_based)
					M.adjustToxLoss(removed * -3)

/datum/reagent/drink/sodaoil/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(M.ingested) // Find how many drinks are causing tox, and negate them.
		for(var/datum/reagent/R in M.ingested.get_reagent_datums())
			if(istype(R, /datum/reagent/drink))
				var/datum/reagent/drink/D = R
				if(D.water_based)
					M.adjustToxLoss(removed * -2)

/datum/reagent/drink/mojito
	name = "Mojito"
	id = "virginmojito"
	description = "Mint, bubbly water, and citrus, made for sailing."
	taste_description = "mint and lime"
	color = "#FFF7B3"
	nutrition=2

	glass_name = "Mojito"
	glass_desc = "Mint, bubbly water, and citrus, made for sailing."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/virginsexonthebeach
	name = "Virgin Sex On The Beach"
	id = "virginsexonthebeach"
	description = "A secret combination of orange juice and pomegranate."
	taste_description = "a sexy, sandy sunset"
	color = "#FF0033"
	nutrition=2

	glass_name = "Sex on the Beach"
	glass_desc = "A secret combination of orange juice and pomegranate."

/datum/reagent/drink/driverspunch
	name = "Driver's Punch"
	id = "driverspunch"
	description = "A fruity punch!"
	taste_description = "sharp, sour apples"
	color = "#D2BA6E"
	nutrition=2

	glass_name = "Driver`s Punch"
	glass_desc = "A fruity punch!"
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/sugarrush
	name = "Sweet Rush"
	id = "sugarrush"
	description = "A favorite drink amongst poor bartenders living in Neo Detroit."
	taste_description = "sweet bubblegum fizz."
	color = "#d3785d"
	nutrition=5

	glass_name = "Sweet Rush"
	glass_desc = "This looks like it might rot your teeth out."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/berrycordial
	name = "Berry Cordial"
	id = "berrycordial"
	description = "How <font face='comic sans ms'>berry cordial</font> of you."
	taste_description = "sweet chivalry"
	color = "#D26EB8"
	nutrition=4

	glass_name = "Berry Cordial"
	glass_desc = "How <font face='comic sans ms'>berry cordial</font> of you."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/blud
	name = "Blud"
	id = "blud"
	description = "A sweet mix of blood-like additives. Vampiric."
	taste_description = "an odd blend of metals and sugar"
	color = "#993c49"
	blood_content = 1
	nutrition=1

	glass_name = "Blud"
	glass_desc = "A sweet mix of blood-like additives. Vampiric."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/blud/bludlight
	name = "Blud Light"
	id = "bludlight"
	description = "An artificially sweetened mix of blood-like additives. Vampiric and low in calories!"
	taste_description = "an awful blend of metals and artificial sweeteners"
	color = "#793c44"
	blood_content = 1

	glass_name = "Blud Light"
	glass_desc = "An artificially sweetened mix of blood-like additives. Vampiric and low in calories!"
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/drink/tropicalfizz
	name = "Tropical Fizz"
	id = "tropicalfizz"
	description = "One sip and you're in the bahamas."
	taste_description = "tropical"
	color = "#69375C"
	nutrition=3

	glass_name = "Tropical Fizz"
	glass_desc = "One sip and you're in the bahamas."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/fauxfizz
	name = "Faux Fizz"
	id = "fauxfizz"
	description = "One sip and you're in the bahamas... maybe."
	taste_description = "slightly tropical"
	color = "#69375C"
	nutrition=3

	glass_name = "Tropical Fizz"
	glass_desc = "One sip and you're in the bahamas... maybe."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/sarsaparilla
	name = "Sarsaparilla"
	id = "sarsaparilla"
	description = "The Cyan Cowgirl rides again!"
	taste_description = "earthy vanilla and harsh bubbles"
	color = "#503301"
	adj_temp = -2

	glass_name = "Sarsaparilla"
	glass_desc = "Real girls drink from the bottle."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/sassafras
	name = "Root Beer"
	id = "sassafras"
	description = "Feel nostalgia for a range you never rode."
	taste_description = "bitter licorice and sweet vanilla"
	color = "#312003"
	adj_temp = -2

	glass_name = "Root Beer"
	glass_desc = "Wet your whistle!"
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/drink/soda/rootbeerfloat
	name = "Root Beer Float"
	id = "rootbeerfloat"
	description = "A classic from Humanity's early days. Soothing, cool, and nostalgic."
	taste_description = "creamy ice cream with a bubbly and bitter kick"
	adj_temp = -5
	nutrition=10

	glass_name = "Root Beer Float"
	glass_desc = "A classic from Humanity's early days. Soothing, cool, and nostalgic."

/datum/reagent/drink/milk/pilk
	name = "Pilk"
	id = "pilk"
	description = "Milk and Space Cola mixed together. What?"
	taste_description = "creamed up cola"
	color = "#c9ab84" //usually most pilk mixtures have the milk presence dominate.
	adj_drowsy = -3 //space cola effects
	adj_temp = -3
	nutrition=5

	glass_name = "Pilk"
	glass_desc = "Milk and Space Cola mixed together. <i>Burenyuu~</i>. While the soda ingredient isn't exactly the one based on the original \
	old Terra brand, the \"Pilk\" name has stuck all of these centuries later. It's a drink mixture that many still get upset about to this day."

/* Alcohol */

// Basic

#define ABSINTHE 130

/datum/reagent/ethanol/absinthe
	name = "Absinthe"
	id = "absinthe"
	description = "Watch out that the Green Fairy doesn't come for you!"
	taste_description = "licorice"
	taste_mult = 1.5
	color = "#33EE00"
	proof = ABSINTHE

	glass_name = "Absinthe"
	glass_desc = "Wormwood, anise, oh my."

#define BEER 10

/datum/reagent/ethanol/ale
	name = "Ale"
	id = "ale"
	description = "A dark alchoholic beverage made by malted barley and yeast."
	taste_description = "hearty barley ale"
	color = "#4C3100"
	proof = BEER
	nutriment_factor=5

	glass_name = "Ale"
	glass_desc = "A freezing pint of delicious ale."

/datum/reagent/ethanol/beer
	name = "Beer"
	id = "beer"
	description = "An alcoholic beverage made from malted grains, hops, yeast, and water."
	taste_description = "beer"
	color = "#FFD300"
	proof = BEER
	nutriment_factor = 5

	glass_name = "Beer"
	glass_desc = "A freezing pint of beer"

/datum/reagent/ethanol/beer/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(.)
		M.jitteriness = max(M.jitteriness - 3, 0)

#define CURACAO 60

/datum/reagent/ethanol/bluecuracao
	name = "Blue Curacao"
	id = "bluecuracao"
	description = "Exotically blue, fruity drink, distilled from oranges."
	taste_description = "oranges"
	taste_mult = 1.1
	color = "#0000CD"
	proof = CURACAO

	glass_name = "Blue Curacao"
	glass_desc = "Exotically blue, fruity drink, distilled from oranges."

#define COGNAC 80

/datum/reagent/ethanol/cognac
	name = "Cognac"
	id = "cognac"
	description = "A sweet and strongly alchoholic drink, made after numerous distillations and years of maturing. Classy as fornication."
	taste_description = "rich and smooth alcohol"
	taste_mult = 1.1
	color = "#AB3C05"
	proof = 80

	glass_name = "Cognac"
	glass_desc = "Damn, you feel like some kind of French aristocrat just by holding this."

/datum/reagent/ethanol/deadrum
	name = "Deadrum"
	id = "deadrum"
	description = "Popular with the sailors. Not very popular with everyone else."
	taste_description = "butterscotch and salt"
	taste_mult = 1.1
	color = "#ECB633"
	proof = 10

	glass_name = "Rum"
	glass_desc = "Now you want to Pray for a pirate suit, don't you?"

/datum/reagent/ethanol/deadrum/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(.)
		M.dizziness += 5

#define GIN 100

/datum/reagent/ethanol/gin
	name = "Gin"
	id = "gin"
	description = "It's gin. In space. I say, good sir."
	taste_description = "an alcoholic christmas tree"
	color = "#0064C6"
	proof = GIN

	glass_name = "Gin"
	glass_desc = "A crystal clear glass of Griffeater gin."

#define VICTORY_GIN 70

/datum/reagent/ethanol/victory_gin
	name = "Victory Gin"
	id = "victory_gin"
	description = "An oily grain alcohol brewed on Adhomai. Notably weaker than regular gin."
	taste_description = "oily gin"
	color = "#0064C6"
	proof = VICTORY_GIN

	glass_name = "Victory Gin"
	glass_desc = "An oily grain alcohol brewed on Adhomai. Notably weaker than regular gin."

//Base type for alchoholic drinks containing coffee
// i hate you, whoever made this, go make reagent traits you utter AAAAA
/datum/reagent/ethanol/coffee
	id = "coffee_alcohol"
	overdose = 45

/datum/reagent/ethanol/coffee/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	. = ..() // the rest is coffee stuff, ugh, go make reagent traits etc
	M.dizziness = max(0, M.dizziness - 5)
	M.drowsyness = max(0, M.drowsyness - 3)
	M.adjust_sleeping(20 * -2)
	if(M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (5 * TEMPERATURE_DAMAGE_COEFFICIENT))

/datum/reagent/ethanol/coffee/legacy_affect_overdose(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	if(alien == IS_DIONA)
		return
	M.make_jittery(5)

#define KAHLUA 40

/datum/reagent/ethanol/coffee/kahlua
	name = "Kahlua"
	id = "kahlua"
	description = "A widely known, Mexican coffee-flavored liqueur. In production since 1936!"
	taste_description = "spiked latte"
	taste_mult = 1.1
	color = "#4C3100"
	proof = KAHLUA

	glass_name = "RR Coffee Liquor"
	glass_desc = "A widely known, Mexican coffee-flavored liqueur. In production since 1936!"
//	glass_desc = "DAMN, THIS THING LOOKS ROBUST" //If this isn't what our players should talk like, it isn't what our game should say to them.

#define MELON_LIQUOR 46

/datum/reagent/ethanol/melonliquor
	name = "Melon Liquor"
	id = "melonliquor"
	description = "A relatively sweet and fruity 46 proof liquor."
	taste_description = "fruity alcohol"
	color = "#138808" // rgb: 19, 136, 8
	proof = MELON_LIQUOR

	glass_name = "Melon Liquor"
	glass_desc = "A relatively sweet and fruity 46 proof liquor."

#define RUM 120

/datum/reagent/ethanol/rum
	name = "Rum"
	id = "rum"
	description = "Yo-ho-ho and all that."
	taste_description = "spiked butterscotch"
	taste_mult = 1.1
	color = "#ECB633"
	proof = RUM

	glass_name = "Rum"
	glass_desc = "Makes you want to buy a ship and just go pillaging."

/datum/reagent/ethanol/whiterum
	name = "White Rum"
	id = "whiterum"
	description = "Now in all-new coconut!"
	taste_description = "milky coconut"
	taste_mult = 1.1
	color = "#e0e0e0"
	proof = 90

	glass_name = "White Rum"
	glass_desc = "Makes you want to buy a ship and just go pillaging."

#define SAKE 40

/datum/reagent/ethanol/sake
	name = "Sake"
	id = "sake"
	description = "Anime's favorite drink."
	taste_description = "dry alcohol"
	color = "#DDDDDD"
	proof = SAKE

	glass_name = "Sake"
	glass_desc = "A glass of sake."

/datum/reagent/ethanol/thirteenloko
	name = "Thirteen Loko"
	id = "thirteenloko"
	description = "A potent mixture of caffeine and alcohol."
	taste_description = "battery acid"
	color = "#102000"
	proof = 40
	nutriment_factor = 1

	glass_name = "Thirteen Loko"
	glass_desc = "This is a glass of Thirteen Loko, it appears to be of the highest quality. The drink, not the glass."

/datum/reagent/ethanol/thirteenloko/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(alien == IS_DIONA)
		return
	M.drowsyness = max(0, M.drowsyness - 7)
	if (M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (5 * TEMPERATURE_DAMAGE_COEFFICIENT))
	M.make_jittery(5)

#define VERMOUTH 35

/datum/reagent/ethanol/vermouth
	name = "Vermouth"
	id = "vermouth"
	description = "You suddenly feel a craving for a martini..."
	taste_description = "dry alcohol"
	taste_mult = 1.3
	color = "#91FF91" // rgb: 145, 255, 145
	proof = VERMOUTH

	glass_name = "Vermouth"
	glass_desc = "You wonder why you're even drinking this straight."

#define VODKA 80

/datum/reagent/ethanol/vodka
	name = "Vodka"
	id = "vodka"
	description = "Number one drink AND fueling choice for Russians worldwide."
	taste_description = "potato alcohol"
	color = "#0064C8" // rgb: 0, 100, 200
	proof = VODKA

	glass_name = "Vodka"
	glass_desc = "The glass contain wodka. Xynta."

/datum/reagent/ethanol/vodka/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	M.cure_radiation(RAD_MOB_CURE_STRENGTH_VODKA(removed))

#define WHISKEY 80

/datum/reagent/ethanol/whiskey
	name = "Whiskey"
	id = "whiskey"
	description = "A superb and well-aged single-malt whiskey. Damn."
	taste_description = "molasses"
	color = "#4C3100"
	proof = WHISKEY

	glass_name = "Whiskey"
	glass_desc = "The silky, smokey whiskey goodness inside the glass makes the drink look very classy."

#define WINE 20

/datum/reagent/ethanol/wine
	name = "Red Wine"
	id = "wine"
	description = "A premium alchoholic beverage made from distilled grape juice. This one's red!"
	taste_description = "bitter sweetness"
	color = "#7E4043" // rgb: 126, 64, 67
	proof = WINE

	glass_name = "Wine"
	glass_desc = "A very classy looking drink."

/datum/reagent/ethanol/whitewine
	name = "White Wine"
	id = "whitewine"
	description = "A premium alchoholic beverage made from distilled grape juice. This one's white!"
	taste_description = "bitter sweetness"
	color = "#FCF1D2"
	proof = WINE

	glass_name = "White Wine"
	glass_desc = "A very classy looking drink. Now in white!"

#define SCHNAPPS 60

/datum/reagent/ethanol/peppermintschnapps
	name = "Peppermint Schnapps"
	id = "schnapps_pep"
	description = "A flavoured grain liqueur with a fresh, minty taste."
	taste_description = "minty"
	proof = SCHNAPPS

	glass_name = "Peppermint Schnapps"
	glass_desc = "A flavoured grain liqueur with a fresh, minty taste."

/datum/reagent/ethanol/peachschnapps
	name = "Peach Schnapps"
	id = "schnapps_pea"
	description = "A flavoured grain liqueur with a fresh, peachy taste."
	taste_description = "peachy"
	proof = SCHNAPPS

	glass_name = "Peach Schnapps"
	glass_desc = "A flavoured grain liqueur with a fresh, peachy taste."

/datum/reagent/ethanol/lemonadeschnapps
	name = "Lemonade Schnapps"
	id = "schnapps_lem"
	description = "A flavoured grain liqueur with a fresh, lemony taste."
	taste_description = "lemony"
	proof = SCHNAPPS

	glass_name = "Lemonade Schnapps"
	glass_desc = "A flavoured grain liqueur with a fresh, lemony taste."

/datum/reagent/ethanol/wine/champagne
	name = "Champagne"
	id = "champagne"
	description = "A sparkling wine made with Pinot Noir, Pinot Meunier, and Chardonnay."
	taste_description = "fizzy bitter sweetness"
	color = "#D1B166"

	glass_name = "Champagne"
	glass_desc = "An even classier looking drink."

#define CIDER 10

/datum/reagent/ethanol/cider
	name = "Cider"
	id = "cider"
	description = "An alcoholic drink made from apple juice. Erratum on earlier recipe books: this is definitely hard."
	taste_description = "tartness"
	color = "#CE9C00" // rgb: 206, 156, 0
	proof = CIDER

	glass_name = "Cider"
	glass_desc = "The second most Irish drink."
	glass_special = list(DRINK_FIZZ)

#define MEAD 10

/datum/reagent/ethanol/mead
	name = "Mead"
	id = "mead"
	description = "A Viking's drink, though a cheap one."
	taste_description = "sweet yet alcoholic"
	reagent_state = REAGENT_LIQUID
	color = "#FFBB00"
	proof = MEAD
	nutriment_factor = 2

	glass_name = "Mead"
	glass_desc = "A Viking's beverage, though a cheap one."

#define MESSA_MEAD 100

/datum/reagent/ethanol/messa_mead
	name = "Messa's Mead"
	id = "messa_mead"
	description = "A sweet tajaran liquor. Produced from the frementation of honey and earthen roots."
	taste_description = "chilled honey"
	reagent_state = REAGENT_LIQUID
	color = "#FFBB00"
	proof = MESSA_MEAD
	nutriment_factor = 2

	glass_name = "Messa's Mead"
	glass_desc = "A sweet tajaran liquor. Produced from the fermentation of honey and earthen roots native to Adhomai."

/datum/reagent/ethanol/moonshine
	name = "Moonshine"
	id = "moonshine"
	description = "You've really hit rock bottom now... your liver packed its bags and left last night."
	taste_description = "bitterness"
	taste_mult = 2.5
	color = "#0064C8"
	proof = 150

	glass_name = "Moonshine"
	glass_desc = "You've really hit rock bottom now... your liver packed its bags and left last night."

#define TEQUILA 80

/datum/reagent/ethanol/tequila
	name = "Tequila"
	id = "tequila"
	description = "A drink made for fighting."
	taste_description = "paint thinner"
	color = "#cccac5"
	proof = TEQUILA

	glass_name = "Tequila"
	glass_desc = "Is that guy making fun of you? You should show him what's what."

#define BITTERS 40

/datum/reagent/ethanol/bitters
	name = "Bitters"
	id = "bitters"
	description = "A blend of fermented fruits and herbs, commonly used in cocktails."
	taste_description = "sharp bitterness"
	color = "#9b6241" // rgb(155, 98, 65)
	proof = BITTERS

	glass_name = "Bitters"
	glass_desc = "A blend of fermented fruits and herbs, commonly used in cocktails."

#define BRANDY 100

/datum/reagent/ethanol/winebrandy
	name = "Wine Brandy"
	id = "winebrandy"
	description = "A premium spirit made from distilled wine."
	taste_description = "very sweet dried fruit with many elegant notes"
	color = "#4C130B" // rgb(76,19,11)
	proof = BRANDY

	glass_name = "Wine Brandy"
	glass_desc = "A very classy looking after-dinner drink."

/datum/reagent/ethanol/alcsassafras
	name = "Hard Rootbeer"
	id = "alcsassafras"
	description = "Doesn't matter if you're drunk when you have a horse to take you home!"
	taste_description = "bitter vanilla with a sharp burn"
	proof = 50

	glass_name = "CC's Hard Rootbeer"
	glass_desc = "You'd better carry two guns if you're gonna keep drinking these!"
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

// Cocktails

#define SCREWDRIVERCOCKTAIL (VODKA/3)

/datum/reagent/ethanol/screwdrivercocktail
	name = "Screwdriver"
	id = "screwdrivercocktail"
	description = "Vodka, mixed with plain ol' orange juice. The result is surprisingly delicious."
	taste_description = "oranges"
	color = "#A68310"
	proof = SCREWDRIVERCOCKTAIL

	glass_name = "Screwdriver"
	glass_desc = "A simple, yet superb mixture of Vodka and orange juice. Just the thing for the tired engineer."

/datum/reagent/ethanol/sexonthebeach
	name = "Sex On The Beach"
	id = "sexonthebeach"
	description = "A concoction of vodka and a secret combination of orange juice and pomegranate."
	taste_description = "sand, you don't like sand, it's coarse and rough and irritating and it gets everywhere"
	color = "#FF0033"
	proof = SCREWDRIVERCOCKTAIL/2

	glass_name = "Sex on the Beach"
	glass_desc = "A concoction of vodka and a secret combination of orange juice and pomegranate."

/datum/reagent/ethanol/melonspritzer
	name = "Melon Spritzer"
	id = "melonspritzer"
	description = "Melons: Citrus style."
	taste_description = "sour melon"
	color = "#934D5D"
	proof = WINE/3

	glass_name = "Melon Spritzer"
	glass_desc = "Melons: Citrus style."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/acid_spit
	name = "Acid Spit"
	id = "acidspit"
	description = "A drink for the daring, can be deadly if incorrectly prepared!"
	taste_description = "bitter tang"
	reagent_state = REAGENT_LIQUID
	color = "#365000"
	proof = WINE*5/6

	glass_name = "Acid Spit"
	glass_desc = "A drink from the company archives. Made from live aliens."

#define MARTINI (2*VERMOUTH+GIN)/3

/datum/reagent/ethanol/martini
	name = "Classic Martini"
	id = "martini"
	description = "Vermouth with Gin. Not quite how 007 enjoyed it, but still delicious."
	taste_description = "dry class"
	color = "#0064C8"
	proof = MARTINI

	glass_name = "classic martini"
	glass_desc = "Damn, the bartender even stirred it, not shook it."

/datum/reagent/ethanol/alliescocktail
	name = "Allies Cocktail"
	id = "alliescocktail"
	description = "A drink made from your allies, not as sweet as when made from your enemies."
	taste_description = "bitter sweetness"
	color = "#D8AC45"
	proof = (MARTINI+VODKA)/2

	glass_name = "Allies cocktail"
	glass_desc = "A drink made from your allies."

/datum/reagent/ethanol/aloe
	name = "Aloe"
	id = "aloe"
	description = "So very, very, very good."
	taste_description = "sweet and creamy"
	color = "#B7EA75"
	proof = WHISKEY/3

	glass_name = "Aloe"
	glass_desc = "Very, very, very good."

/datum/reagent/ethanol/amasec
	name = "Amasec"
	id = "amasec"
	description = "Official drink of the Gun Club!"
	taste_description = "dark and metallic"
	reagent_state = REAGENT_LIQUID
	color = "#FF975D"
	proof = (WINE+VODKA)/2

	glass_name = "Amasec"
	glass_desc = "Always handy before combat!"

/datum/reagent/ethanol/andalusia
	name = "Andalusia"
	id = "andalusia"
	description = "A nice, strangely named drink." // it's the southern tip of spain you cretin
	taste_description = "lemons"
	color = "#F4EA4A"
	proof = (RUM+WHISKEY)/3

	glass_name = "Andalusia"
	glass_desc = "A nice, strange named drink."

#define ANTIFREEZE (VODKA/3)

/datum/reagent/ethanol/antifreeze
	name = "Anti-freeze"
	id = "antifreeze"
	description = "Ultimate refreshment."
	taste_description = "ice cold vodka"
	color = "#56DEEA"
	proof = ANTIFREEZE
	adj_temp = 20
	targ_temp = 330

	glass_name = "Anti-freeze"
	glass_desc = "The ultimate refreshment."

#define IRISH_CREAM (WHISKEY*2/3)

/datum/reagent/ethanol/irish_cream
	name = "Irish Cream"
	id = "irishcream"
	description = "Whiskey-imbued cream, what else would you expect from the Irish."
	taste_description = "creamy alcohol"
	color = "#DDD9A3"
	proof = IRISH_CREAM

	glass_name = "Irish cream"
	glass_desc = "It's cream, mixed with whiskey. What else would you expect from the Irish?"

/datum/reagent/ethanol/coffee/b52
	name = "B-52"
	id = "b52"
	description = "Kahlua, Irish cream, and cognac. You will get bombed."
	taste_description = "coffee, almonds, and whiskey"
	taste_mult = 1.3
	color = "#997650"
	proof = (IRISH_CREAM+KAHLUA+COGNAC)/3

	glass_name = "B-52"
	glass_desc = "Kahlua, Irish cream, and cognac. You will get bombed."

/datum/reagent/ethanol/atomicbomb
	name = "Atomic Bomb"
	id = "atomicbomb"
	description = "Nuclear proliferation never tasted so good."
	taste_description = "coffee, almonds, and whiskey, with a kick"
	reagent_state = REAGENT_LIQUID
	color = "#666300"
	proof = 200 // don't question it
	druggy = 50

	glass_name = "Atomic Bomb"
	glass_desc = "We cannot take legal responsibility for your actions after imbibing."

/datum/reagent/ethanol/bahama_mama
	name = "Bahama mama"
	id = "bahama_mama"
	description = "Tropical cocktail."
	taste_description = "lime and orange"
	color = "#FF7F3B"
	proof = RUM/6

	glass_name = "Bahama Mama"
	glass_desc = "Tropical cocktail."

/datum/reagent/drink/bananahonk
	name = "Banana Mama"
	id = "bananahonk"
	description = "A drink from Clown Heaven."
	taste_description = "bananas and sugar"
	nutrition = 1
	color = "#FFFF91"

	glass_name = "Banana Honk"
	glass_desc = "A drink from Banana Heaven."

/datum/reagent/ethanol/barefoot
	name = "Barefoot"
	id = "barefoot"
	description = "Barefoot and pregnant."
	taste_description = "creamy berries"
	color = "#FFCDEA"
	proof = VERMOUTH/3

	glass_name = "Barefoot"
	glass_desc = "Barefoot and pregnant."

/datum/reagent/ethanol/beepsky_smash
	name = "Beepsky Smash"
	id = "beepskysmash"
	description = "Deny drinking this and prepare for THE LAW."
	taste_description = "whiskey and citrus"
	taste_mult = 2
	reagent_state = REAGENT_LIQUID
	color = "#404040"
	proof = WHISKEY/2

	glass_name = "Beepsky Smash"
	glass_desc = "Heavy, hot and strong. Just like the Iron fist of the LAW."

/datum/reagent/ethanol/beepsky_smash/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	M.afflict_stun(20 * 2)

/datum/reagent/ethanol/bilk
	name = "Bilk"
	id = "bilk"
	description = "This appears to be beer mixed with milk. Odd."
	taste_description = "sour milk"
	color = "#895C4C"
	proof = BEER/2
	nutriment_factor = 5

	glass_name = "Bilk"
	glass_desc = "A brew of milk and beer. For those alcoholics who fear osteoporosis."

#define BLACK_RUSSIAN ((2*VODKA+KAHLUA)/3)

/datum/reagent/ethanol/black_russian
	name = "Black Russian"
	id = "blackrussian"
	description = "For the lactose-intolerant. Still as classy as a White Russian."
	taste_description = "coffee"
	color = "#360000"
	proof = BLACK_RUSSIAN

	glass_name = "Black Russian"
	glass_desc = "For the lactose-intolerant. Still as classy as a White Russian."

/datum/reagent/ethanol/bloody_mary
	name = "Bloody Mary"
	id = "bloodymary"
	description = "A strange yet pleasurable mixture made of vodka, tomato and lime juice. Or at least you THINK the red stuff is tomato juice."
	taste_description = "tomatoes with a hint of lime"
	color = "#B40000"
	proof = VODKA/6

	glass_name = "Bloody Mary"
	glass_desc = "Tomato juice, mixed with Vodka and a lil' bit of lime. Tastes like liquid murder."

/datum/reagent/ethanol/booger
	name = "Booger"
	id = "booger"
	description = "Ewww..."
	taste_description = "sweet 'n creamy"
	color = "#8CFF8C"
	proof = RUM/5

	glass_name = "Booger"
	glass_desc = "Ewww..."

/datum/reagent/ethanol/coffee/brave_bull
	name = "Brave Bull"
	id = "bravebull"
	description = "It's just as effective as Dutch-Courage!"
	taste_description = "coffee and paint thinner"
	taste_mult = 1.1
	color = "#4C3100"
	proof = (2*TEQUILA+KAHLUA)/3

	glass_name = "Brave Bull"
	glass_desc = "Tequila and coffee liquor, brought together in a mouthwatering mixture. Drink up."

/datum/reagent/ethanol/changelingsting
	name = "Changeling Sting"
	id = "changelingsting"
	description = "You take a tiny sip and feel a burning sensation..."
	taste_description = "constantly changing flavors"
	color = "#2E6671"
	proof = SCREWDRIVERCOCKTAIL/3

	glass_name = "Changeling Sting"
	glass_desc = "A stingy drink."

/datum/reagent/ethanol/cuba_libre
	name = "Cuba Libre"
	id = "cubalibre"
	description = "Rum, mixed with cola. Viva la revolucion."
	taste_description = "cola"
	color = "#3E1B00"
	proof = RUM/3

	glass_name = "Cuba Libre"
	glass_desc = "A classic mix of rum and cola."

/datum/reagent/ethanol/driestmartini
	name = "Driest Martini"
	id = "driestmartini"
	description = "Only for the experienced. You think you see sand floating in the glass."
	taste_description = "a beach"
	nutriment_factor = 1
	color = "#2E6671"
	proof = GIN*1.5 // it's 50% nothing, which strengthens it somehow. go with it

	glass_name = "Driest Martini"
	glass_desc = "Only for the experienced. You think you see sand floating in the glass."

/datum/reagent/ethanol/ginfizz
	name = "Gin Fizz"
	id = "ginfizz"
	description = "Refreshingly lemony, deliciously dry."
	taste_description = "dry, tart lemons"
	color = "#FFFFAE"
	proof = GIN/3

	glass_name = "Gin Fizz"
	glass_desc = "Refreshingly lemony, deliciously dry."

/datum/reagent/drink/soda/nebula_riptide
	name = "Nebula Riptide"
	id = "nebula_riptide"
	description = "The drink is compounded into form from a larger volume, leaving little to drink."
	taste_description = "Burning hot, Freezing cold, and bitter irony"
	color = "#09dbf7"

	glass_name = "Nebula Riptide"
	glass_desc = "Nebula Riptide. It's thick enough to stand on it's own, almost even parts spice and liquid."

/datum/reagent/ethanol/grog
	name = "Grog"
	id = "grog"
	description = "Watered-down rum, pirate approved!"
	taste_description = "a poor excuse for alcohol"
	reagent_state = REAGENT_LIQUID
	color = "#FFBB00"
	proof = RUM/2


	glass_name = "Grog"
	glass_desc = "A fine and cepa drink for Space."

/datum/reagent/ethanol/erikasurprise
	name = "Erika Surprise"
	id = "erikasurprise"
	description = "The surprise is, it's green!"
	taste_description = "tartness and bananas"
	color = "#2E6671"
	proof = (2*BEER+WHISKEY)/3

	glass_name = "Erika Surprise"
	glass_desc = "The surprise is, it's green!"

/datum/reagent/ethanol/gargle_blaster
	name = "Pan-Galactic Gargle Blaster"
	id = "gargleblaster"
	description = "Whoah, this stuff looks volatile!"
	taste_description = "your brains smashed out by a lemon wrapped around a gold brick"
	taste_mult = 5
	reagent_state = REAGENT_LIQUID
	color = "#7F00FF"
	proof = (2*VODKA+GIN+WHISKEY+COGNAC)/3 // stronger than it should be on purpose
	druggy = 15

	glass_name = "Pan-Galactic Gargle Blaster"
	glass_desc = "Does... does this mean that Arthur and Ford are on the station? Oh joy."

/datum/reagent/ethanol/gintonic
	name = "Gin and Tonic"
	id = "gintonic"
	description = "An all time classic, mild cocktail."
	taste_description = "mild and tart"
	color = "#0064C8"
	proof = GIN/3

	glass_name = "Gin and Tonic"
	glass_desc = "A mild but still great cocktail. Drink up, like a true Englishman."

/datum/reagent/ethanol/goldschlager
	name = "Goldschlager"
	id = "goldschlager"
	description = "100 proof cinnamon schnapps, made for alcoholic teen girls on spring break."
	taste_description = "burning cinnamon"
	taste_mult = 1.3
	color = "#F4E46D"
	proof = VODKA

	glass_name = "Goldschlager"
	glass_desc = "100 proof that teen girls will drink anything with gold in it."

/datum/reagent/ethanol/hippies_delight
	name = "Hippies' Delight"
	id = "hippiesdelight"
	description = "You just don't get it maaaan."
	taste_description = "giving peace a chance"
	reagent_state = REAGENT_LIQUID
	color = "#FF88FF"
	proof = 100
	druggy = 50

	glass_name = "Hippie's Delight"
	glass_desc = "A drink enjoyed by people during the 1960's."

/datum/reagent/ethanol/hooch
	name = "Hooch"
	id = "hooch"
	description = "Either someone's failure at cocktail making or attempt in alchohol production. In any case, do you really want to drink that?"
	taste_description = "pure alcohol"
	color = "#4C3100"
	proof = 100
	toxicity = 2

	glass_name = "Hooch"
	glass_desc = "You've really hit rock bottom now... your liver packed its bags and left last night."

/datum/reagent/ethanol/iced_beer
	name = "Iced Beer"
	id = "iced_beer"
	description = "A beer which is so cold the air around it freezes."
	taste_description = "refreshingly cold"
	color = "#FFD300"
	proof = BEER
	adj_temp = -20
	targ_temp = 280

	glass_name = "Iced Beer"
	glass_desc = "A beer so frosty, the air around it freezes."
	glass_special = list(DRINK_ICE)

/datum/reagent/ethanol/irishcarbomb
	name = "Irish Car Bomb"
	id = "irishcarbomb"
	description = "Mmm, tastes like chocolate cake..."
	taste_description = "delicious anger"
	color = "#2E6671"
	proof = (BEER+IRISH_CREAM)/2

	glass_name = "Irish Car Bomb"
	glass_desc = "An irish car bomb."

/datum/reagent/ethanol/coffee/irishcoffee
	name = "Irish Coffee"
	id = "irishcoffee"
	description = "Coffee, and alcohol. More fun than a Mimosa to drink in the morning."
	taste_description = "giving up on the day"
	color = "#4C3100"
	proof = IRISH_CREAM/2

	glass_name = "Irish coffee"
	glass_desc = "Coffee and alcohol. More fun than a Mimosa to drink in the morning."

/datum/reagent/ethanol/longislandicedtea
	name = "Long Island Iced Tea"
	id = "longislandicedtea"
	description = "The liquor cabinet, brought together in a delicious mix. Intended for middle-aged alcoholic women only."
	taste_description = "sweet tea, with a kick"
	color = "#895B1F"
	proof = (VODKA+GIN+TEQUILA+RUM)/4

	glass_name = "Long Island iced tea"
	glass_desc = "The liquor cabinet, brought together in a delicious mix. Intended for middle-aged alcoholic women only."

/datum/reagent/ethanol/manhattan
	name = "Manhattan"
	id = "manhattan"
	description = "The Detective's undercover drink of choice. He never could stomach gin..."
	taste_description = "mild dryness"
	color = "#C13600"
	proof = (2*WHISKEY+VERMOUTH)/3

	glass_name = "Manhattan"
	glass_desc = "The Detective's undercover drink of choice. He never could stomach gin..."

/datum/reagent/ethanol/manhattan_proj
	name = "Manhattan Project"
	id = "manhattan_proj"
	description = "A scientist's drink of choice, for pondering ways to blow up the station."
	taste_description = "death, the destroyer of worlds"
	color = "#C15D00"
	proof = 200 // don't question it
	druggy = 30

	glass_name = "Manhattan Project"
	glass_desc = "A scientist's drink of choice, for thinking how to blow up the station."

/datum/reagent/ethanol/manly_dorf
	name = "The Manly Dorf"
	id = "manlydorf"
	description = "Beer and Ale, brought together in a delicious mix. Intended for true men only."
	taste_description = "hair on your chest and your chin"
	color = "#4C3100"
	proof = BEER

	glass_name = "The Manly Dorf"
	glass_desc = "A manly concotion made from Ale and Beer. Intended for true men only."

/datum/reagent/ethanol/margarita
	name = "Margarita"
	id = "margarita"
	description = "On the rocks with salt on the rim. Arriba~!"
	taste_description = "dry and salty"
	color = "#8CFF8C"
	proof = TEQUILA/3

	glass_name = "Margarita"
	glass_desc = "On the rocks with salt on the rim. Arriba~!"

/datum/reagent/ethanol/neurotoxin
	name = "Neurotoxin"
	id = "neurotoxin"
	description = "A strong neurotoxin that puts the subject into a death-like state."
	taste_description = "a numbing sensation"
	reagent_state = REAGENT_LIQUID
	color = "#2E2E61"
	proof = 200

	glass_name = "Neurotoxin"
	glass_desc = "A drink that is guaranteed to knock you silly."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list("neuroright")

/datum/reagent/ethanol/neurotoxin/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	M.afflict_paralyze(20 * 3)

/datum/reagent/ethanol/patron
	name = "Patron"
	id = "patron"
	description = "Tequila with silver in it, a favorite of alcoholic women in the club scene."
	taste_description = "metallic paint thinner"
	color = "#585840"
	proof = TEQUILA

	glass_name = "Patron"
	glass_desc = "Drinking patron in the bar, with all the subpar ladies."

/datum/reagent/ethanol/pwine
	name = "Poison Wine"
	id = "pwine"
	description = "Is this even wine? Toxic! Hallucinogenic! Probably consumed in boatloads by your superiors!"
	color = "#000000"
	proof = WINE
	druggy = 50
	halluci = 10

	glass_name = "???"
	glass_desc = "A black ichor with an oily purple sheer on top. Are you sure you should drink this?"

/datum/reagent/ethanol/pwine/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(. > 30)
		M.adjustToxLoss(2 * removed)
	if(. > 60 && ishuman(M) && prob(5))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/heart/L = H.internal_organs_by_name[O_HEART]
		if (L && istype(L))
			if(. < 120)
				L.take_damage(10 * removed)
			else
				L.take_damage(100)

/datum/reagent/ethanol/red_mead
	name = "Red Mead"
	id = "red_mead"
	description = "The true Viking's drink! Even though it has a strange red color."
	taste_description = "sweet and salty alcohol"
	color = "#C73C00"
	proof = MEAD/2
	blood_content = 0.5

	glass_name = "Red Mead"
	glass_desc = "A true Viking's beverage, though its color is strange."

/datum/reagent/ethanol/sbiten
	name = "Sbiten"
	id = "sbiten"
	description = "A spicy Vodka! Might be a bit hot for the little guys!"
	taste_description = "hot and spice"
	color = "#FFA371"
	proof = VODKA
	adj_temp = 50
	targ_temp = 360

	glass_name = "Sbiten"
	glass_desc = "A spicy mix of Vodka and Spice. Very hot."

/datum/reagent/drink/silencer
	name = "Silencer"
	id = "silencer"
	description = "A drink from Mime Heaven."
	taste_description = "a pencil eraser"
	taste_mult = 1.2
	nutrition = 1
	color = "#FFFFFF"

	glass_name = "Silencer"
	glass_desc = "A drink from mime Heaven."

/datum/reagent/ethanol/singulo
	name = "Singulo"
	id = "singulo"
	description = "A blue-space beverage!"
	taste_description = "concentrated matter"
	color = "#2E6671"
	proof = 200 // one of those things you just shouldn't question

	glass_name = "Singulo"
	glass_desc = "A blue-space beverage."

/datum/reagent/ethanol/snowwhite
	name = "Snow White"
	id = "snowwhite"
	description = "A cold refreshment"
	taste_description = "refreshing cold"
	color = "#FFFFFF"
	proof = BEER/2

	glass_name = "Snow White"
	glass_desc = "A cold refreshment."

/datum/reagent/ethanol/suidream
	name = "Sui Dream"
	id = "suidream"
	description = "Comprised of: White soda, blue curacao, melon liquor."
	taste_description = "fruit"
	color = "#00A86B"
	proof = (MELON_LIQUOR+CURACAO)/3

	glass_name = "Sui Dream"
	glass_desc = "A froofy, fruity, and sweet mixed drink. Understanding the name only brings shame."

/datum/reagent/ethanol/whiskey_cola
	name = "Whiskey Cola"
	id = "whiskeycola"
	description = "Whiskey, mixed with cola. Surprisingly refreshing."
	taste_description = "cola with an alcoholic undertone"
	color = "#3E1B00"
	proof = WHISKEY/3

	glass_name = "Whiskey Cola"
	glass_desc = "An innocent-looking mixture of cola and Whiskey. Delicious."

/datum/reagent/ethanol/syndicatebomb
	name = "Syndicate Bomb"
	id = "syndicatebomb"
	description = "Tastes like terrorism!"
	taste_description = "terrorism"
	color = "#2E6671"
	proof = ((WHISKEY/3)+BEER)/2

	glass_name = "Syndicate Bomb"
	glass_desc = "Tastes like terrorism!"

/datum/reagent/ethanol/tequila_sunrise
	name = "Tequila Sunrise"
	id = "tequilasunrise"
	description = "Tequila and orange juice. Much like a Screwdriver, only Mexican~."
	taste_description = "oranges"
	color = "#FFE48C"
	proof = TEQUILA/3

	glass_name = "Tequila Sunrise"
	glass_desc = "Oh great, now you feel nostalgic about sunrises back on Earth..."

/datum/reagent/ethanol/threemileisland
	name = "Three Mile Island Iced Tea"
	id = "threemileisland"
	description = "Made for a woman, strong enough for a man."
	taste_description = "dry"
	color = "#666340"
	proof = 200
	druggy = 50

	glass_name = "Three Mile Island iced tea"
	glass_desc = "A glass of this is sure to prevent a meltdown."

/datum/reagent/ethanol/toxins_special
	name = "Toxins Special"
	id = "phoronspecial"
	description = "This thing is literally on fire!"
	taste_description = "spicy toxins"
	reagent_state = REAGENT_LIQUID
	color = "#7F00FF"
	proof = 200
	adj_temp = 15
	targ_temp = 330

	glass_name = "Toxins Special"
	glass_desc = "Whoah, this thing is on fire!"

/datum/reagent/ethanol/vodkamartini
	name = "Vodka Martini"
	id = "vodkamartini"
	description = "Vodka with Gin. Not quite how 007 enjoyed it, but still delicious."
	taste_description = "shaken, not stirred"
	color = "#0064C8"
	proof = (2*VODKA+VERMOUTH)/3

	glass_name = "Vodka Martini"
	glass_desc ="A bastardization of the classic martini. Still great."


/datum/reagent/ethanol/vodkatonic
	name = "Vodka and Tonic"
	id = "vodkatonic"
	description = "For when a gin and tonic isn't russian enough."
	taste_description = "tart bitterness"
	color = "#0064C8" // rgb: 0, 100, 200
	proof = VODKA/3

	glass_name = "Vodka and Tonic"
	glass_desc = "For when a gin and tonic isn't Russian enough."


/datum/reagent/ethanol/white_russian
	name = "White Russian"
	id = "whiterussian"
	description = "That's just, like, your opinion, man..."
	taste_description = "coffee icecream"
	color = "#A68340"
	proof = BLACK_RUSSIAN*2/3

	glass_name = "White Russian"
	glass_desc = "A very nice looking drink. But that's just, like, your opinion, man."


/datum/reagent/ethanol/whiskeysoda
	name = "Whiskey Soda"
	id = "whiskeysoda"
	description = "Ultimate refreshment."
	taste_description = "carbonated whiskey"
	color = "#EAB300"
	proof = WHISKEY/3

	glass_name = "Whiskey Soda"
	glass_desc = "Ultimate refreshment."

#define WHISKEY_SPECIAL_BLEND 160

/datum/reagent/ethanol/specialwhiskey // I have no idea what this is and where it comes from
	name = "Special Blend Whiskey"
	id = "specialwhiskey"
	description = "Just when you thought regular station whiskey was good... This silky, amber goodness has to come along and ruin everything. The smell of it singes your nostrils."
	taste_description = "unspeakable whiskey bliss"
	color = "#523600"
	proof = WHISKEY_SPECIAL_BLEND

	glass_name = "special blend whiskey"
	glass_desc = "Just when you thought regular station whiskey was good... This silky, amber goodness has to come along and ruin everything."

/datum/reagent/ethanol/unathiliquor
	name = "Redeemer's Brew"
	id = "unathiliquor"
	description = "This barely qualifies as a drink, and could give jet fuel a run for its money. Also known to cause feelings of euphoria and numbness."
	taste_description = "spiced numbness"
	color = "#242424"
	proof = 300 // unathi have unlocked secrets unknown to others

	glass_name = "Redeemer's Brew"
	glass_desc = "This barely qualifies as a drink, and may cause euphoria and numbness. Imbiber beware!"

/datum/reagent/ethanol/unathiliquor/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	if(alien == IS_UNATHI)
		return
	if(alien == IS_NARAMADI)
		return
	var/drug_strength = 10
	if(alien == IS_SKRELL)
		drug_strength = drug_strength * 0.8

	M.druggy = max(M.druggy, drug_strength)
	if(prob(10) && isturf(M.loc) && !istype(M.loc, /turf/space) && CHECK_MOBILITY(M, MOBILITY_CAN_MOVE))
		step(M, pick(GLOB.cardinal))

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
	if(metabolism.cycles_so_far == 1)
		to_chat(M, "<span class='danger'>You feel like your insides are burning!</span>")
	else
		M.apply_effect(4, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	metabolism.legacy_current_holder.remove_reagent(/datum/reagent/frostoil, 5)

/datum/reagent/ethanol/sakebomb
	name = "Sake Bomb"
	id = "sakebomb"
	description = "Alcohol in more alcohol."
	taste_description = "thick, dry alcohol"
	color = "#FFFF7F"
	proof = (2*BEER+SAKE)/3
	nutriment_factor = 1

	glass_name = "Sake Bomb"
	glass_desc = "Some sake mixed into a pint of beer."

/datum/reagent/ethanol/tamagozake
	name = "Tamagozake"
	id = "tamagozake"
	description = "Sake, egg, and sugar. A disgusting folk cure."
	taste_description = "eggy booze"
	color = "#E8C477"
	proof = SAKE*10/5
	nutriment_factor = 3

	glass_name = "Tamagozake"
	glass_desc = "An egg cracked into sake and sugar."

/datum/reagent/ethanol/ginzamary
	name = "Ginza Mary"
	id = "ginzamary"
	description = "An alcoholic drink made with vodka, sake, and juices."
	taste_description = "spicy tomato sake"
	color = "#FF3232"
	proof = (SAKE+VODKA)/3

	glass_name = "Ginza Mary"
	glass_desc = "Tomato juice, vodka, and sake make something not quite completely unlike a Bloody Mary."

/datum/reagent/ethanol/tokyorose
	name = "Tokyo Rose"
	id = "tokyorose"
	description = "A pale pink cocktail made with sake and berry juice."
	taste_description = "fruity booze"
	color = "#FA8072"
	proof = SAKE/2

	glass_name = "Tokyo Rose"
	glass_desc = "It's kinda pretty!"

/datum/reagent/ethanol/saketini
	name = "Saketini"
	id = "saketini"
	description = "For when you're too weeb for a real martini."
	taste_description = "dry alcohol"
	color = "#0064C8"
	proof = (SAKE+GIN)/2

	glass_name = "Saketini"
	glass_desc = "What are you doing drinking this outside of New Kyoto?"

/datum/reagent/ethanol/coffee/elysiumfacepunch
	name = "Elysium Facepunch"
	id = "elysiumfacepunch"
	description = "A loathsome cocktail favored by Heaven's skeleton shift workers."
	taste_description = "sour coffee"
	color = "#8f7729"
	proof = KAHLUA/2

	glass_name = "Elysium Facepunch"
	glass_desc = "A loathsome cocktail favored by Heaven's skeleton shift workers."

/datum/reagent/ethanol/erebusmoonrise
	name = "Erebus Moonrise"
	id = "erebusmoonrise"
	description = "A deeply alcoholic mix, popular in Nyx."
	taste_description = "hard alcohol"
	color = "#947459"
	proof = (WHISKEY+VODKA+TEQUILA)/3

	glass_name = "Erebus Moonrise"
	glass_desc = "A deeply alcoholic mix, popular in Nyx."

/datum/reagent/ethanol/balloon
	name = "Balloon"
	id = "balloon"
	description = "A strange drink invented in the aerostats of Venus."
	taste_description = "strange alcohol"
	color = "#FAEBD7"
	proof = CURACAO/2

	glass_name = "Balloon"
	glass_desc = "A strange drink invented in the aerostats of Venus."

/datum/reagent/ethanol/natunabrandy
	name = "Natuna Brandy"
	id = "natunabrandy"
	description = "On Natuna, they do the best with what they have."
	taste_description = "watered-down beer"
	color = "#FFFFCC"
	proof = BEER/3

	glass_name = "Natuna Brandy"
	glass_desc = "On Natuna, they do the best with what they have."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/euphoria
	name = "Euphoria"
	id = "euphoria"
	description = "Invented by a Eutopian marketing team, this is one of the most expensive cocktails in existence."
	taste_description = "impossibly rich alcohol"
	color = "#614126"
	proof = (2*COGNAC+WHISKEY_SPECIAL_BLEND)/3

	glass_name = "Euphoria"
	glass_desc = "Invented by a Eutopian marketing team, this is one of the most expensive cocktails in existence."

/datum/reagent/ethanol/xanaducannon
	name = "Xanadu Cannon"
	id = "xanaducannon"
	description = "Common in the entertainment districts of Titan."
	taste_description = "sweet alcohol"
	color = "#614126"
	proof = BEER/2

	glass_name = "Xanadu Cannon"
	glass_desc = "Common in the entertainment districts of Titan."

/datum/reagent/ethanol/debugger
	name = "Debugger"
	id = "debugger"
	description = "From Shelf. Not for human consumption."
	taste_description = "oily bitterness"
	color = "#d3d3d3"
	proof = 60 // it's magic

	glass_name = "Debugger"
	glass_desc = "From Shelf. Not for human consumption."

/datum/reagent/ethanol/spacersbrew
	name = "Spacer's Brew"
	id = "spacersbrew"
	description = "Ethanol and orange soda. A common emergency drink on frontier colonies."
	taste_description = "bitter oranges"
	color = "#ffc04c"
	proof = 40 // literally 4 parts something else to 1 part ethanol

	glass_name = "Spacer's Brew"
	glass_desc = "Ethanol and orange soda. A common emergency drink on frontier colonies."

/datum/reagent/ethanol/binmanbliss
	name = "Binman Bliss"
	id = "binmanbliss"
	description = "A dry cocktail popular on Binma."
	taste_description = "very dry alcohol"
	color = "#c3c3c3"
	proof = (SAKE+TEQUILA)/2

	glass_name = "Binman Bliss"
	glass_desc = "A dry cocktail popular on Binma."

/datum/reagent/ethanol/chrysanthemum
	name = "Chrysanthemum"
	id = "chrysanthemum"
	description = "An exotic cocktail from New Kyoto."
	taste_description = "fruity liquor"
	color = "#9999FF"
	proof = (SAKE+MELON_LIQUOR)/2

	glass_name = "Chrysanthemum"
	glass_desc = "An exotic cocktail from New Kyoto."

/datum/reagent/ethanol/soemmerfire
	name = "Soemmer Fire"
	id = "soemmerfire"
	description = "A painfully hot mixed drink, for when you absolutely need to hurt right now."
	taste_description = "pure fire"
	color = "#d13b21" // rgb(209, 59, 33)
	proof = (2*WHISKEY+VERMOUTH)/3*2/3

	glass_name = "Soemmer Fire"
	glass_desc = "A painfully hot mixed drink, for when you absolutely need to hurt right now."

/datum/reagent/ethanol/soemmerfire/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.bodytemperature += 10 * TEMPERATURE_DAMAGE_COEFFICIENT

/datum/reagent/ethanol/morningafter
	name = "Morning After"
	id = "morningafter"
	description = "The finest hair of the dog, coming up!"
	taste_description = "bitter regrets"
	color = "#482000" // rgb(72, 32, 0)
	proof = VODKA/6

	glass_name = "Morning After"
	glass_desc = "The finest hair of the dog, coming up!"

/datum/reagent/ethanol/vesper
	name = "Vesper"
	id = "vesper"
	description = "A dry martini, ice cold and well shaken."
	taste_description = "lemony class"
	color = "#cca01c" // rgb(204, 160, 28)
	proof = (GIN*3+VODKA+WINE)/5

	glass_name = "Vesper"
	glass_desc = "A dry martini, ice cold and well shaken."

/datum/reagent/ethanol/rotgut
	name = "Rotgut Fever Dream"
	id = "rotgut"
	description = "A heinous combination of clashing flavors."
	taste_description = "plague and coldsweats"
	color = "#3a6617" // rgb(58, 102, 23)
	proof = (VODKA*3+RUM+WHISKEY)/8

	glass_name = "Rotgut Fever Dream"
	glass_desc = "Why are you doing this to yourself?"

/datum/reagent/ethanol/voxdelight
	name = "Vox's Delight"
	id = "voxdelight"
	description = "A dangerous combination of all things flammable. Why would you drink this?"
	taste_description = "corrosive death"
	color = "#7c003a" // rgb(124, 0, 58)
	proof = 150

	glass_name = "Vox's Delight"
	glass_desc = "Not recommended if you enjoy having organs."

/datum/reagent/ethanol/voxdelight/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	if(alien == IS_VOX)
		M.adjustToxLoss(-0.5 * removed)
		return
	else
		M.adjustToxLoss(3 * removed)

/datum/reagent/ethanol/screamingviking
	name = "Screaming Viking"
	id = "screamingviking"
	description = "A boozy, citrus-packed brew."
	taste_description = "the bartender's frustration"
	color = "#c6c603" // rgb(198, 198, 3)
	proof = (MARTINI*2+VODKA/3+RUM)/6

	glass_name = "Screaming Viking"
	glass_desc = "A boozy, citrus-packed brew."

/datum/reagent/ethanol/robustin
	name = "Robustin"
	id = "robustin"
	description = "A bootleg brew of all the worst things on station."
	taste_description = "cough syrup and fire"
	color = "#6b0145" // rgb(107, 1, 69)
	proof = 150

	glass_name = "Robustin"
	glass_desc = "A bootleg brew of all the worst things on station."

/datum/reagent/ethanol/virginsip
	name = "Virgin Sip"
	id = "virginsip"
	description = "A perfect martini, watered down and ruined."
	taste_description = "emasculation and failure"
	color = "#2E6671" // rgb(46, 102, 113)
	proof = GIN*0.75

	glass_name = "Virgin Sip"
	glass_desc = "A perfect martini, watered down and ruined."

/datum/reagent/ethanol/jellyshot
	name = "Jelly Shot"
	id = "jellyshot"
	description = "A thick and vibrant alcoholic gel, perfect for the night life."
	taste_description = "thick, alcoholic cherry gel"
	color = "#e00b0b" // rgb(224, 11, 11)
	proof = VODKA/5

	glass_name = "Jelly Shot"
	glass_desc = "A thick and vibrant alcoholic gel, perfect for the night life."

/datum/reagent/ethanol/slimeshot
	name = "Named Bullet"
	id = "slimeshot"
	description = "A thick and toxic slime jelly shot."
	taste_description = "liquified organs"
	color = "#6fa300" // rgb(111, 163, 0)
	proof = VODKA*2

	glass_name = "Named Bullet"
	glass_desc = "A thick slime jelly shot. You can feel your death approaching."

/datum/reagent/ethanol/slimeshot/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_DIONA)
		return
	M.reagents.add_reagent("slimejelly", 0.25)

/datum/reagent/ethanol/cloverclub
	name = "Clover Club"
	id = "cloverclub"
	description = "A light and refreshing rasberry cocktail."
	taste_description = "sweet raspberry"
	color = "#dd00a6" // rgb(221, 0, 166)
	proof = GIN/5

	glass_name = "Clover Club"
	glass_desc = "A light and refreshing rasberry cocktail."

/datum/reagent/ethanol/negroni
	name = "Negroni"
	id = "negroni"
	description = "A dark, complicated mix of gin and campari... classy."
	taste_description = "summer nights and wood smoke"
	color = "#77000d" // rgb(119, 0, 13)
	proof = (GIN+BITTERS+VERMOUTH)/3

	glass_name = "Negroni"
	glass_desc = "A dark, complicated blend, perfect for relaxing nights by the fire."

/datum/reagent/ethanol/whiskeysour
	name = "Whiskey Sour"
	id = "whiskeysour"
	description = "A smokey, refreshing lemoned whiskey."
	taste_description = "smoke and citrus"
	color = "#a0692e" // rgb(160, 105, 46)
	proof = WHISKEY/2

	glass_name = "Whiskey Sour"
	glass_desc = "A smokey, refreshing lemoned whiskey."

/datum/reagent/ethanol/oldfashioned
	name = "Old Fashioned"
	id = "oldfashioned"
	description = "A classic mix of whiskey and sugar... simple and direct."
	taste_description = "smokey, divine whiskey"
	color = "#774410" // rgb(119, 68, 16)
	proof = (WHISKEY+BITTERS)/3

	glass_name = "Old Fashioned"
	glass_desc = "A classic mix of whiskey and sugar... simple and direct."

/datum/reagent/ethanol/daiquiri
	name = "Daiquiri"
	id = "daiquiri"
	description = "Refeshing rum and citrus. Time for a tropical get away."
	taste_description = "refreshing citrus and rum"
	color = "#d1ff49" // rgb(209, 255, 73
	proof = RUM*3/5

	glass_name = "Daiquiri"
	glass_desc = "Refeshing rum and citrus. Time for a tropical get away."

/datum/reagent/ethanol/mojito
	name = "Mojito"
	id = "mojito"
	description = "Minty rum and citrus, made for sailing."
	taste_description = "minty rum and lime"
	color = "#d1ff49" // rgb(209, 255, 73
	proof = RUM/5

	glass_name = "Mojito"
	glass_desc = "Minty rum and citrus, made for sailing."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/paloma
	name = "Paloma"
	id = "paloma"
	description = "Tequila and citrus, iced just right..."
	taste_description = "grapefruit and cold fire"
	color = "#ffb070" // rgb(255, 176, 112)
	proof = TEQUILA/3

	glass_name = "Paloma"
	glass_desc = "Tequila and citrus, iced just right..."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/piscosour
	name = "Pisco Sour"
	id = "piscosour"
	description = "Wine Brandy, Lemon, and a dream. A South American classic"
	taste_description = "light sweetness"
	color = "#f9f96b" // rgb(249, 249, 107)
	proof = BRANDY/3

	glass_name = "Pisco Sour"
	glass_desc = "South American bliss, served ice cold."

/datum/reagent/ethanol/coldfront
	name = "Cold Front"
	id = "coldfront"
	description = "Minty, rich, and painfully cold. It's a blizzard in a cup."
	taste_description = "biting cold"
	color = "#ffe8c4" // rgb(255, 232, 196)
	proof = WHISKEY/3
	adj_temp = -20
	targ_temp = 220 //Dangerous to certain races. Drink in moderation.

	glass_name = "Cold Front"
	glass_desc = "Minty, rich, and painfully cold. It's a blizzard in a cup."

/datum/reagent/ethanol/mintjulep
	name = "Mint Julep"
	id = "mintjulep"
	description = "Minty and refreshing, perfect for a hot day."
	taste_description = "refreshing mint"
	color = "#bbfc8a" // rgb(187, 252, 138)
	proof = WHISKEY/3
	adj_temp = -5

	glass_name = "Mint Julep"
	glass_desc = "Minty and refreshing, perfect for a hot day."

/datum/reagent/ethanol/godsake
	name = "Gods Sake"
	id = "godsake"
	description = "Anime's favorite drink."
	taste_description = "the power of god and anime"
	color = "#DDDDDD"
	proof = SAKE

	glass_name = "God's Sake"
	glass_desc = "A glass of sake."

/datum/reagent/ethanol/godka
	name = "Godka"
	id = "godka"
	description = "Number one drink AND fueling choice for Russians multiverse-wide."
	taste_description = "russian steel and a hint of grain"
	color = "#0064C8"
	proof = 200

	glass_name = "Godka"
	glass_desc = "The glass is barely able to contain the wodka. Xynta."
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/godka/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	M.cure_radiation(RAD_MOB_CURE_STRENGTH_GODKA(removed * .))
	if(. && ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.has_organ[O_LIVER])
			var/obj/item/organ/L = H.internal_organs_by_name[O_LIVER]
			if(!L)
				return
			var/adjust_liver = rand(-3, 2)
			if(prob(L.damage))
				to_chat(M, "<span class='cult'>You feel woozy...</span>")
			L.damage = max(L.damage + (adjust_liver * removed), 0)
	var/adjust_tox = rand(-4, 2)
	M.adjustToxLoss(adjust_tox * removed)

#define HOLYWINE 100

/datum/reagent/ethanol/holywine
	name = "Angel Ichor"
	id = "holywine"
	description = "A premium alchoholic beverage made from distilled angel blood."
	taste_description = "wings in a glass, and a hint of grape"
	color = "#C4921E"
	proof = HOLYWINE

	glass_name = "Angel Ichor"
	glass_desc = "A very pious looking drink."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/ethanol/holy_mary
	name = "Holy Mary"
	id = "holymary"
	description = "A strange yet pleasurable mixture made of vodka, angel's ichor and lime juice. Or at least you THINK the yellow stuff is angel's ichor."
	taste_description = "grapes with a hint of lime"
	color = "#DCAE12"
	proof = (2*VODKA+3*HOLYWINE)/6

	glass_name = "Holy Mary"
	glass_desc = "Angel's Ichor, mixed with Vodka and a lil' bit of lime. Tastes like liquid ascension."

/datum/reagent/ethanol/angelswrath
	name = "Angels Wrath"
	id = "angelswrath"
	description = "This thing makes the hair on the back of your neck stand up."
	taste_description = "sweet victory and sour iron"
	taste_mult = 1.5
	color = "#F3C906"
	proof = (RUM+HOLYWINE)/6

	glass_name = "Angels' Wrath"
	glass_desc = "Just looking at this thing makes you sweat."
	glass_icon = DRINK_ICON_NOISY
	glass_special = list(DRINK_FIZZ)

/datum/reagent/ethanol/angelskiss
	name = "Angels Kiss"
	id = "angelskiss"
	description = "Miracle time!"
	taste_description = "sweet forgiveness and bitter iron"
	color = "#AD772B"
	proof = (HOLYWINE+KAHLUA+RUM)/3

	glass_name = "Angel's Kiss"
	glass_desc = "Miracle time!"

/datum/reagent/ethanol/ichor_mead
	name = "Ichor Mead"
	id = "ichor_mead"
	description = "A trip to Valhalla."
	taste_description = "valhalla"
	color = "#955B37"
	proof = (HOLYWINE+MEAD)/2

	glass_name = "Ichor Mead"
	glass_desc = "A trip to Valhalla."

/datum/reagent/drink/soda/gibbfloat
	name = "Gibbfloat"
	id = "gibbfloat"
	description = "A tasty, frothy drink."
	taste_description = "soda float"

	glass_name = "Gibbfloat"
	glass_desc = "A tasty, frothy drink"

/datum/reagent/ethanol/planterspunch
	name = "Planters Punch"
	id = "planterspunch"
	description = "A refreshing drink for the aspiring botanist."
	taste_description = "happy plants"
	color = "#F07800"
	proof = RUM/5

	glass_name = "Planters Punch"
	glass_desc = "A refreshing drink for the aspiring botanist."

/datum/reagent/ethanol/olympusmons
	name = "Olympus Mons"
	id = "olympusmons"
	description = "For those that need the extra kick."
	taste_description = "stronge coffee infused booze"
	proof = (BLACK_RUSSIAN+WHISKEY+RUM)/3

	glass_name = "Olympus Mons"
	glass_desc = "For those that need the extra kick."

/datum/reagent/ethanol/sazerac
	name = "Sazerac"
	id = "sazerac"
	description = "When a regular whiskey cocktail isn't enough."
	taste_description = "a strong bite of flavor"
	proof = (2*COGNAC+ABSINTHE+BITTERS)/3

	glass_name = "Sazerac"
	glass_desc = "When a regular whiskey cocktail isn't enough."

/datum/reagent/ethanol/junglejuice
	name = "Jungle Juice"
	id = "junglejuice"
	description = "An overload of sweetness and sugary goodness."
	taste_description = "fruits and bad decisions"
	proof = (VODKA+RUM)/5

	glass_name = "Jungle Juice"
	glass_desc = "An overload of sweetness and sugary goodness."

/datum/reagent/ethanol/gimlet
	name = "Gimlet"
	id = "gimlet"
	description = "For those who want to look fancy with their gin."
	taste_description = "lime infused tree"
	proof = GIN/3

	glass_name = "Gimlet"
	glass_desc = "For those who want to look fancy with their gin."

/datum/reagent/ethanol/firepunch
	name = "Fire Punch"
	id = "firepunch"
	description = "A spicy take on a summer classic."
	taste_description = "rum and sugar"
	proof = RUM/3
	targ_temp = 300

	glass_name = "Fire Punch"
	glass_desc = "A spicy take on a summer classic."

/datum/reagent/ethanol/newsheriff
	name = "New Sheriff"
	id = "newsheriff"
	description = "A drink to make your saddles blaze!"
	taste_description = "an earthy kick with a lingering burn"
	proof = (WHISKEY+COGNAC)/3

	glass_name = "New Sheriff"
	glass_desc = "A drink to make your saddles blaze!"

/datum/reagent/ethanol/thehuckleberry
	name = "The Huckleberry"
	id = "thehuckleberry"
	description = "If I thought you weren't my best customer, I just don't think I could bear it."
	taste_description = "sweet fruits masking barrel-aged wit"
	proof = WHISKEY/3
	adj_temp = -10

	glass_name = "The Huckleberry"
	glass_desc = "If I thought you weren't my best customer, I just don't think I could bear it."

/datum/reagent/ethanol/quickdraw
	name = "Quickdraw"
	id = "quickdraw"
	description = "Nobody was faster than Beauregard. Nobody could outdraw him. Nobody could aim as true as old Jack. If he died, Nobody saw him."
	taste_description = "aged herbs and gunsmoke"
	proof = (RUM+BITTERS)/3

	glass_name = "Quickdraw"
	glass_desc = "Nobody was faster than Beauregard. Nobody could outdraw him. Nobody could aim as true as old Jack. If he died, Nobody saw him."

/datum/reagent/ethanol/dmhand
	name = "Dead Man's Hand"
	id = "dmhand"
	description = "If you find yourself drinking this during a game of poker, keep your back to the wall."
	taste_description = "a pair of classics and a licorice surprise"
	proof = (WHISKEY+RUM)/3

	glass_name = "Dead Man's Hand"
	glass_desc = "If you find yourself drinking this during a game of poker, keep your back to the wall."

/datum/reagent/ethanol/snakeoil
	name = "Snake Oil"
	id = "snakeoil"
	description = "A 'healthy' potion with a bite! Now with 56% less Arsenic."
	taste_description = "sour alcohol and something metallic"
	proof = ABSINTHE/3
	druggy = 15
	toxicity = 2
	adj_temp = 5

	glass_name = "Snake Oil"
	glass_desc = "A 'healthy' potion with a bite! Now with 56% less Arsenic."

/datum/reagent/ethanol/highnoon
	name = "High Noon"
	id = "highnoon"
	description = "There's two kinds of people here on the Frontier, partner. Those with guns, and those who drink. You drink."
	taste_description = "aged whiskey and earthy metals"
	proof = WHISKEY/5
	adj_temp = 2

	glass_name = "High Noon"
	glass_desc = "There's two kinds of people here on the Frontier, partner. Those with guns, and those who drink. You drink."

/datum/reagent/ethanol/bloodmeridian
	name = "Blood Meridian"
	id = "bloodmeridian"
	description = "The perfect drink for when you want to dance and fiddle all night. Does it work? You be The Judge."
	taste_description = "lingering regret, gunpowder, and blood"
	proof = 40
	blood_content = 0.4

	glass_name = "Blood Meridian"
	glass_desc = "The perfect drink for when you want to dance and fiddle all night. Does it work? You be The Judge."

/datum/reagent/ethanol/theoutlaw
	name = "The Outlaw"
	id = "theoutlaw"
	description = "If you're planning to cheat or rob 'em, you gotta be quick. Either on the draw, or on your horse."
	taste_description = "a violent life on the run"
	proof = (VODKA+BITTERS)/3

	glass_name = "The Outlaw"
	glass_desc = "If you're planning to cheat or rob 'em, you gotta be quick. Either on the draw, or on your horse."

/datum/reagent/ethanol/thelawman
	name = "The Lawman"
	id = "thelawman"
	description = "They ran out five men before I took up the badge. Since then I've hung twenty."
	taste_description = "robust coffee and an open campfire"
	proof = WHISKEY/5
	adj_temp = 25

	glass_name = "The Lawman"
	glass_desc = "They ran out five men before I took up the badge. Since then I've hung twenty."

/datum/reagent/ethanol/hangmansnoose
	name = "Hangman's Noose"
	id = "hangmansnoose"
	description = "To some looking at their final days in a cell, this drink is a better mercy than the gallows. Doesn't make it go down any easier."
	taste_description = "a dusty rope and blood in the nostrils"
	proof = 100
	toxicity = 10

	glass_name = "Hangman's Noose"
	glass_desc = "To some looking at their final days in a cell, this drink is a better mercy than the gallows. Doesn't make it go down any easier."

/datum/reagent/ethanol/bigiron
	name = "Big Iron"
	id = "bigiron"
	description = "Have this one, partner. Then have nineteen more."
	taste_description = "a mysterious visit and the red Texas sky"
	proof = RUM*2/3

	glass_name = "Big Iron"
	glass_desc = "Have this one, partner. Then have nineteen more."

/datum/reagent/ethanol/lastcactus
	name = "Last Cactus"
	id = "lastcactus"
	description = "If you can get past its spines, it's filled with cool, clear water."
	taste_description = "refreshing sweetness and a cold burn"
	proof = VODKA/5
	adj_temp = -10

	glass_name = "Last Cactus"
	glass_desc = "If you can get past its spines, it's filled with cool, clear water."

/datum/reagent/ethanol/thebestboy
	name = "The Best Boy"
	id = "thebestboy"
	description = "An eternal tribute to the best crewmember to ever work on Space Station 13. Keep away from washing machines."
	taste_description = "cool cream, refreshing orange, and strong alcohol"
	proof = SCREWDRIVERCOCKTAIL*3/5
	adj_temp = -5

	glass_name = "The Best Boy"
	glass_desc = "An eternal tribute to the best crewmember to ever work on Space Station 13. Keep away from washing machines."

/datum/reagent/ethanol/phobos
	name = "Phobos"
	id = "phobos"
	description = "A drink invented by Tyrmalin Moonshiners to cope with the harsh Martian climate."
	taste_description = "grain alcohol"
	proof = 150

	glass_name = "Phobos"
	glass_desc = "A drink invented by Tyrmalin Moonshiners to cope with the harsh Martian climate."

/datum/reagent/ethanol/greenstuff
	name = "Green Stuff"
	id = "greenstuff"
	description = "Tyrmalin grog aggressively blended with unfiltered absinthe."
	taste_description = "black licorice and thick malt"
	proof = 300 // again: how do they do it?

	glass_name = "Green Stuff"
	glass_desc = "Tyrmalin grog aggressively blended with unfiltered absinthe."

/datum/reagent/ethanol/goliathspit
	name = "Goliath Spit"
	id = "goliathspit"
	description = "This warm, thick drink has a subtle, tangy sweetness to it. Although visually reminiscent of lava, it's actually very hydrating!"
	taste_description = "faint, tangy sweetness"
	color = "#CCCC99"
	proof = (WHISKEY+CIDER)/5
	adj_temp = -5

	glass_name = "Goliath Spit"
	glass_desc = "This warm, thick drink has a subtle, tangy sweetness to it. Although visually reminiscent of lava, it's actually very hydrating!"

/datum/reagent/ethanol/maryonacross
	name = "Mary On a Cross"
	id = "maryonacross"
	description = "Not just another Bloody Mary. Mary on a cross."
	taste_description = "copper, tomatoes, and heretical sweetness"
	color = "#B40000"
	proof = (VODKA/3+VODKA)/5
	blood_content = 0.2

	glass_name = "Mary On a Cross"
	glass_desc = "Not just another Bloody Mary. Mary on a cross."

/datum/reagent/ethanol/royaljelly
	name = "Royal Jelly"
	id = "royaljelly"
	description = "A drink usually enjoyed by only the highest castes of Apinae society. Incredibly sweet, it is said to have enormous health benefits."
	taste_description = "honey and royalty"
	color = "#f0d76b"
	proof = (2*BRANDY)/5

	glass_name = "Royal Jelly"
	glass_desc = "A drink usually enjoyed by only the highest castes of Apinae society. Incredibly sweet, it is said to have enormous health benefits."

//This functions the same as Doctor's Delight, except it gets you drunk too.
/datum/reagent/ethanol/royaljelly/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(alien == IS_DIONA)
		return
	M.adjustOxyLoss(-4 * removed)
	M.heal_organ_damage(2 * removed, 2 * removed)
	M.adjustToxLoss(-2 * removed)
	if(M.dizziness)
		M.dizziness = max(0, M.dizziness - 15)
	if(M.confused)
		M.Confuse(-5)

/datum/reagent/ethanol/coquito
	name = "Coquito"
	id = "coquito"
	description = "A holiday beverage akin to eggnog, made with coconut milk."
	taste_description = "creamy spiced coconut"
	color = "#ffffff"
	proof = RUM/3*2/5

	glass_name = "Coquito"
	glass_desc = "It's a little coconut!"

/datum/reagent/ethanol/pinacolada
	name = "Pina Colada"
	id = "pinacolada"
	description = "Rum, pineapple, and coconut plended up with ice."
	taste_description = "coconuts and pineapple soaked in rum"
	color = "#fdf49e"
	proof = RUM/3

	glass_name = "Piña Colada"
	glass_desc = "For those not into yoga."

/datum/reagent/ethanol/mimosa
	name = "Mimosa"
	id = "mimosa"
	description = "An airy blend of champagne and orange juice, often drunk as a morning refreshment."
	taste_description = "orange juice and a dry, bubbly wine"
	color = "#daa411"
	proof = WINE/2

	glass_name = "Mimosa"
	glass_desc = "A bubbly and tangy refreshment."

//Never Fade Away
/datum/reagent/ethanol/silverhand
	name = "Johnny Silverhand"
	id = "silverhand"
	description = "Old fashioned, beer, and chili. A drink for an angry, angry soul."
	taste_description = "an old-world classic with a firey finish"
	color = "#8d5b28" // rgb(119, 68, 16)
	proof = (((WHISKEY+BITTERS)/3)+BEER)/3

	glass_name = "Johnny Silverhand"
	glass_desc = "...at the end of it all, it's the code you live by that defines who you are."

/datum/reagent/ethanol/welles
	name = "Jackie Welles"
	id = "welles"
	description = "An updated take on a Moscow Mule, for those trying to make a fresh mark on the world."
	taste_description = "vodka and lime with a burst of fizzy ginger"
	color = "#db7878" // rgb(119, 68, 16)
	proof = VODKA/9

	glass_name = "Jackie Welles"
	glass_desc = "But that's done after tomorrow. Afterlife, here we come, baby!"

/datum/reagent/ethanol/martinez
	name = "David Martinez"
	id = "martinez"
	description = "Vodka and cola with a splash of sakura. A drink for those who shoot for the moon."
	taste_description = "vodka, cola, and sakura flower"
	color = "#206cc4" // rgb(119, 68, 16)
	proof = VODKA/3

	glass_name = "David Martinez"
	glass_desc = "You still have a dream to stick around for. Need you to see it through. That's my dream."

//Blood-based Cocktails

#define DEMONSBLOOD 100

/datum/reagent/ethanol/demonsblood
	name = "Demons Blood"
	id = "demonsblood"
	description = "This thing makes the hair on the back of your neck stand up."
	taste_description = "sweet tasting iron"
	taste_mult = 1.5
	color = "#820000"
	proof = DEMONSBLOOD
	blood_content = 1

	glass_name = "Demons' Blood"
	glass_desc = "Just looking at this thing makes the hair on the back of your neck stand up."

/datum/reagent/ethanol/devilskiss
	name = "Devils Kiss"
	id = "devilskiss"
	description = "Creepy time!"
	taste_description = "bitter iron"
	color = "#A68310"
	proof = DEMONSBLOOD
	blood_content = 1

	glass_name = "Devil's Kiss"
	glass_desc = "Creepy time!"

/datum/reagent/ethanol/narsour
	name = "Nar'Sour"
	id = "narsour"
	description = "When the tang of blood and citrus hits, your tongue just might finally be able to pronounce some of the scrawls seen in the tunnels..."
	taste_description = "bitter iron and citrus"
	color = "#7D1717"
	proof = DEMONSBLOOD/3
	blood_content = 1

	glass_name = "Nar'Sour"
	glass_desc = "When the tang of blood and citrus hits, your tongue just might finally be able to pronounce some of the scrawls seen in the tunnels..."

/datum/reagent/ethanol/narsian
	name = "Nars'Ian"
	id = "narsian"
	description = "Nanotrasen's 2518 Pet of The Year has been swept up in the Geometer's brilliant crimson tide! Yap!"
	taste_description = "bloody orange creamsicle with a bite (and a bark!)"
	color = "#7D1717"
	proof = ((DEMONSBLOOD/3)+(SCREWDRIVERCOCKTAIL*3/5))/2
	blood_content = 1

	glass_name = "Nar'Sian"
	glass_desc = "Nanotrasen's 2518 Pet of The Year has been swept up in the Geometer's brilliant crimson tide! Yap!"
/datum/reagent/ethanol/nightsdelight
	name = "Night's Delight"
	id = "nightsdelight"
	description = "A nighttime vigilante and a bloodsucking parasite could bond over a drink like this."
	taste_description = "iron, a dash of whiskey, and a hint of molasses"
	color = "#990033"
	proof = (WHISKEY_SPECIAL_BLEND+ABSINTHE)/3
	blood_content = 2

	glass_name = "Night's Delight"
	glass_desc = "A nighttime vigilante and a bloodsucking parasite could bond over a drink like this."

/datum/reagent/ethanol/bludsfizz
	name = "Blud's Fizz"
	id = "bludsfizz"
	description = "A delectable cocktail for a classy vampire."
	taste_description = "metallic, citrusy fizz"
	color = "#CC0000"
	proof = WINE/3
	blood_content = 1

	glass_name = "Blud's Fizz"
	glass_desc = "A delectable cocktail for a classy vampire. Comes with a snazzy sugar rim."
/datum/reagent/ethanol/wronghat
	name = "Wrong Hat"
	id = "wronghat"
	description = "The chaplain might've put on the wrong hat this morning..."
	taste_description = "some really sinful grapes"
	color = "#660000"
	proof = WINE/2
	blood_content = 1

	glass_name = "Wrong Hat"
	glass_desc = "The chaplain might've put on the wrong hat this morning..."

/datum/reagent/ethanol/braindrain
	name = "Brain Drain"
	id = "braindrain"
	description = "It's like someone took a straw to your brain and just went wild."
	taste_description = "grey matter"
	color = "#575e49"
	proof = (VODKA+KAHLUA)/3
	blood_content = 1

	glass_name = "Brain Drain"
	glass_desc = "It's like someone took a straw to your brain and just went wild."

//Holy Water Cocktails

/datum/reagent/ethanol/holygrail
	name = "Holy Grail"
	id = "holygrail"
	description = "The secret reason a bishop's hat is so tall."
	taste_description = "some really pious grapes"
	color = "#330033"
	proof = 100 // oops! unused!

	glass_name = "Holy Grail"
	glass_desc = "The secret reason a bishop's hat is so tall."

///////////////////////////////////////////////
//// End of list for drinks for bartenders ////
///////////////////////////////////////////////

//=========================
//Fats
//=========================
/datum/reagent/nutriment/triglyceride
	name = "triglyceride"
	id = "triglyceride"
	description = "More commonly known as fat, the third macronutrient, with over double the energy content of carbs and protein"

	reagent_state = REAGENT_SOLID
	nutriment_factor = 27//The caloric ratio of carb/protein/fat is 4:4:9
	color = "#CCCCCC"

/datum/reagent/nutriment/triglyceride/oil
	//Having this base class incase we want to add more variants of oil
	name = "Cooking Oil"
	id = "cooking_oil"	// gamer, cooking oil is not fucking oil.
						// go ahead, go coat your corndog with raw, fuel oil if you wanna be a clown
	description = "Oils are liquid fats."
	reagent_state = REAGENT_LIQUID
	color = "#c79705"
	touch_met = 1.5
	var/lastburnmessage = 0

/datum/reagent/nutriment/triglyceride/oil/on_touch_turf(turf/target, remaining, allocated, data)
	if(allocated >= 3)
		if(istype(target, /turf/simulated))
			var/turf/simulated/simulated_target = target
			simulated_target.wet_floor(2)
	return ..()

//Calculates a scaling factor for scalding damage, based on the temperature of the oil and creature's heat resistance
/datum/reagent/nutriment/triglyceride/oil/proc/heatdamage(mob/living/carbon/M, datum/reagent_holder/holder)
	var/temperature = holder.temperature
	var/threshold = 360//Human heatdamage threshold
	var/datum/species/S = M.species
	if (S && istype(S))
		threshold = S.heat_level_1

	//If temperature is too low to burn, return a factor of 0. no damage
	if (temperature < threshold)
		return 0

	//Step = degrees above heat level 1 for 1.0 multiplier
	var/step = 60
	if (S && istype(S))
		step = (S.heat_level_2 - S.heat_level_1)*1.5

	. = temperature - threshold
	. /= step
	. = min(., 2.5)//Cap multiplier at 2.5

/datum/reagent/nutriment/triglyceride/oil/legacy_affect_touch(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	var/dfactor = heatdamage(M, metabolism.legacy_current_holder)
	if (dfactor)
		M.take_random_targeted_damage(brute = 0, brute = removed * 1.5 * dfactor)
		if (lastburnmessage+100 < world.time	)
			to_chat(M, SPAN_DANGER("Searing hot oil burns you, wash it off quick!"))
			lastburnmessage = world.time

/datum/reagent/nutriment/triglyceride/oil/corn
	name = "Corn Oil"
	id = "cornoil"
	description = "An oil derived from various types of corn."

/datum/reagent/nutriment/triglyceride/oil/tallow
	name = "Tallow"
	id = "tallow"
	description = "An liquidized form of animal fat, useful for adding that extra heart stopping potential to any of your deep fried food products."

//Brine, for treating certain meats and food product fermentation.

/datum/reagent/brine
	name = "Brine"
	id = "brine"
	color = "#a1d1e7"
	description = "A mixture of water, enzymes, sugar, and salt used to trigger fermentation in certain food products."

//Protein! Get your mind out of the gutter.
/datum/reagent/nutriment/protein // Bad for Skrell!
	name = "animal protein"
	id = "protein"
	color = "#440000"
	taste_description = "meat"

/datum/reagent/nutriment/protein/tofu
	name = "tofu protein"
	id = "tofu"
	color = "#fdffa8"
	taste_description = "tofu"

/datum/reagent/nutriment/protein/seafood
	name = "seafood protein"
	id = "seafood"
	color = "#f5f4e9"
	taste_description = "fish"

/datum/reagent/nutriment/protein/egg
	name = "egg yolk"
	id = "egg"
	color = "#FFFFAA"
	taste_description = "egg"

/datum/reagent/nutriment/protein/cheese // Also bad for skrell.
	name = "cheese"
	id = "cheese"
	color = "#EDB91F"
	taste_description = "cheese"

/datum/reagent/nutriment/protein/cheese/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism) //Cheese is a kind of milk.
	if(alien == IS_NARAMADI)
		if(prob(5))
			to_chat(M, SPAN_WARNING("You feel nauseous!"))
			return
		if(prob(20))
			var/mob/living/L = M
			L.vomit()
	return

//SYNNONO MEME FOODS EXPANSION - Credit to Synnono

/datum/reagent/spacespice
	name = "Space Spice"
	id = "spacespice"
	description = "An exotic blend of spices for cooking. Definitely not worms."
	reagent_state = REAGENT_SOLID
	color = "#e08702"

/datum/reagent/browniemix
	name = "Brownie Mix"
	id = "browniemix"
	description = "A dry mix for making delicious brownies."
	reagent_state = REAGENT_SOLID
	color = "#441a03"

/datum/reagent/ethanol/wine/champagnejericho
	name = "Champagne"
	id = "champagnejericho"
	description = "Wait a minute...this isnt Champagne, this is just sparkling wine!"
	taste_description = "bitterness, suitable for a Champion"
	color = "#D1B166"

	glass_name = "the bubbly"
	glass_desc = "An even classier looking drink, with floating bubbles."

//Following was merged infrom _vr variant of this file

/datum/reagent/ethanol/deathbell
	name = "Deathbell"
	id = "deathbell"
	description = "A successful experiment to make the most alcoholic thing possible."
	taste_description = "your brains smashed out by a smooth brick of hard, ice cold alcohol"
	color = "#9f6aff"
	taste_mult = 5
	proof = 500
	adj_temp = 10
	targ_temp = 330

	glass_name = "Deathbell"
	glass_desc = "The perfect blend of the most alcoholic things a bartender can get their hands on."

/proc/monster_tamer(mob/living/carbon/M, alien, removed, alt_nutriment_factor)
	if(!M.species.is_vampire) //it's still food!
		switch(alien)
			if(IS_DIONA) //Diona don't get any nutrition from nutriment or protein.
			if(IS_SKRELL)
				M.adjustToxLoss(0.25 * removed)  //Equivalent to half as much protein, since it's half protein.
			if(IS_TESHARI)
				M.nutrition += (alt_nutriment_factor * 1.2 * removed) //Give them the same nutrition they would get from protein.
			if(IS_UNATHI)
				M.nutrition += (alt_nutriment_factor * 1.125 * removed) //Give them the same nutrition they would get from protein.
				//Takes into account the 0.5 factor for all nutriment which is applied on top of the 2.25 factor for protein.
			//Chimera don't need their own case here since their factors for nutriment and protein cancel out.
			else
				M.nutrition += (alt_nutriment_factor * removed)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.feral > 0 && H.nutrition > 100 && H.traumatic_shock < min(60, H.nutrition/10) && H.jitteriness < 100) // same check as feral triggers to stop them immediately re-feralling
			H.feral -= removed * 3 // should calm them down quick, provided they're actually in a state to STAY calm.
			if (H.feral <=0) //check if they're unferalled
				H.feral = 0
				to_chat(H, "<span class='info'>Your mind starts to clear, soothed into a state of clarity as your senses return.</span>")
				log_and_message_admins("is no longer feral.", H)

/datum/reagent/ethanol/monstertamer
	name = "Monster Tamer"
	id = "monstertamer"
	description = "A questionably-delicious blend of a carnivore's favorite food and a potent neural depressant."
	taste_description = "the gross yet satisfying combination of chewing on a raw steak while downing a shot of whiskey"
	proof = WHISKEY/2
	color = "#d3785d"
	metabolism_rate = REM * 2.5 // about right for mixing nutriment and ethanol.
	var/alt_nutriment_factor = 5 //half as much as protein since it's half protein.
	//using a new variable instead of nutriment_factor so we can call ..() without that adding nutrition for us without taking factors for protein into account

	glass_name = "Monster Tamer"
	glass_desc = "This looks like an alcoholic slurry of meat. Gross."

/datum/reagent/ethanol/monstertamer/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

	monster_tamer(M,alien, removed, alt_nutriment_factor)

/datum/reagent/ethanol/monstertamer/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SKRELL)
		M.adjustToxLoss(removed)  //Equivalent to half as much protein, since it's half protein.
	if(!M.species.is_vampire)
		if(alien == IS_SLIME || alien == IS_CHIMERA) //slimes and chimera can get nutrition from injected nutriment and protein
			M.nutrition += (alt_nutriment_factor * removed)

/datum/reagent/drink/drymonstertamer
	name = "Dry Monster Tamer"
	id = "drymonstertamer"
	description = "A questionably-delicious blend of a carnivore's favorite food and, it turns out, certain oligosaccharides common to certain plants."
	taste_description = "the gross yet satisfying combination of chewing on a raw steak while gulping a bunch of root beer"
	color = "#d3785d"
	metabolism_rate = REM * 2.5 // not actually right for the mix, but required to make it mechanically equivalent for feralness purposes
	var/alt_nutriment_factor = 5 //half as much as protein since it's half protein.
	//using a new variable instead of nutriment_factor so we can call ..() without that adding nutrition for us without taking factors for protein into account

	glass_name = "Dry Monster Tamer"
	glass_desc = "This looks like a fizzy slurry of meat. Gross."

/datum/reagent/drink/drymonstertamer/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()

	monster_tamer(M,alien, removed, alt_nutriment_factor)

/datum/reagent/drink/drymonstertamer/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	..()
	if(alien == IS_SKRELL)
		M.adjustToxLoss(removed)  //Equivalent to half as much protein, since it's half protein.
	if(!M.species.is_vampire)
		if(alien == IS_SLIME || alien == IS_CHIMERA) //slimes and chimera can get nutrition from injected nutriment and protein
			M.nutrition += (alt_nutriment_factor * removed)

/datum/reagent/ethanol/galacticpanic
	name = "Galactic Panic Attack"
	id = "galacticpanic"
	description = "The absolute worst thing you could ever put in your body."
	taste_description = "an entire galaxy collasping in on itself."
	proof = 300
	druggy = 50
	halluci = 30
	var/adj_dizzy = 10
	color = "#d3785d"

	glass_name = "Galactic Panic Attack"
	glass_desc = "Looking into this is like staring at the stars."

/datum/reagent/ethanol/galacticpanic/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()

	M.afflict_stun(20 * 2)

/datum/reagent/ethanol/lotus
	name = "Lotus"
	id = "lotus"
	description = "The result of making one mistake after another and trying to cover it up with sugar."
	taste_description = "rich, sweet fruit and even more sugar."
	proof = (WINE+VERMOUTH)/6
	color = "#d3785d"

	glass_name = "Lotus"
	glass_desc = "A promotional drink for a movie that only ever played in Neo Detroit theatres."

/datum/reagent/ethanol/sbagliato
	name = "Negroni Sbagliato"
	id = "sbagliato"
	description = "A drink invented because a bartender was too drunk."
	taste_description = "sweet bubbly wine and vermouth."
	proof = (WINE+VERMOUTH)/3
	color = "#d3785d"

	glass_name = "Negroni Sbagliato"
	glass_desc = "Bubbles constantly pop up to the surface with a quiet fizz."

/datum/reagent/ethanol/fusionnaire
	name = "Fusionnaire"
	id = "fusionnaire"
	description = "The one true elusive, some even consider it never existed!"
	taste_description = "strong currents of fresh zesty winds"
	color = "#E6E2AA"
	proof = (VODKA*2+SCHNAPPS*2+RUM)/9

	glass_name = "Fusionnaire"
	glass_desc = "The one true elusive, lighter than air, harder than the mountains!"

/datum/reagent/ethanol/originalsin
	name = "Original Sin"
	id = "originalsin"
	description = "Angel Ichor, entirely transformed by one drop of apple juice"
	taste_description = "the apple Eve gave to Adam"
	color = "#99CC35"
	proof = HOLYWINE*1.5

	glass_name = "Original Sin"
	glass_desc = "A drink so fine, you may just risk eternal damnation!"

/datum/reagent/ethanol/bulldog
	name = "Space Bulldog"
	id = "bulldog"
	description = "An inventive kahlua recipe."
	taste_description = "fizzy, creamy, soda and coffee hell."
	proof = BLACK_RUSSIAN*2/3*4/5
	color = "#d3785d"

	glass_name = "Space Bulldog"
	glass_desc = "It looks like someone poured cola in a cup of coffee."

/datum/reagent/ethanol/italiancrisis
	name = "Italian Crisis"
	id = "italiancrisis"
	description = "This drink was concocted by a madwoman, causing the Italian Crisis of 2123."
	taste_description = "cola, fruit, fizz, coffee, and cream swirled together in an old boot."
	proof = (((WINE+VERMOUTH)/3)+(BLACK_RUSSIAN*2/3*4/5))/2 // the things we do for code
	color = "#d3785d"

	glass_name = "Italian Crisis"
	glass_desc = "This drink looks like it was a mistake."

/datum/reagent/drink/shroomjuice
	name = "Dumb Shroom Juice"
	id = "shroomjuice"
	description = "The mushroom farmer didn't sort through their stock very well."
	taste_description = "sweet and sour citrus with a savory kick."
	color = "#d3785d"

	glass_name = "Dumb Shroom Juice"
	glass_desc = "Touch fuzzy, get dizzy."

/datum/reagent/drink/shroomjuice/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()

	if(alien == IS_DIONA)
		return

	var/threshold = 1
	if(alien == IS_SKRELL)
		threshold = 1.2

	if(alien == IS_SLIME)
		threshold = 0.8

	M.druggy = max(M.druggy, 30)

	var/effective_dose = metabolism.total_processed_dose
	if(issmall(M)) effective_dose *= 2
	if(effective_dose < 1 * threshold)
		M.apply_effect(3, STUTTER)
		M.make_dizzy(5)
		if(prob(5))
			M.emote(pick("twitch", "giggle"))
	else if(effective_dose < 2 * threshold)
		M.apply_effect(3, STUTTER)
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
		if(prob(10))
			M.emote(pick("twitch", "giggle"))
	else
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		if(prob(15))
			M.emote(pick("twitch", "giggle"))


/datum/reagent/ethanol/honeyshot
	name = "Honey Shot"
	id = "honeyshot"
	description = "The perfect drink for bees."
	taste_description = "sweet tart grenadine flavored with honey."
	proof = VODKA/3
	color = "#d3785d"

	glass_name = "Honey shot"
	glass_desc = "A glass of golden liquid."

/datum/reagent/ethanol/scsatw
	name = "Slow Comfortable Screw Against the Wall"
	id = "scsatw"
	description = "The screwdriver's bigger cousin."
	taste_description = "smooth, savory booze and tangy orange juice."
	proof = (3*SCREWDRIVERCOCKTAIL+RUM+WHISKEY+GIN)/6
	color = "#d3785d"

	glass_name = "Slow Comfortable Screw Against the Wall"
	glass_desc = "The best accessory to daydrinking."

/datum/reagent/drink/sweettea
	name = "Sweet Tea"
	id = "sweettea"
	description = "Tea that is sweetened with some form of sweetener."
	taste_description = "tea that is sweet."
	color = "#d3785d"

	glass_name = "Sweet Tea"
	glass_desc = "A southern classic. Southern what? You know, southern."

/datum/reagent/ethanol/unsweettea
	name = "Unsweetened Tea"
	id = "unsweettea"
	description = "A sick experiment to take the sweetness out of tea after sugar has been added resulted in this."
	taste_description = "bland, slightly bitter, discount black tea."
	proof = 25
	druggy = 10
	color = "#d3785d"

	glass_name = "Unsweetened Tea"
	glass_desc = "A drink with all the calories of sweet tea, but with none of the satisfaction. Slightly psychoactive."

/datum/reagent/ethanol/lovemaker
	name = "The Love Maker"
	id = "lovemaker"
	description = "A drink said to help one find true love."
	taste_description = "sweet fruit and honey."
	proof = SCREWDRIVERCOCKTAIL/2*5/6
	adj_temp = 10
	targ_temp = 360
	color = "#d3785d"

	glass_name = "The Love Maker"
	glass_desc = "A drink said to help one find the perfect fuck."

/datum/reagent/ethanol/peacetreaty
	name = "Peace Treaty"
	id = "peacetreaty"
	description = "A Tajaran cocktail named (somewhat in jest) of the peace treaty that ended the civil war on Adhomai."
	color = "#DFDF93"
	proof = (VICTORY_GIN+MESSA_MEAD)/3
	taste_description = "tart, oily honey"

	glass_icon_state = "peacetreatyglass"
	glass_name = "glass of Peace Treaty"
	glass_desc = "A Tajaran cocktail named (somewhat in jest) of the peace treaty that ended the civil war on Adhomai."

/datum/reagent/ethanol/winter_offensive
	name = "Winter Offensive"
	id = "winter_offensive"
	description = "The Tajaran equivalent of Gin 'On the Rocks', named after the famous People Republic of Adhomai military campaign."
	color = "#664300"
	proof = VICTORY_GIN/2
	taste_description = "oily gin"
	adj_temp = 10
	targ_temp = 270

	glass_icon_state = "winter_offensive"
	glass_name = "glass of Winter Offensive"
	glass_desc = "An alcoholic tajaran cocktail, named after the famous  People Republic of Adhomai military campaign."

/datum/reagent/ethanol/internationale
	name = "Internationale"
	id = "internationale"
	description = "A cocktail mixing Tajaran gin and Pan-Slavic Vodka. A symbol of unity between Human and Tajaran leftists."
	color = "#D9CCAA"
	proof = (VICTORY_GIN+VODKA)/2
	taste_description = "earthy, oily unity"

	glass_icon_state = "internationaleglass"
	glass_name = "glass of Internationale"
	glass_desc = "A cocktail mixing Tajaran gin and Pan-Slavic Vodka. A symbol of unity between Human and Tajaran leftists."

	glass_center_of_mass = list("x"=16, "y"=9)

/datum/reagent/ethanol/russianbastard
	name = "Russian Bastard"
	id = "russianbastard"
	description = "A White Russian gone awry."
	taste_description = "milky grain alcohol"
	color = "#9fbbd8"
	proof = VODKA/2

	glass_name = "Russian Bastard"
	glass_desc = "A White Russian gone awry."

/datum/reagent/ethanol/willtolive
	name = "A Will to Live"
	id = "willtolive"
	description = "Often lost and now found."
	taste_description = "the strength to go on"
	color = "#9ce454"
	proof = (COGNAC+KAHLUA*3+MELON_LIQUOR*3)/9

	glass_name = "A Will to Live"
	glass_desc = "Often lost and now found."

/datum/reagent/ethanol/desiretodie
	name = "A Desire to Die"
	id = "desiretodie"
	description = "A horrid concoction of deathbell and nuclear waste. Is this really necessary?"
	taste_description = "radioactivity and alcohol poisoning"
	color = "#6c3c94"
	proof = 400

	glass_name = "A Desire to Die"
	glass_desc = "Deathbell and nuclear waste. The bane of your liver."

/datum/reagent/ethanol/desiretodie/legacy_affect_blood(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(alien == IS_DIONA)
		return
	M.bloodstr.add_reagent("radium", 0.3)

/datum/reagent/ethanol/desiretodie/legacy_affect_ingest(mob/living/carbon/M, alien, removed, datum/reagent_metabolism/metabolism)
	. = ..()
	if(alien == IS_DIONA)
		return
	M.ingested.add_reagent("radium", 0.25)

/datum/reagent/drink/raspberrybeesknees
	name = "Raspberry Bee's Knees"
	id = "raspberrybeesknees"
	description = "The sweetness of berries and honey, combined with a lemony tang to produce a drink that's the bee's knees."
	taste_description = "fruity sweetness with a lemony tang"
	color = "#ff859a"

	glass_name = "Raspberry Bee's Knees"
	glass_desc = "The sweetness of berries and honey, combined with a lemony tang to produce a drink that's the bee's knees."

/datum/reagent/ethanol/sidecar
	name = "Sidecar"
	id = "sidecar"
	description = "The daiquiri's dry cousin."
	taste_description = "sickly sweetness"
	color = "#be5227"
	proof = COGNAC*5/9

	glass_name = "Sidecar"
	glass_desc = "The daiquiri's dry cousin."

/datum/reagent/ethanol/french75
	name = "French 75"
	id = "french75"
	description = "Named after a field artillery gun. Enough said."
	taste_description = "the impact of a 75mm shell"
	color = "#d8d4ad"
	proof = (GIN+2*WINE)/4

	glass_name = "French 75"
	glass_desc = "Named after a field artillery gun. Enough said."

/datum/reagent/ethanol/french76
	name = "French 76"
	id = "french76"
	description = "A French 75 with the gin substituted for vodka."
	taste_description = "the impact of a harder 75mm shell"
	color = "#d8d4ad"
	proof = (VODKA+2*WINE)/4

	glass_name = "French 76"
	glass_desc = "A French 75 with the gin substituted for vodka."

/datum/reagent/ethanol/lastword
	name = "Last Word"
	id = "lastword"
	description = "Made on Terra when and where alcohol was illegal. How defiant."
	taste_description = "sweet and sour defiance"
	color = "#f1e362"
	proof = GIN/4

	glass_name = "Last Word"
	glass_desc = "Made on Terra when and where alcohol was illegal. How defiant."

/datum/reagent/drink/watermelonsmoothie
	name = "Watermelon Smoothie"
	id = "watermelonsmoothie"
	description = "Icy watermelon juice mixed with milk and cream."
	taste_description = "creamy watermelon"
	color = "#ff4e65"

	glass_name = "Watermelon Smoothie"
	glass_desc = "Icy watermelon juice mixed with milk and cream."

/datum/reagent/drink/orangesmoothie
	name = "Orange Smoothie"
	id = "orangesmoothie"
	description = "Icy orange juice mixed with milk and cream."
	taste_description = "creamy oranges"
	color = "#ffe386"

	glass_name = "Orange Smoothie"
	glass_desc = "Icy orange juice mixed with milk and cream."

/datum/reagent/drink/limesmoothie
	name = "Lime Smoothie"
	id = "limesmoothie"
	description = "Icy lime juice mixed with milk and cream."
	taste_description = "creamy limes"
	color = "#e1f392"

	glass_name = "Lime Smoothie"
	glass_desc = "Icy lime juice mixed with milk and cream."

/datum/reagent/drink/lemonsmoothie
	name = "Lemon Smoothie"
	id = "lemonsmoothie"
	description = "Icy lemon juice mixed with milk and cream."
	taste_description = "creamy lemons"
	color = "#feffc8"

	glass_name = "Lemon Smoothie"
	glass_desc = "Icy lemon juice mixed with milk and cream."

/datum/reagent/drink/berrysmoothie
	name = "Berry Smoothie"
	id = "berrysmoothie"
	description = "Icy berry juice mixed with milk and cream."
	taste_description = "creamy berries"
	color = "#eb89ff"

	glass_name = "Berry Smoothie"
	glass_desc = "Icy berry juice mixed with milk and cream."

/datum/reagent/drink/applesmoothie
	name = "Apple Smoothie"
	id = "applesmoothie"
	description = "Icy apple juice mixed with milk and cream."
	taste_description = "creamy apples"
	color = "#f0e19e"

	glass_name = "Apple Smoothie"
	glass_desc = "Icy apple juice mixed with milk and cream."

/datum/reagent/drink/grapesmoothie
	name = "Grape Smoothie"
	id = "grapesmoothie"
	description = "Icy grape juice mixed with milk and cream."
	taste_description = "creamy grapes"
	color = "#e9a0ff"

	glass_name = "Grape Smoothie"
	glass_desc = "Icy grape juice mixed with milk and cream." // fuck linters

/datum/reagent/drink/battery
	name = "Battery"
	id = "battery"
	description = "A very bitter-sugary and bright neon green energy drink."
	taste_description = "bitter sugary neon green"
	color = "#00ff49"
	adj_dizzy = -5
	adj_drowsy = -3
	adj_sleepy = -2

	glass_name = "Battery"
	glass_desc = "A very bitter-sugary and bright neon green energy drink."
	//shocked it works, however when poured into metaglass it shows as brown instead of neon green. Will try to fix this if I can.

/datum/reagent/drink/ramune
	name = "Ramone"
	id = "ramune"
	description = "A sweet marble soda flavored like melon."
	taste_description = "fizzy melon soda"
	color = "#E5E5E5"

	glass_name = "Ramone"
	glass_desc = "A sweet marble soda flavored like melon."

/datum/reagent/drink/dumbjuice
	name = "DUMB BITCH JUICE!"
	id = "dumbjuice"
	description = "A-...uh...it doesn't seem to have much of a taste?"
	taste_description = "bad choices made easy"
	color = "#fce5cd"

	glass_name = "DUMB BITCH JUICE!"
	glass_desc = "A-...uh...it doesn't seem to have much of a taste?"
/datum/reagent/drink/greentea
	name = "Green Tea"
	id = "greentea"
	description = "A very bitter, yet aromatic green tea."
	taste_description = "elegant notes of matcha"
	color = "#51761d"

	glass_name = "Green Tea"
	glass_desc = "A very bitter, yet aromatic green tea."

/datum/reagent/drink/crystalgibb
	name = "Crystal Dr. Gibb"
	id = "crystalgibb"
	description = "Tastes just like Dr. Gibb, but it's translucent. How?!?"
	taste_description = "clear cherry soda"
	color = "#0000"

	glass_name = "Crystal Dr. Gibb"
	glass_desc = "Tastes just like Dr. Gibb, but it's translucent. How?!?"

/datum/reagent/drink/crystalgibb
	name = "Crystal Dr. Gibb"
	id = "crystalgibb"
	description = "Tastes just like Dr. Gibb, but it's translucent. How?!?"
	taste_description = "clear cherry soda"
	color = "#0000"

	glass_name = "Crystal Dr. Gibb"
	glass_desc = "Tastes just like Dr. Gibb, but it's translucent. How?!?"

/datum/reagent/drink/glue
	name = "\improper AP-NT:G 'Glue'"
	id = "safeglue"
	description = "A bottle codenamed AP-NT:G by nanotrasen's brightest minds, standing for 'All Purpose Non-Toxic Glue', this type being best used on paper. ..Or microwaved bread, if you're daring."
	taste_description = "dull sticky glue"
	nutrition = 1
	color = "#faf2e3"

	glass_name = "Glue"
	glass_desc = "A glass of glue. Wait, why did you put this into a glass?"

// Unathi drinks

// Alien Drinks

/datum/reagent/drink/unathijuice
	name = "Hrukhza Leaf Extract"
	id = "unathijuice"
	description = "A bitter liquid used in most recipes on Moghes."
	taste_description = "bland, disgusting bitterness"
	color = "#345c52"
	glass_name = "hrukhza leaf extract"
	glass_desc = "A bitter extract from the hrukhza."

/datum/reagent/drink/kzkzaa
	name = "Kzkzaa"
	id = "kzkzaa"
	description = "Fish extract from Moghes."
	taste_description = "fishy fish"
	color = "#e78108"
	glass_name = "kzkzaa"
	glass_desc = "A glass of Kzkzaa, fish extract, commonly drank on Moghes."

/datum/reagent/ethanol/mumbaksting
	name = "Mumbak Sting"
	id = "mumbaksting"
	description = "A drink made from the venom of the Yuum."
	taste_description = "harsh and stinging sweetness"
	color = "#550000"
	proof = 200
	glass_name = "Mumbak sting"
	glass_desc = "A drink made from the venom of the Yuum."

/datum/reagent/ethanol/wasgaelhi
	name = "Wasgaelhi"
	id = "wasgaelhi"
	description = "Wine made from various fruits from the swamps of Moghes."
	taste_description = "swampy fruit"
	color = "#6b596b"
	proof = 150
	glass_name = "wasgaelhi"
	glass_desc = "Wine made from various fruits from the swamps of Moghes."

/datum/reagent/drink/skrianhi
	name = "Skrianhi Tea"
	id = "skrianhitea"
	description = "A blend of teas from Moghes, commonly drank by Unathi."
	taste_description = "bitter energising tea"
	color = "#0e0900"
	glass_name = "skrianhi tea"
	glass_desc = "A blend of teas from Moghes, commonly drank by Unathi."
