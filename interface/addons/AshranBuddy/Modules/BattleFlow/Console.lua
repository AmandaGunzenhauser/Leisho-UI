local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local BattleFlow = Engine:GetModule("BattleFlow")

function BattleFlow:OnCommand(input)
	local settings = Settings:Get(self.Name)
	if (input == "unlock") then
		BattleFlow:Unlock()
		settings.locked = false
	elseif (input == "lock") then
		BattleFlow:Lock()
		settings.locked = true
	end
end