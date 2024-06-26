/proc/power_failure()
	priority_announce("Abnormal activity detected in [station_name()]'s powernet. As a precautionary measure, the station's power will be shut off for an indeterminate duration.", "Critical Power Failure", "poweroff")
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(istype(get_area(S), /area/ai_monitored/turret_protected) || !is_station_level(S.z))
			continue
		S.charge = 0
		S.output_level = 0
		S.output_attempt = FALSE
		S.update_icon()
		S.power_change()

	for(var/area/A in GLOB.the_station_areas)
		if(!A.requires_power || A.always_unpowered )
			continue
		if(GLOB.typecache_powerfailure_safe_areas[A.type])
			continue

		A.power_light = FALSE
		A.power_equip = FALSE
		A.power_environ = FALSE
		A.power_change()

	for(var/obj/machinery/power/apc/C in GLOB.apcs_list)
		if(C.cell && is_station_level(C.z))
			var/area/A = C.area
			if(GLOB.typecache_powerfailure_safe_areas[A.type])
				continue

			C.cell.charge = 0

/proc/power_restore()

	priority_announce("Питание на станции [station_name()] было восстановлено. Приносим извинения за неудобства.", "Отделение Электропитания", "poweron")
	for(var/obj/machinery/power/apc/C in GLOB.machines)
		if(C.cell && is_station_level(C.z))
			C.cell.charge = C.cell.maxcharge
			C.failure_timer = 0
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(!is_station_level(S.z))
			continue
		S.charge = S.capacity
		S.output_level = S.output_level_max
		S.output_attempt = 1
		S.update_icon()
		S.power_change()

	for(var/area/A in world)
		if(!istype(A, /area/space) && !istype(A, /area/shuttle) && !istype(A, /area/arrival) && !A.always_unpowered && !A.base_area)
			A.power_light = TRUE
			A.power_equip = TRUE
			A.power_environ = TRUE
			A.power_change()

/proc/power_restore_quick()

	priority_announce("Все энергохранилища на станции [station_name()] были перезаряжены. Приносим извинения за неудобства.", "Отделение Электропитания", "poweron")
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(!is_station_level(S.z))
			continue
		S.charge = S.capacity
		S.output_level = S.output_level_max
		S.output_attempt = 1
		S.update_icon()
		S.power_change()

