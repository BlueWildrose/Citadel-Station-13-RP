/mob/living/carbon/human/verb/suicide()
	set hidden = 1

	if (stat == DEAD)
		to_chat(src, "You're already dead!")
		return

	if (!SSticker)
		to_chat(src, "You can't commit suicide before the game starts!")
		return

	if(!player_is_antag(mind))
		message_admins("[ckey] has tried to suicide, but they were not permitted due to not being antagonist as human.", 1)
		to_chat(src, "No. Adminhelp if there is a legitimate reason.")
		return

	if (suiciding)
		to_chat(src, "You're already committing suicide! Be patient!")
		return

	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")

	if(confirm == "Yes")
		if(!CHECK_MOBILITY(src, MOBILITY_CAN_USE) || restrained())	//just while I finish up the new 'fun' suiciding verb. This is to prevent metagaming via suicide
			to_chat(src, "You can't commit suicide whilst restrained! ((You can type Ghost instead however.))")
			return
		suiciding = 15
		does_not_breathe = 0			//Prevents ling-suicide zombies, or something
		var/obj/item/held_item = get_active_held_item()
		if(held_item)
			var/damagetype = held_item.suicide_act(src)
			if(damagetype)
				log_and_message_admins("[key_name(src)] commited suicide using \a [held_item]")
				var/damage_mod = 1
				switch(damagetype) //Sorry about the magic numbers.
								   //brute = 1, burn = 2, tox = 4, oxy = 8
					if(15) //4 damage types
						damage_mod = 4

					if(6, 11, 13, 14) //3 damage types
						damage_mod = 3

					if(3, 5, 7, 9, 10, 12) //2 damage types
						damage_mod = 2

					if(1, 2, 4, 8) //1 damage type
						damage_mod = 1

					else //This should not happen, but if it does, everything should still work
						damage_mod = 1

				//Do 175 damage divided by the number of damage types applied.
				if(damagetype & BRUTELOSS)
					adjustBruteLoss(30/damage_mod)	//hack to prevent gibbing
					adjustOxyLoss(145/damage_mod)

				if(damagetype & FIRELOSS)
					adjustFireLoss(175/damage_mod)

				if(damagetype & TOXLOSS)
					adjustToxLoss(175/damage_mod)

				if(damagetype & OXYLOSS)
					adjustOxyLoss(175/damage_mod)

				//If something went wrong, just do normal oxyloss
				if(!(damagetype | BRUTELOSS) && !(damagetype | FIRELOSS) && !(damagetype | TOXLOSS) && !(damagetype | OXYLOSS))
					adjustOxyLoss(max(175 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))

				update_health()
				return

		log_and_message_admins("[key_name(src)] commited suicide")

		var/datum/gender/T = GLOB.gender_datums[get_visible_gender()]

		var/suicidemsg
		suicidemsg = pick("<span class='danger'>[src] is attempting to bite [T.his] tongue off! It looks like [T.he] [T.is] trying to commit suicide.</span>", \
		                     "<span class='danger'>[src] is jamming [T.his] thumbs into [T.his] eye sockets! It looks like [T.he] [T.is] trying to commit suicide.</span>", \
		                     "<span class='danger'>[src] is twisting [T.his] own neck! It looks like [T.he] [T.is] trying to commit suicide.</span>", \
		                     "<span class='danger'>[src] is holding [T.his] breath! It looks like [T.he] [T.is] trying to commit suicide.</span>")
		if(isSynthetic())
			suicidemsg = "<span class='danger'>[src] is attempting to switch [T.his] power off! It looks like [T.he] [T.is] trying to commit suicide.</span>"
		visible_message(suicidemsg)

		adjustOxyLoss(max(175 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		update_health()

/mob/living/carbon/brain/verb/suicide()
	set hidden = 1

	if (stat == 2)
		to_chat(src, "You're already dead!")
		return

	if (!SSticker)
		to_chat(src, "You can't commit suicide before the game starts!")
		return

	if (suiciding)
		to_chat(src, "You're already committing suicide! Be patient!")
		return

	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")

	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src]'s brain is growing dull and lifeless. It looks like it's lost the will to live.</span>")
		spawn(50)
			death(0)
			suiciding = 0

/mob/living/silicon/ai/verb/suicide()
	set hidden = 1

	if (stat == 2)
		to_chat(src, "You're already dead!")
		return

	if (suiciding)
		to_chat(src, "You're already committing suicide! Be patient!")
		return

	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")

	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is powering down. It looks like they're trying to commit suicide.</span>")
		//put em at -175
		adjustOxyLoss(max(getMaxHealth() * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		update_health()

/mob/living/silicon/robot/verb/suicide()
	set hidden = 1

	if (stat == 2)
		to_chat(src, "You're already dead!")
		return

	if (suiciding)
		to_chat(src, "You're already committing suicide! Be patient!")
		return

	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")

	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is powering down. It looks like they're trying to commit suicide.</span>")
		//put em at -175
		adjustOxyLoss(max(getMaxHealth() * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		update_health()

