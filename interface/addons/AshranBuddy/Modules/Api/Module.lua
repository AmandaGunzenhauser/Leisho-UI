local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Registration
Api = Engine:RegisterModule("Api", Api)
Api.AreaID = 978

local IsInAshran = false

-- Initialize the module.
function Api:OnInitialize()
	-- Show first time message
	if Settings:Get("firstRun") then
		Settings:Set("firstRun", false)
		print(Locale.ADDON_WELCOME)
	end
end

-- Called when the module is enabled.
function Api:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnZoneChanged")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnZoneChanged")

	self:EnableConsole()
	self:EnableNetwork()
end

-- Called when the module is disabled.
function Api:OnDisable()
	self:UnregisterAllEvents()
end

-- Gets a value indicating if the player is currently in Ashran.
function Api:IsInAshran()
	return IsInAshran
end

-- Called when the zone has changed.
function Api:OnZoneChanged()
	SetMapToCurrentZone()
	IsInAshran = GetCurrentMapAreaID() == Api.AreaID
end