local function StartEvent(self)
	local spawnPos = RoundManager:PickRandomSpawn()
	self.enemiesToSpawn = 3 + math.floor( math.log( RoundManager:GetEventsFinished() + 1 ) )
	Timers:CreateTimer(3, function()
		local enemyName = "npc_dota_boss18"
		local roll = RandomInt(1, 11)
		if RollPercentage(33) then
			enemyName = "npc_dota_boss19"
		end
		local spawn = CreateUnitByName(enemyName, RoundManager:PickRandomSpawn(), true, nil, nil, DOTA_TEAM_BADGUYS)
		spawn.unitIsRoundBoss = true
		
		self.enemiesToSpawn = self.enemiesToSpawn - 1
		if self.enemiesToSpawn > 0 then
			return 12
		end
	end)
	
	self._vEventHandles = {
		ListenToGameEvent( "entity_killed", require("events/base_combat"), self ),
	}
end

local function EndEvent(self, bWon)
	for _, eID in pairs( self._vEventHandles ) do
		StopListeningToGameEvent( eID )
	end
	RoundManager:EndEvent(bWon)
end

local function PrecacheUnits(self)
	PrecacheUnitByNameAsync("npc_dota_boss18", function() end)
	Timers:CreateTimer(1, function() PrecacheUnitByNameAsync("npc_dota_boss19", function() end) end)
	Timers:CreateTimer(2, function() PrecacheUnitByNameAsync("npc_dota_mini_tree", function() end) end)
	Timers:CreateTimer(3, function() PrecacheUnitByNameAsync("npc_dota_mini_tree2", function() end) end)
	return true
end

local funcs = {
	["StartEvent"] = StartEvent,
	["PrecacheUnits"] = PrecacheUnits,
	["EndEvent"] = EndEvent
}

return funcs