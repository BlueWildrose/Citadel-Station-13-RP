/datum/looping_sound/weather
	pref_check = /datum/game_preference_toggle/ambience/weather
	soundenvwet = -10000
	soundenvdry = 0

/datum/looping_sound/weather/outside_blizzard
	mid_sounds = list(
		'sound/effects/weather/snowstorm/outside/active_mid1.ogg' = 1,
		'sound/effects/weather/snowstorm/outside/active_mid1.ogg' = 1,
		'sound/effects/weather/snowstorm/outside/active_mid1.ogg' = 1
		)
	mid_length = 8 SECONDS
	start_sound = 'sound/effects/weather/snowstorm/outside/active_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/effects/weather/snowstorm/outside/active_end.ogg'
	volume = 40

/datum/looping_sound/weather/inside_blizzard
	mid_sounds = list(
		'sound/effects/weather/snowstorm/inside/active_mid1.ogg' = 1,
		'sound/effects/weather/snowstorm/inside/active_mid2.ogg' = 1,
		'sound/effects/weather/snowstorm/inside/active_mid3.ogg' = 1
		)
	mid_length = 8 SECONDS
	start_sound = 'sound/effects/weather/snowstorm/inside/active_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/effects/weather/snowstorm/inside/active_end.ogg'
	volume = 20

/datum/looping_sound/weather/outside_snow
	mid_sounds = list(
		'sound/effects/weather/snowstorm/outside/weak_mid1.ogg' = 1,
		'sound/effects/weather/snowstorm/outside/weak_mid2.ogg' = 1,
		'sound/effects/weather/snowstorm/outside/weak_mid3.ogg' = 1
		)
	mid_length = 8 SECONDS
	start_sound = 'sound/effects/weather/snowstorm/outside/weak_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/effects/weather/snowstorm/outside/weak_end.ogg'
	volume = 30

/datum/looping_sound/weather/inside_snow
	mid_sounds = list(
		'sound/effects/weather/snowstorm/inside/weak_mid1.ogg' = 1,
		'sound/effects/weather/snowstorm/inside/weak_mid2.ogg' = 1,
		'sound/effects/weather/snowstorm/inside/weak_mid3.ogg' = 1
		)
	mid_length = 8 SECONDS
	start_sound = 'sound/effects/weather/snowstorm/inside/weak_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/effects/weather/snowstorm/inside/weak_end.ogg'
	volume = 15

/datum/looping_sound/weather/wind
	mid_sounds = list(
		'sound/effects/weather/wind/wind_2_1.ogg' = 1,
		'sound/effects/weather/wind/wind_2_2.ogg' = 1,
		'sound/effects/weather/wind/wind_3_1.ogg' = 1,
		'sound/effects/weather/wind/wind_4_1.ogg' = 1,
		'sound/effects/weather/wind/wind_4_2.ogg' = 1,
		'sound/effects/weather/wind/wind_5_1.ogg' = 1
		)
	mid_length = 10 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	volume = 30

// Don't have special sounds so we just make it quieter indoors.
/datum/looping_sound/weather/wind/indoors
	volume = 15

/datum/looping_sound/weather/rain
	mid_sounds = list(
		'sound/effects/weather/acidrain_mid.ogg' = 1
		)
	mid_length = 15 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/effects/weather/acidrain_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/effects/weather/acidrain_end.ogg'
	volume = 30

/datum/looping_sound/weather/rain/indoors
	volume = 15
