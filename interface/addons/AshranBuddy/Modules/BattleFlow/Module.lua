local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Extensions
local lastindexof = Engine.Core.StringLastIndexOf
local contains = Engine.Core.TableContains
local indexof = Engine.Core.TableIndexOf

-- Registration
local BattleFlow = Engine:RegisterModule("BattleFlow")
BattleFlow.Points = { Locale.BATTLEFLOW_TREMBLADE, Locale.BATTLEFLOW_OVERWATCH, Locale.BATTLEFLOW_VANGUARD, Locale.BATTLEFLOW_CROSSROADS, Locale.BATTLEFLOW_ADVANCE, Locale.BATTLEFLOW_EMBERFALL, Locale.BATTLEFLOW_VOLRATH }
BattleFlow.States = { Intermission = -1, Contested = 0, Alliance = 1, Horde = 2 }

local IsTooltipsLoaded = false

-- Initialize the module.
function BattleFlow:OnInitialize()
	-- Invalid settings fix
	local settings = Settings:Get(self.Name)
	if settings.point == nil or settings.relativePoint == nil or settings.x == nil or settings.y == nil then
		settings = {
			point = "TOP",
			relativePoint = "TOP",
			x = 0,
			y = -10
		}
	end

	-- Battle Flow operates using localised text returned by GetWorldStateUIInfo(i)
	-- The text used must match exactly otherwise the majority of this module will not function
	-- Each language will be enabled manually until all Locales are available
	if (not self:IsCompatible()) then
		return
	end
		
	if (not Api:IsInAshran()) then
		self.Component:Hide()
	end
	
	-- Create and initialize all required frames and textures
	self:InitializeComponent(25)
end

-- Called when the module is enabled.
function BattleFlow:OnEnable()
	local settings = Settings:Get(self.Name)
	-- Battle Flow operates using localised text returned by GetWorldStateUIInfo(i)
	-- The text used must match exactly otherwise the majority of this module will not function
	-- Each language will be enabled manually until all Locales are available
	if (not self:IsCompatible()) then
		return
	end
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	self:RegisterEvent("UPDATE_WORLD_STATES", "OnUpdateWorldStates")
	self:RegisterEvent("WORLD_STATE_UI_TIMER_UPDATE", "OnUpdateWorldStates")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnZoneChanged")
	
	if (not settings.locked) then
		BattleFlow:Unlock()
	end
	
	if (Api:IsInAshran()) then
		self.Component:Show()
		WorldStateAlwaysUpFrame:Hide()
	else
		if (not settings.locked) then
			BattleFlow:Unlock()
			self.Component:Show()
		else
			self.Component:Hide()
		end
		WorldStateAlwaysUpFrame:Show()
	end
end

-- Called when the module is disabled.
function BattleFlow:OnDisable()
	self:UnregisterAllEvents()
	self.Component:Hide()
	
	WorldStateAlwaysUpFrame:Show()
end

-- Battle Flow will only operate correctly for English and French game clients at this stage.
function BattleFlow:IsCompatible()
	local locale = GetLocale()
	return locale == "enUS" or locale == "enGB" or locale == "frFR"
end

function BattleFlow:OnPlayerEnteringWorld(event)
	local settings = Settings:Get(self.Name)
	if Api:IsInAshran() then
		self.Component:Show()
		WorldStateAlwaysUpFrame:Hide()	
		self:OnUpdateWorldStates()
	else
		if not settings.locked then
			self:Unlock()
		else
			self.Component:Hide()
		end
		WorldStateAlwaysUpFrame:Show()	
	end
end

function BattleFlow:OnUpdateWorldStates(event)
	if Api:IsInAshran() then
		self:SuppressDefaultCaptureBar()

		local states, slain, timer, event, capture = self:GetWorldStates()
		self:SetWorldStates(states, slain, timer, event, capture)
		self:SetTooltips()
	end
end

function BattleFlow:OnZoneChanged(event)
	local settings = Settings:Get(self.Name)
	if (Api:IsInAshran()) then
		self.Component:Show()
		WorldStateAlwaysUpFrame:Hide()		
	else
		if (settings.locked == false) then
			self:Unlock()
		else
			self.Component:Hide()
		end
		WorldStateAlwaysUpFrame:Show()	
	end
end

