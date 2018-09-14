relic_generic_torn_muscle = class(relicBaseClass)

function relic_generic_torn_muscle:DeclareFunctions()
	return {MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_HEALTH_BONUS}
end

function relic_generic_torn_muscle:GetModifierBonusStats_Strength()
	return 15
end

function relic_generic_torn_muscle:GetModifierHealthBonus()
	return 200
end