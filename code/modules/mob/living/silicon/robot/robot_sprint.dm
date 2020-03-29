/mob/living/silicon/robot/default_toggle_sprint(shutdown = FALSE)
	var/current = (combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
	if(current || shutdown || !cell || (cell.charge < 25) || !cansprint)
		disable_intentional_sprint_mode()
		if(CHECK_MULTIPLE_BITFIELDS(mobility_flags, MOBILITY_STAND|MOBILITY_MOVE))
			if(shutdown)
				playsound_local(src, 'sound/effects/light_flicker.ogg', 50, FALSE, pressure_affected = FALSE)
			playsound_local(src, 'sound/misc/sprintdeactivate.ogg', 50, FALSE, pressure_affected = FALSE)
	else
		enable_intentional_sprint_mode()
		if(CHECK_MULTIPLE_BITFIELDS(mobility_flags, MOBILITY_STAND|MOBILITY_MOVE))
			playsound_local(src, 'sound/misc/sprintactivate.ogg', 50, FALSE, pressure_affected = FALSE)
