local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Extensions
local roundup = Engine.Core.MathRoundUp

-- Constants
local ON_UPDATE_INTERVAL = 1.0

-- Registration
local EventTimer = Engine:RegisterModule("EventTimer")
LibStub("AceTimer-3.0"):Embed(EventTimer)

EventTimer.Events = {}
EventTimer.Events[178019] = { ID = 178019, Name = Locale.TIMER_COLLECT_EMPOWERED_ORE, Title = Locale.TIMER_EMPOWERED_ORE, MapX = 0.57, MapY = 0.7 }
EventTimer.Events[178021] = { ID = 178021, Name = Locale.TIMER_OGRE_FIRES, Title = Locale.TIMER_OGRE_FIRES, MapX = 0.61, MapY = 0.31 }
EventTimer.Events[178020] = { ID = 178020, Name = Locale.TIMER_RISEN_SPIRITS, Title = Locale.TIMER_RISEN_SPIRITS, MapX = 0.36, MapY = 0.63 }
EventTimer.Events[178022] = { ID = 178022, Name = Locale.TIMER_STADIUM_RACING, Title = Locale.TIMER_STADIUM_RACING, MapX = 0.36, MapY = 0.36 }
EventTimer.Events[186255] = { ID = 186255, Name = Locale.TIMER_COLLECT_APEXIS_MARKS, Title = Locale.TIMER_APEXIS_MARKS }

local factionGroup, _ = UnitFactionGroup("player")
if (factionGroup == "Alliance") then
	EventTimer.Events[186255].MapX = 0.45
	EventTimer.Events[186255].MapY = 0.63
else
	EventTimer.Events[186255].MapX = 0.47
	EventTimer.Events[186255].MapY = 0.39
end

EventTimer.States = {}
EventTimer.States.Hidden = { ID = -1, Category = 10, Value = 0, MinValue = 0, MaxValue = 0, Red = 0, Green = 0, Blue = 0, Text = "", Message = nil }
EventTimer.States.Inactive = { ID = 0, Category = 5, Value = 0, MinValue = 0, MaxValue = 120, Red = 0.5, Green = 0.5, Blue = 0.5, Text = nil, Message = Locale.TIMER_ON_COOLDOWN }
EventTimer.States.Intermission = { ID = 1, Category = 4, Value = 0, MinValue = 0, MaxValue = 420, Red = 1, Green = 0, Blue = 0, Text = nil, Message = Locale.TIMER_INTERMISSION }
EventTimer.States.Announced = { ID = 2, Category = 3, Value = 0, MinValue = 0, MaxValue = 180, Red = 0.26, Green = 0.42, Blue = 1, Text = nil, Message = Locale.TIMER_ANNOUNCED }
EventTimer.States.PreActive = { ID = 3, Category = 2, Value = 60, MinValue = 0, MaxValue = 60, Red = 0, Green = 1, Blue = 0, Text = "", Message = Locale.TIMER_ACTIVE }
EventTimer.States.Active = { ID = 4, Category = 1, Value = 60, MinValue = 0, MaxValue = 60, Red = 0, Green = 1, Blue = 0, Text = "", Message = Locale.TIMER_ACTIVE }

EventTimer.States.GraveyardNeutral = { ID = 1, Category = 6, Value = 100, MinValue = 0, MaxValue = 100, Red = 1, Green = 1, Blue = 0, Text = "", Message = "" }
EventTimer.States.GraveyardAlliance = { ID = 2, Category = 6, Value = 0, MinValue = 0, MaxValue = 900, Red = 0, Green = 0, Blue = 1, Text = "", Message = "" }
EventTimer.States.GraveyardAllianceOverflow = { ID = 3, Category = 6, Value = 60, MinValue = 0, MaxValue = 60, Red = 0, Green = 0, Blue = 1, Text = "", Message = "" }
EventTimer.States.GraveyardHorde = { ID = 4, Category = 6, Value = 0, MinValue = 0, MaxValue = 900, Red = 1, Green = 0, Blue = 0, Text = "", Message = "" }
EventTimer.States.GraveyardHordeOverflow = { ID = 5, Category = 6, Value = 60, MinValue = 0, MaxValue = 60, Red = 1, Green = 0, Blue = 0, Text = "", Message = "" }

EventTimer.IsStackRequired = false

local LandmarkTextureIndex = 60
local Throttle = 0

