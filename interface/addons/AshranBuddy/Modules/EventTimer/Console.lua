local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local EventTimer = Engine:GetModule("EventTimer")

function EventTimer:OnCommand(input)
	local settings = Settings:Get(self.Name)
	if input == "unlock" then
		EventTimer:Unlock()
		settings.locked = false
	elseif input == "lock" then
		EventTimer:Lock()
		settings.locked = true
	end
end