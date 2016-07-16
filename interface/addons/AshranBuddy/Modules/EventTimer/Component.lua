local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local EventTimer = Engine:GetModule("EventTimer")

local States = EventTimer.States
local Transitions = {}
Transitions[States.Inactive] = States.Intermission
Transitions[States.Intermission] = States.Hidden
Transitions[States.Announced] = States.PreActive
Transitions[States.GraveyardAlliance] = States.GraveyardAllianceOverflow
Transitions[States.GraveyardHorde] = States.GraveyardHordeOverflow

function EventTimer:Lock()
	local settings = Settings:Get(self.Name)

	if (not Api:IsInAshran()) then
		self.Component:Hide()
	end
	self.Handle:Hide()
	
	local point, relativeTo, relativePoint, x, y = self.Component:GetPoint(1)
	settings.point = point
	settings.relativePoint = relativePoint
	settings.x = x
	settings.y = y
end

function EventTimer:Unlock()
	self.Component:Show()
	self.Handle:Show()
end

function EventTimer:InitializeComponent(width, height)
	local settings = Settings:Get(self.Name)

	self.statusBars = {}
	EventTimer.IsStackRequired = false
	
	local frame = self.Component
	frame:SetParent(UIParent)
	frame:SetSize(width, height)
	frame:SetPoint(settings.point, UIParent, settings.relativePoint, settings.x, settings.y)
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" })
	frame:SetBackdropColor(0, 0, 0, 0)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	
	local handle = CreateFrame("Frame", nil, frame)
	handle:SetSize(width, height)
	handle:SetPoint("TOPLEFT", frame)
	handle:Hide()

	local handleBox = handle:CreateTexture(nil, "OVERLAY", nil, -1)
	handleBox:SetTexture(0, 0, 0, 0.6)
	handleBox:SetSize(width, height)
	handleBox:SetPoint("TOPLEFT")
	
	local handleFontString = handle:CreateFontString("HandleLabel", "OVERLAY", "TextStatusBarText")
	handleFontString:SetPoint("CENTER")
	handleFontString:SetText(Locale.TIMER_HANDLE_TOOLTIP)
	
	-- Children
	self.Handle = handle
	local offset = -5
	for key, value in pairs(EventTimer.Events) do
		self.statusBars[#self.statusBars + 1] = self:CreateStatusBarFrame(frame, value.ID, value.Title, value.MapX, value.MapY, offset)
		offset = offset - 15
	end

	-- Graveyard
	self.graveyardBar = self:CreateGraveyardFrame(frame, "", offset)
	offset = offset - 15

	-- Ogre
	--self.ogreBar = self:CreateOgreFrame(frame, "", offset)
	
	-- Events
	frame:SetScript("OnUpdate", EventTimer.OnUpdate)
	frame:SetScript("OnMouseDown", function(self)
		if (settings.locked == false) then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnMouseUp", function(self)
		if (settings.locked == false) then
			self:StopMovingOrSizing()
		end
	end)
end

function EventTimer:CreateStatusBarFrame(parent, id, title, mapX, mapY, offset)
	local settings = Settings:Get(self.Name)
	local width = parent:GetWidth() - 10

	local statusBar = CreateFrame("StatusBar", nil, parent)
	statusBar:SetWidth(width)
	statusBar:SetHeight(10)
	statusBar:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, offset)
	statusBar:SetMinMaxValues(0, 180)
	statusBar:SetValue(0)
	statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	statusBar:SetStatusBarColor(0.26, 0.42, 1)

	-- Artwork Layer
	local borderLeft = statusBar:CreateTexture("BorderLeft", "ARTWORK")
	borderLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderLeft:SetTexCoord(0.007843, 0.043137, 0.193548, 0.774193)
	borderLeft:SetPoint("LEFT", -3, 0)
	borderLeft:SetSize(9, 14)

	local borderRight = statusBar:CreateTexture("BorderRight", "ARTWORK")
	borderRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderRight:SetTexCoord(0.043137, 0.007843, 0.193548, 0.774193)
	borderRight:SetPoint("RIGHT", 3, 0)
	borderRight:SetSize(9, 14)
	
	local borderMid = statusBar:CreateTexture("BorderMid", "ARTWORK")
	borderMid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderMid:SetTexCoord(0.113726, 0.1490196, 0.193548, 0.774193)
	borderMid:SetPoint("TOPLEFT", borderLeft, "TOPRIGHT")
	borderMid:SetPoint("BOTTOMRIGHT", borderRight, "BOTTOMLEFT")
	borderMid:SetSize(9, 14)

	statusBar.eventNameFontString = statusBar:CreateFontString("EventNameLabel", "ARTWORK", "TextStatusBarText")
	statusBar.eventNameFontString:SetPoint("LEFT", statusBar, "LEFT", 8, 0)

	statusBar.eventTimeFontString = statusBar:CreateFontString("EventTimeLabel", "ARTWORK", "TextStatusBarText")
	statusBar.eventTimeFontString:SetPoint("RIGHT")
	
	if (not settings.showTimer) then
		statusBar.eventTimeFontString:Hide()
	end
	
	-- Background Layer
	local barFull = statusBar:CreateTexture("BarFull", "BACKGROUND")
	barFull:SetVertexColor(0.04, 0.07, 0.18)
	
	statusBar.eventID = id
	statusBar.state = States.Hidden
	statusBar.mapX = mapX
	statusBar.mapY = mapY
	
	statusBar.GetEventID = function(self)
		return self.eventID
	end
	statusBar.GetEventTitle = function(self)
		return self.eventNameFontString:GetText()
	end
	statusBar.SetEventTitle = function(self, value)
		self.eventNameFontString:SetText(value)
	end
	statusBar.SetEventTime = function(self, value)
		self.eventTimeFontString:SetText(value)
	end
	statusBar.GetOrder = function(self)
		return ((self.state.Category * 100000) - self:GetValue())
	end
	statusBar.GetState = function(self)
		return self.state
	end
	statusBar.SetState = function(self, state)
		self.state = state
		if (self.eventTimer ~= nil) then
			EventTimer:CancelTimer(self.eventTimer)
			self.eventTimer = nil
		end
		if (state == States.Hidden) then
			self:SetEventTime("")
			self:SetMinMaxValues(state.MinValue, state.MaxValue)
			self:SetValue(state.Value)
			self:Hide()
		elseif (Api:IsInAshran()) then	
			if (state == States.Inactive) then
				self:SetEventTitle(Locale.TIMER_COOLDOWN)
			elseif (state == States.Intermission) then
				self:SetEventTitle(Locale.TIMER_BE_READY)
			else
				self:SetEventTitle(EventTimer.Events[self.eventID].Title)
			end
		
			local timeLeft = state.MaxValue - state.Value
			local text = state.Text
			if (text == nil) then
				text = string.format(Locale.ADDON_TIME_FORMAT, timeLeft / 60 % 60, timeLeft % 60)
			end
			
			self:SetEventTime(text)
			self:SetMinMaxValues(state.MinValue, state.MaxValue)
			self:SetValue(state.Value)
			self:SetStatusBarColor(state.Red, state.Green, state.Blue)
		
			if (Transitions[state] ~= nil) then
				self.eventTimer = EventTimer:ScheduleRepeatingTimer("OnTimerCallback", 1, self, Transitions[state])
			end
			
			self:Show()
		end
		EventTimer.IsStackRequired = true
	end

	statusBar:SetScript("OnMouseDown", EventTimer.OnStatusBarClick)
	
	statusBar:SetEventTitle(title)
	statusBar:SetEventTime("")
	statusBar:Hide()
	
	-- Skin if applicable addons are loaded.
	if (IsAddOnLoaded("ElvUI") or IsAddOnLoaded("Tukui")) then
		local c
		if ElvUI then
			local E, L, V, P, G, DF = unpack(ElvUI)
			c = E
		else
			local T, C, L, G = unpack(Tukui)
			c = T
			c.TexCoords = {.08, .92, .08, .92}
		end
		statusBar:StripTextures(true)
		statusBar:CreateBackdrop()
		if c.media then
			statusBar:SetStatusBarTexture(c.media.normTex)
		elseif c.Medias then
			statusBar:SetStatusBarTexture(c.Medias.Normal)
		end
	end
	
	return statusBar