-- Initialize the module.
function EventTimer:OnInitialize()
	self:InitializeComponent(220, 65)
end

-- Called when the module is enabled.
function EventTimer:OnEnable()
	local settings = Settings:Get(self.Name)

	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE", "OnAnnouncement")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "OnBroadcast")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnZoneChanged")
	
	settings.stacked = true
	if (not settings.locked) then
		EventTimer:Unlock()
	end
	self.Component:Show()
end

-- Called when the module is disabled.
function EventTimer:OnDisable()
	self:UnregisterAllEvents()
	for i = 1, #EventTimer.statusBars do
		local statusBar = self.statusBars[i]
		statusBar:SetState(EventTimer.States.Hidden)
	end
	EventTimer.graveyardBar:SetState(EventTimer.States.Hidden)
	self.Component:Hide()
end

function EventTimer:OnAnnouncement(event, message, sender, language, channelString, target, flags, unused1, channelNumber, channelName, unused2, counter)
	if (Api:IsInAshran()) then
		for i = 1, #self.statusBars do
			local statusBar = self.statusBars[i]
			if message:find(statusBar:GetEventID()) then
				statusBar:SetState(EventTimer.States.Announced)				
				for j = 1, #self.statusBars do
					if self.statusBars[j] ~= statusBar then
						self.statusBars[j]:SetState(EventTimer.States.Hidden)
					end
				end
			end
		end
	end
end

function EventTimer:OnBroadcast(event, message, sender, language, channelString, target, flags, unused1, channelNumber, channelName, unused2, counter)
	if (Api:IsInAshran()) then
		-- Locale.TIMER_KORLOK_SENDER = "Kor'lok"
		-- Locale.TIMER_KORLOK_MSG_AWAKE = "I have returned"
		-- Locale.TIMER_KORLOK_MSG_DEATH = "The empire"
		-- Locale.TIMER_KORLOK_MSG_ALLIANCE = "Little blue warriors"
		-- Locale.TIMER_KORLOK_MSG_HORDE = "The red ones"
		if sender == Locale.TIMER_GRAVEYARD_SENDER then
			if message:find(Locale.TIMER_GRAVEYARD_MSG_NEUTRAL) then
				self.graveyardBar:SetState(EventTimer.States.GraveyardNeutral)
			elseif message:find(Locale.TIMER_GRAVEYARD_MSG_ALLIANCE) then
				self.graveyardBar:SetState(EventTimer.States.GraveyardAlliance)
			elseif message:find(Locale.TIMER_GRAVEYARD_MSG_HORDE) then
				self.graveyardBar:SetState(EventTimer.States.GraveyardHorde)
			end
		end
	end
end

function EventTimer:OnZoneChanged(event)
	if (Api:IsInAshran()) then
		self.Component:Show()
	else
		local settings = Settings:Get(self.Name)
		if (settings.locked == false) then
			self:Unlock()
		else
			self.Component:Hide()
		end
		for i = 1, #EventTimer.statusBars do
			local statusBar = self.statusBars[i]
			statusBar:SetState(EventTimer.States.Hidden)
		end
	end
end

function EventTimer:OnPlayerEnteringWorld(event)
	if (Api:IsInAshran()) then
		self.Component:Show()
	else
		local settings = Settings:Get(self.Name)
		if (settings.locked == false) then
			self:Unlock()
		else
			self.Component:Hide()
		end
	end
end

