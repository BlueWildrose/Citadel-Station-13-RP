//
// Vent Pipe - Unpowered vent
//
/obj/machinery/atmospherics/pipe/vent
	icon = 'icons/obj/atmospherics/pipe_vent.dmi'
	icon_state = "intact"

	name = "Vent"
	desc = "A large air vent"

	volume = 250

	dir = SOUTH
	initialize_directions = SOUTH
	pipe_flags = PIPING_DEFAULT_LAYER_ONLY
	construction_type = /obj/item/pipe/directional
	pipe_state = "passive vent"
	hides_underfloor_defaulting = FALSE
	hides_underfloor_update_icon = TRUE

/obj/machinery/atmospherics/pipe/vent/init_dir()
	initialize_directions = dir

/obj/machinery/atmospherics/pipe/vent/high_volume
	name = "Larger vent"
	volume = 1000

/obj/machinery/atmospherics/pipe/vent/process(delta_time)
	if(parent)
		parent.mingle_with_turf(loc, volume)

/obj/machinery/atmospherics/pipe/vent/Destroy()
	if(node1)
		node1.disconnect(src)
		node1 = null

	. = ..()

/obj/machinery/atmospherics/pipe/vent/pipeline_expansion()
	return list(node1)

/obj/machinery/atmospherics/pipe/vent/update_icon()
	. = ..()
	if(node1)
		if(is_hidden_underfloor())
			icon_state = "hintact"
		else
			icon_state = "intact"
		setDir(get_dir(src, node1))
	else
		icon_state = "exposed"

/obj/machinery/atmospherics/pipe/vent/atmos_init()
	var/connect_direction = dir

	for(var/obj/machinery/atmospherics/target in get_step(src,connect_direction))
		if (can_be_node(target, 1))
			node1 = target
			break

	update_icon()

/obj/machinery/atmospherics/pipe/vent/disconnect(obj/machinery/atmospherics/reference)
	if(reference == node1)
		if(istype(node1, /obj/machinery/atmospherics/pipe))
			qdel(parent)
		node1 = null

	update_icon()

	return null

/obj/machinery/atmospherics/pipe/vent/update_hiding_underfloor(new_value)
	. = ..()
	update_icon()