end

function EventTimer:CreateGraveyardFrame(parent, title, offset)
	local settings = Settings:Get(self.Name)
	local width = parent:GetWidth() - 10

	local statusBar = CreateFrame("StatusBar", nil, parent)
	statusBar:SetWidth(width)
	statusBar:SetHeight(10)
	statusBar:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, offset)
	statusBar:SetMinMaxValues(0, 180)
	statusBar:SetValue(0)
	statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	statusBar:SetStatusBarColor(0.26, 0.42, 1)

	-- Artwork Layer
	local borderLeft = statusBar:CreateTexture("BorderLeft", "ARTWORK")
	borderLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderLeft:SetTexCoord(0.007843, 0.043137, 0.193548, 0.774193)
	borderLeft:SetPoint("LEFT", -3, 0)
	borderLeft:SetSize(9, 14)

	local borderRight = statusBar:CreateTexture("BorderRight", "ARTWORK")
	borderRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderRight:SetTexCoord(0.043137, 0.007843, 0.193548, 0.774193)
	borderRight:SetPoint("RIGHT", 3, 0)
	borderRight:SetSize(9, 14)
	
	local borderMid = statusBar:CreateTexture("BorderMid", "ARTWORK")
	borderMid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder")
	borderMid:SetTexCoord(0.113726, 0.1490196, 0.193548, 0.774193)
	borderMid:SetPoint("TOPLEFT", borderLeft, "TOPRIGHT")
	borderMid:SetPoint("BOTTOMRIGHT", borderRight, "BOTTOMLEFT")
	borderMid:SetSize(9, 14)

	statusBar.eventNameFontString = statusBar:CreateFontString("EventNameLabel", "ARTWORK", "TextStatusBarText")
	statusBar.eventNameFontString:SetPoint("LEFT", statusBar, "LEFT", 8, 0)

	statusBar.eventTimeFontString = statusBar:CreateFontString("EventTimeLabel", "ARTWORK", "TextStatusBarText")
	statusBar.eventTimeFontString:SetPoint("RIGHT")
	
	if (not settings.showTimer) then
		statusBar.eventTimeFontString:Hide()
	end
	
	-- Background Layer
	local barFull = statusBar:CreateTexture("BarFull", "BACKGROUND")
	barFull:SetVertexColor(0.04, 0.07, 0.18)
	
	statusBar.state = States.Hidden
	
	statusBar.GetEventTitle = function(self)
		return self.eventNameFontString:GetText()
	end
	statusBar.SetEventTitle = function(self, value)
		self.eventNameFontString:SetText(value)
	end
	statusBar.SetEventTime = function(self, value)
		self.eventTimeFontString:SetText(value)
	end
	statusBar.GetOrder = function(self)
		return ((self.state.Category * 100000) - self:GetValue())
	end
	statusBar.GetState = function(self)
		return self.state
	end
	statusBar.SetState = function(self, state)
		if self.state ~= state then
			self.state = state
			if (self.eventTimer ~= nil) then
				EventTimer:CancelTimer(self.eventTimer)
				self.eventTimer = nil
			end
			if (state == States.Hidden) then
				self:SetEventTime("")
				self:SetMinMaxValues(state.MinValue, state.MaxValue)
				self:SetValue(state.Value)
				self:Hide()
			elseif (Api:IsInAshran()) then
				if state == States.GraveyardAlliance or state == States.GraveyardAllianceOverflow then
					self:SetEventTitle(Locale.TIMER_GRAVEYARD_ALLIANCE)
				elseif state == States.GraveyardHorde or state == States.GraveyardHordeOverflow then
					self:SetEventTitle(Locale.TIMER_GRAVEYARD_HORDE)
				else
					self:SetEventTitle(Locale.TIMER_GRAVEYARD_NEUTRAL)
				end
		
				local timeLeft = state.MaxValue - state.Value
				local text = state.Text
				if (text == nil) then
					text = string.format(Locale.ADDON_TIME_FORMAT, timeLeft / 60 % 60, timeLeft % 60)
				end
			
				self:SetEventTime(text)
				self:SetMinMaxValues(state.MinValue, state.MaxValue)
				self:SetValue(state.Value)
				self:SetStatusBarColor(state.Red, state.Green, state.Blue)
		
				if (Transitions[state] ~= nil) then
					self.eventTimer = EventTimer:ScheduleRepeatingTimer("OnTimerCallback", 1, self, Transitions[state])
				end
			
				self:Show()
			end
			EventTimer.IsStackRequired = true
		end
	end
	
	statusBar:SetEventTitle(title)
	statusBar:SetEventTime("")
	statusBar:Hide()
	
	-- Skin if applicable addons are loaded.
	if (IsAddOnLoaded("ElvUI") or IsAddOnLoaded("Tukui")) then
		local c
		if ElvUI then
			local E, L, V, P, G, DF = unpack(ElvUI)
			c = E
		else
			local T, C, L, G = unpack(Tukui)
			c = T
			c.TexCoords = {.08, .92, .08, .92}
		end
		statusBar:StripTextures(true)
		statusBar:CreateBackdrop()
		if c.media then
			statusBar:SetStatusBarTexture(c.media.normTex)
		elseif c.Medias then
			statusBar:SetStatusBarTexture(c.Medias.Normal)
		end
	end
	
	return statusBar
end