function EventTimer:OnUpdate(elapsed)
	if (not Api:IsInAshran()) then
		return
	end

	Throttle = Throttle + elapsed
	if Throttle > ON_UPDATE_INTERVAL then
		Throttle = Throttle - ON_UPDATE_INTERVAL

		-- Compensate for delays on the update such as a loading screen or reload ui
		if (elapsed > 2.0) then
			for i = 1, #EventTimer.statusBars do
				local statusBar = EventTimer.statusBars[i]
				if (statusBar:GetState() ~= EventTimer.States.Hidden) then
					statusBar:SetValue(statusBar:GetValue() + elapsed)
				end
			end
		end
	
		-- Detect if an event has become active or was active and has just finished
		local landmarks = EventTimer:GetLandmarks()
		for i = 1, #EventTimer.statusBars do
			local statusBar = EventTimer.statusBars[i]
			local event = EventTimer.Events[statusBar:GetEventID()]
			local exists = EventTimer:FindLandmark(landmarks, event.MapX, event.MapY)
			if (exists) then
				statusBar:SetState(EventTimer.States.Active)
			elseif (not exists and statusBar:GetState() == EventTimer.States.Active) then
				statusBar:SetState(EventTimer.States.Inactive)
			end
		end
	
		-- Stack the status bars so the active one is at the top
		local settings = Settings:Get("EventTimer")
		if (EventTimer.IsStackRequired and settings.stacked) then
			local bars = {}
			for i = 1, #EventTimer.statusBars do
				bars[#bars + 1] = { EventTimer.statusBars[i]:GetOrder(), EventTimer.statusBars[i] }
			end
			bars[#bars + 1] = { EventTimer.graveyardBar:GetOrder(), EventTimer.graveyardBar }
			table.sort(bars, function(a, b) return a[1] < b[1] end)
		
			local anchor = "TOPLEFT"
			local y = -5
			for key, value in pairs(bars) do
				value[2]:ClearAllPoints()
				value[2]:SetPoint("TOPLEFT", EventTimer.Component, anchor, 5, y)
				y = y - 15
			end
		
			EventTimer.IsStackRequired = false
		end
	
		-- Stack back in default order
		if (not settings.stacked) then
			local y = -5
			for i = 1, #EventTimer.statusBars do
				EventTimer.statusBars[i]:ClearAllPoints()
				EventTimer.statusBars[i]:SetPoint("TOPLEFT", EventTimer.Component, "TOPLEFT", 5, y)
				y = y - 15
			end
			EventTimer.graveyardBar:ClearAllPoints()
			EventTimer.graveyardBar:SetPoint("TOPLEFT", EventTimer.Component, "TOPLEFT", 5, y)
		end
	end
end

function EventTimer:OnStatusBarClick(button)
	local state = self:GetState()
	local minValue, maxValue = self:GetMinMaxValues()
	local timeLeft = maxValue - self:GetValue()
	local timeText = string.format(Locale.ADDON_TIME_FORMAT, timeLeft / 60 % 60, timeLeft % 60)
	
	local message = ""
	if (self:GetState() == EventTimer.States.Inactive) then
		message = Locale.TIMER_ALL_EVENTS
	elseif (self:GetState() == EventTimer.States.Intermission) then
		message = Locale.TIMER_A_RANDOM_EVENT
	else
		message = GetSpellLink(self:GetEventID())
	end
	message = string.format(Locale.TIMER_CHAT_PREFIX, message)
	message = string.format(state.Message, message, timeText)

	if (button == "LeftButton" and IsShiftKeyDown() and IsInRaid()) then
		SendChatMessage(message, "INSTANCE_CHAT")
	end
	if (button == "LeftButton" and IsAltKeyDown() and IsInRaid()) then
		SendChatMessage(message, "RAID_WARNING")
	end
end

function EventTimer:OnTimerCallback(statusBar, transition)
	local value = statusBar:GetValue()
	local minValue, maxValue = statusBar:GetMinMaxValues()
	local timeLeft = maxValue - value
	
	statusBar:SetEventTime(string.format(Locale.ADDON_TIME_FORMAT, timeLeft / 60 % 60, timeLeft % 60))
	statusBar:SetValue(value + 1)

	if (value >= maxValue) then
		statusBar:SetState(transition)
	end
end

-- Gets a list of event landmarks currently active.
function EventTimer:GetLandmarks()
	local landmarks = {}

	local continent = GetCurrentMapContinent()
	local zone = GetCurrentMapZone()
	local microdungeon = select(4, GetMapInfo())
	SetMapByID(Api.AreaID)

	local count = GetNumMapLandmarks()
	for i = 1, count do
		local _, _, textureIndex, x, y, _, _, _, _, _, _ = GetMapLandmarkInfo(i)
		if textureIndex == LandmarkTextureIndex then
			table.insert(landmarks, { x = roundup(x, 2), y = roundup(y, 2) })
		end
	end
	
	if zone > 0 then
		SetMapZoom(continent, zone)
	else
		SetMapZoom(continent)
	end
	if microdungeon then
		SetMapToCurrentZone()
	end

	return landmarks
end

-- Gets a value indicating if the specified event (by coordinates) is currently active.
function EventTimer:FindLandmark(landmarks, mapX, mapY)
	for i = 1, #landmarks do
		if mapX == landmarks[i].x and mapY == landmarks[i].y then
			return true
		end
	end
	return false
end