function BattleFlow:GetWorldStates()
	local states = { BattleFlow.States.Intermission, BattleFlow.States.Intermission, BattleFlow.States.Intermission, BattleFlow.States.Intermission, BattleFlow.States.Intermission, BattleFlow.States.Intermission, BattleFlow.States.Intermission }
	local slain = nil
	local timer = nil
	local event = nil
	local capture = nil
	
	local count = GetNumWorldStateUI()
	for i = 1, count do
		local uiType, state, hidden, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extendedUIState1, extendedUIState2, extendedUIState3 = GetWorldStateUIInfo(i)
		if (uiType == 3 and state > 0) then
			if (timer == nil) then
				timer = {}
			end
			timer.Text = text
			timer.Tooltip = tooltip
		elseif (uiType == 0 and state > 0) then
			local index = indexof(BattleFlow.Points, text)
			if (index ~= -1) then
				states[index] = BattleFlow.States.Contested
			elseif (text:find(Locale.BATTLEFLOW_ENEMIES_SLAIN)) then
				if (slain == nil) then
					slain = {}
				end
				local i = #slain + 1
				slain[i] = { Faction = "", Text = "" }
				
				local startIndex, endIndex = text:find(": ")
				slain[i].Faction = "Horde"
				if (icon:find("Alliance")) then
					slain[i].Faction = "Alliance"
				end
				slain[i].Text = text:sub(endIndex + 1)
				slain[i].Tooltip = tooltip
			elseif (text:find(Locale.BATTLEFLOW_ORE_COLLECTED) or text:find(Locale.BATTLEFLOW_SPIRITS_CAPTURED) or text:find(Locale.BATTLEFLOW_RACE_LAPS) or text:find(Locale.BATTLEFLOW_FIRES_SCORE) or text:find(Locale.BATTLEFLOW_MARKS_COLLECTED)) then
				if (event == nil) then
					event = {}
				end
				local i = #event + 1
				event[i] = { Faction = "", Value = 0, MaxValue = 0, Text = "" }

				event[i].Faction = "Horde"
				if (icon:find("Alliance")) then
					event[i].Faction = "Alliance"
				end
				
				local startIndex = lastindexof(text, ": ")
				local endIndex = lastindexof(text, "/")
				local value = text:sub(startIndex + 1, endIndex - 1)
				local maxValue = text:sub(endIndex + 1)
				
				event[i].MaxValue = tonumber(maxValue)
				event[i].Value = tonumber(value)
				event[i].Text = text
			elseif (extendedUI == "CAPTUREPOINT") then
				capture = tonumber(extendedUIState1)
			else
				if (timer == nil) then
					timer = {}
				end
				timer.Text = text
				timer.Tooltip = tooltip
			end
		end
		if (state == 0 and (text:find(Locale.BATTLEFLOW_ORE_COLLECTED) or text:find(Locale.BATTLEFLOW_SPIRITS_CAPTURED) or text:find(Locale.BATTLEFLOW_RACE_LAPS) or text:find(Locale.BATTLEFLOW_FIRES_SCORE) or text:find(Locale.BATTLEFLOW_MARKS_COLLECTED))) then
			event = nil
		elseif (state == 0 and extendedUI == "CAPTUREPOINT" and extendedUIState2 > 0) then
			capture = nil
		end
	end
	if (contains(states, BattleFlow.States.Contested)) then
		local faction = BattleFlow.States.Alliance
		for i = 1, #states do
			if (states[i] == BattleFlow.States.Contested) then
				faction = BattleFlow.States.Horde
			else
				states[i] = faction
			end
		end
	end
	return states, slain, timer, event, capture
end

function BattleFlow:SetWorldStates(states, slain, timer, event, capture)
	local component = self.Component
	-- BattleFlow.States
	if #self.controlPoints == #states then
		for i = 1, #self.controlPoints do
			self.controlPoints[i]:SetState(states[i])
		end
	end
	-- Slain
	if (slain ~= nil) then
		for i = 1, #slain do
			component.SlainCounter[slain[i].Faction]:SetText(slain[i].Text)
			component.SlainCounter[slain[i].Faction].Tooltip = slain[i].Tooltip
		end
	end
	-- Timer
	if (timer ~= nil) then
		component.Timer:SetText(timer.Text)
		component.Timer.Tooltip = timer.Tooltip
	end
	-- Boss Tooltip
	local point = indexof(states, BattleFlow.States.Contested)
	if (point ~= -1 and (point == 1 or point == #BattleFlow.Points)) then
		if (not component.BossTooltip:IsShown() and not component.EventBar:IsShown() and not component.CaptureBar:IsShown()) then
			component.BossTooltip:Show()
		end
		component.BossTooltip.Text:SetText(self.controlPoints[point]:GetTooltip())
	else
		component.BossTooltip:Hide()
	end
	-- Event
	if (event ~= nil) then
		if (not component.EventBar:IsShown()) then
			component.BossTooltip:Hide()
			component.EventBar:Show()
		end
		for i = 1, #event do
			component.EventBar[event[i].Faction]:SetMinMaxValues(0, event[i].MaxValue)
			component.EventBar[event[i].Faction]:SetValue(math.min(event[i].Value, event[i].MaxValue))
			component.EventBar[event[i].Faction].Text:SetText(event[i].Text)
		end
	elseif (event == nil and component.EventBar:IsShown()) then
		component.EventBar:Hide()
	end
	-- Capture
	if (capture ~= nil) then
		if (not component.CaptureBar:IsShown()) then
			component.BossTooltip:Hide()
			component.CaptureBar:Show()
		end
		component.CaptureBar:SetValue(capture)
	elseif (capture == nil and component.CaptureBar:IsShown()) then
		component.CaptureBar:Hide()
	end
end

function BattleFlow:SetTooltips()
	if (not IsTooltipsLoaded) then
		local count = GetNumWorldStateUI()
		for i = 1, count do
			local uiType, state, hidden, text, icon, dynamicIcon, tooltip, dynamicTooltip, extendedUI, extendedUIState1, extendedUIState2, extendedUIState3 = GetWorldStateUIInfo(i)
			local index = indexof(BattleFlow.Points, text)
			if (index ~= -1) then
				self.controlPoints[index]:SetTooltip(tooltip)
				IsTooltipsLoaded = true
			end
		end
	end	
end

function BattleFlow:SuppressDefaultCaptureBar()
	if (NUM_EXTENDED_UI_FRAMES) then
 		local captureBar
 		for i = 1, NUM_EXTENDED_UI_FRAMES do
 			captureBar = _G["WorldStateCaptureBar"..i]
 			if (captureBar) then
 				captureBar:Hide()
 			end
 		end
 	end
end