/obj/item/forensics
	icon = 'icons/obj/forensics.dmi'
	w_class = WEIGHT_CLASS_TINY

//This is the output of the stringpercent(print) proc, and means about 80% of
//the print must be there for it to be complete.  (Prints are 32 digits)
var/const/FINGERPRINT_COMPLETE = 6
/proc/is_complete_print(var/print)
	return stringpercent(print) <= FINGERPRINT_COMPLETE

/atom/var/list/suit_fibers

/atom/proc/add_fibers(mob/living/carbon/human/M)
	if(M.gloves && istype(M.gloves,/obj/item/clothing/gloves))
		var/obj/item/clothing/gloves/G = M.gloves
		if(G.transfer_blood) //bloodied gloves transfer blood to touched objects
			if(add_blood(G.bloody_hands_mob)) //only reduces the bloodiness of our gloves if the item wasn't already bloody
				G.transfer_blood--
	else if(M.bloody_hands)
		if(add_blood(M.bloody_hands_mob))
			M.bloody_hands--

	if(!suit_fibers) suit_fibers = list()
	var/fibertext
	var/item_multiplier = istype(src,/obj/item)?1.2:1
	var/suit_coverage = 0
	if(istype(M.inventory.get_slot_single(/datum/inventory_slot/inventory/suit::id), /obj/item/clothing))
		var/obj/item/clothing/C = M.wear_suit
		fibertext = C.get_fibers()
		if(fibertext && prob(10*item_multiplier))
			suit_fibers |= fibertext
		suit_coverage = C.body_cover_flags

	if(istype(M.inventory.get_slot_single(/datum/inventory_slot/inventory/uniform::id), /obj/item/clothing) && (M.w_uniform.body_cover_flags & ~suit_coverage))
		var/obj/item/clothing/C = M.w_uniform
		fibertext = C.get_fibers()
		if(fibertext && prob(15*item_multiplier))
			suit_fibers |= fibertext

	if(istype(M.inventory.get_slot_single(/datum/inventory_slot/inventory/gloves::id), /obj/item/clothing) && (M.gloves.body_cover_flags & ~suit_coverage))
		var/obj/item/clothing/C = M.gloves
		fibertext = C.get_fibers()
		if(fibertext && prob(20*item_multiplier))
			suit_fibers |= fibertext

/datum/data/record/forensic
	name = "forensic data"
	var/uid

/datum/data/record/forensic/New(var/atom/A)
	uid = "\ref [A]"
	fields["name"] = sanitize(A.name)
	fields["area"] = sanitize("[get_area(A)]")
	fields["fprints"] = A.fingerprints ? A.fingerprints.Copy() : list()
	fields["fibers"] = A.suit_fibers ? A.suit_fibers.Copy() : list()
	fields["blood"] = A.blood_DNA ? A.blood_DNA.Copy() : list()
	fields["time"] = world.time

/datum/data/record/forensic/proc/merge(var/datum/data/record/other)
	var/list/prints = fields["fprints"]
	var/list/o_prints = other.fields["fprints"]
	for(var/print in o_prints)
		if(!prints[print])
			prints[print] = o_prints[print]
		else
			prints[print] = stringmerge(prints[print], o_prints[print])
	fields["fprints"] = prints

	var/list/fibers = fields["fibers"]
	var/list/o_fibers = other.fields["fibers"]
	fibers |= o_fibers
	fields["fibers"] = fibers

	var/list/blood = other.fields["blood"]
	var/list/o_blood = other.fields["blood"]
	blood |= o_blood
	fields["blood"] = blood

	fields["area"] = other.fields["area"]
	fields["time"] = other.fields["time"]

/datum/data/record/forensic/proc/update_prints(var/list/o_prints)
	var/list/prints = fields["fprints"]
	for(var/print in o_prints)
		if(prints[print])
			prints[print] = stringmerge(prints[print], o_prints[print])
			.=1
	fields["fprints"] = prints
