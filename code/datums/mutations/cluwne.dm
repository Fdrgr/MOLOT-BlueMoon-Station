/datum/mutation/human/cluwne

	name = "Cluwne"
	quality = NEGATIVE
	locked = TRUE
	text_gain_indication = "<span class='danger'>You feel like your brain is tearing itself apart.</span>"

/datum/mutation/human/cluwne/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	owner.dna.add_mutation(CLOWNMUT)
	owner.dna.add_mutation(EPILEPSY)
	owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 199, 199)

	var/mob/living/carbon/human/H = owner

	if(!istype(H.wear_mask, /obj/item/clothing/mask/gas/cluwne))
		if(!H.dropItemToGround(H.wear_mask))
			qdel(H.wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/cluwne(H), ITEM_SLOT_MASK)
	if(!istype(H.w_uniform, /obj/item/clothing/under/cluwne))
		if(!H.dropItemToGround(H.w_uniform))
			qdel(H.w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/cluwne(H), ITEM_SLOT_ICLOTHING)
	if(!istype(H.shoes, /obj/item/clothing/shoes/clown_shoes/cluwne))
		if(!H.dropItemToGround(H.shoes))
			qdel(H.shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/clown_shoes/cluwne(H), ITEM_SLOT_FEET)

	owner.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/white(owner), ITEM_SLOT_GLOVES) // this is purely for cosmetic purposes incase they aren't wearing anything in that slot
	owner.equip_to_slot_or_del(new /obj/item/storage/backpack/clown(owner), ITEM_SLOT_BACK) // ditto

/datum/mutation/human/cluwne/on_life(mob/living/carbon/human/owner)
	if((prob(15) && owner.IsUnconscious()))
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 199, 199) // there I changed it to setBrainLoss
		switch(rand(1, 6))
			if(1)
				owner.say("HONK")
			if(2 to 5)
				owner.emote("realagony")
			if(6)
				owner.Stun(1)
				owner.Knockdown(20)
				owner.Jitter(500)

/datum/mutation/human/cluwne/on_losing(mob/living/carbon/human/owner)
	owner.adjust_fire_stacks(1)
	owner.IgniteMob()
	owner.dna.add_mutation(CLUWNEMUT)

/mob/living/carbon/human/proc/cluwneify()
	dna.add_mutation(CLUWNEMUT)
	emote("scream")
	regenerate_icons()
	visible_message("<span class='danger'>[src]'s body glows green, the glow dissipating only to leave behind a cluwne formerly known as [src]!</span>", \
					"<span class='danger'>Your brain feels like it's being torn apart, there is only the honkmother now.</span>")
	flash_act()
