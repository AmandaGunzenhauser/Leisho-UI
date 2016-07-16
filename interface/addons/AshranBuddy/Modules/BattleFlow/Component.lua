local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local BattleFlow = Engine:GetModule("BattleFlow")

local States = BattleFlow.States
local Colors = {}
Colors[States.Alliance] = { Red = (20 / 255), Green = (69 / 255), Blue = (133 / 255) }
Colors[States.Contested] = { Red = (180 / 210), Green = (180 / 255), Blue = (0 / 255) }
Colors[States.Horde] = { Red = (191 / 255), Green = (27 / 255), Blue = (27 / 255) }
Colors[States.Intermission] = { Red = 0.5, Green = 0.5, Blue = 0.5 }

function BattleFlow:Lock()
	local settings = Settings:Get(self.Name)
	if not Api:IsInAshran() then
		self.Component:Hide()
	end
	if self.Handle ~= nil then
		self.Handle:Hide()
	end
	
	local point, relativeTo, relativePoint, x, y = self.Component:GetPoint(1)
	settings.point = point
	settings.relativePoint = relativePoint
	settings.x = x
	settings.y = y
end

function BattleFlow:Unlock()
	self.Component:Show()
	if self.Handle ~= nil then
		self.Handle:Show()
	end
end

function BattleFlow:InitializeComponent(size)
	local settings = Settings:Get(self.Name)
	local count = #BattleFlow.Points
	local offset = 5
	local width = (size * count) + (offset * (count - 1))
	
	self.controlPoints = {}
	
	local frame = self.Component
	frame:SetParent(UIParent)
	frame:SetSize(width, size)
	frame:SetPoint(settings.point, UIParent, settings.relativePoint, settings.x, settings.y)
	frame:SetToplevel(true)
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	
	local x = 0
	for i = 1, #BattleFlow.Points do
		self.controlPoints[i] = self:CreateControlPointFrame("Point"..i, BattleFlow.Points[i], frame, size, size, x, 0)
		x = x + size + offset
	end
	
	self:CreateFactionMarkerFrame(frame)
	self:CreateSlainCounterFrame(frame)
	self:CreateTimerFrame(frame)
	self:CreateEventBarFrame(frame, width)
	self:CreateCaptureBarFrame(frame, width)
	self:CreateBossTooltipFrame(frame)
	
	frame:SetScript("OnHide", function(self)
		for i = 1, #BattleFlow.controlPoints do
			BattleFlow.controlPoints[i].state = States.Intermission
		end
		self.SlainCounter.Alliance:SetText("")
		self.SlainCounter.Horde:SetText("")
		self.Timer:SetText("")
	end)
	
	-- Handle
	self.Handle = CreateFrame("Frame", nil, frame)

	local handle = self.Handle
	handle:SetSize(width + 200, size + 45)
	handle:SetPoint("TOPLEFT", frame, "TOPLEFT", -100, 0)
	handle:Hide()

	local handleBox = handle:CreateTexture(nil, "OVERLAY", nil, -1)
	handleBox:SetTexture(0, 0, 0, 0.6)
	handleBox:SetSize(width + 200, size + 45)
	handleBox:SetPoint("TOPLEFT")
	
	local handleFontString = handle:CreateFontString("HandleLabel", "OVERLAY", "TextStatusBarText")
	handleFontString:SetPoint("CENTER")
	handleFontString:SetText(Locale.BATTLEFLOW_HANDLE_TOOLTIP)

	handle:SetScript("OnMouseDown", function(self)
		print(settings.locked)
		if not settings.locked then
			self:GetParent():StartMoving()
		end
	end)
	handle:SetScript("OnMouseUp", function(self)
		if not settings.locked then
			self:GetParent():StopMovingOrSizing()
		end
	end)
end

function BattleFlow:CreateControlPointFrame(name, title, parent, width, height, x, y)
	local color = Colors[States.Intermission]

	local controlPoint = CreateFrame("Frame", name, parent)
	controlPoint:SetSize(width, height)
	controlPoint:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

	controlPoint.Texture = controlPoint:CreateTexture(nil, "BACKGROUND")
	controlPoint.Texture:SetTexture(color.Red, color.Green, color.Blue, 1)
	controlPoint.Texture:SetSize(width, height)
	controlPoint.Texture:SetPoint("TOPLEFT")
	
	controlPoint.title = title
	controlPoint.tooltip = nil
	controlPoint.state = States.Contested

	controlPoint.GetTitle = function(self)
		return self.title
	end
	controlPoint.GetTooltip = function(self)
		return self.tooltip
	end
	controlPoint.SetTooltip = function(self, value)
		self.tooltip = value
	end
	controlPoint.GetState = function(self)
		return self.state
	end
	controlPoint.SetState = function(self, state)
		local color = Colors[state]
		self.Texture:SetTexture(color.Red, color.Green, color.Blue, 1)
		self.state = state
	end
	controlPoint:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self)
		GameTooltip:SetText(self.title)
		if (self.tooltip ~= nil) then
			GameTooltip:AddLine(self.tooltip, 1, 1, 1, true)
		end
        GameTooltip:Show()
	end)
	controlPoint:SetScript("OnLeave", function(self)
		GameTooltip_Hide()
	end)

	return controlPoint
end

function BattleFlow:CreateEventBarFrame(parent, width)
	local height = 5
	local eventBar = CreateFrame("Frame", nil, parent)
	eventBar:SetSize(width, height)
	eventBar:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -(height * 2))

	self:CreateEventBarFactionFrame(eventBar, "Alliance", width, height, Colors[States.Alliance], "RIGHT", "LEFT", -20)
	
	local extent = 4
	eventBar.Divider = CreateFrame("Frame", nil, eventBar)
	eventBar.Divider:SetSize(extent, height + (extent * 2))
	eventBar.Divider:SetPoint("CENTER", eventBar, "CENTER", 0, 0)
	eventBar.Divider:SetFrameStrata("HIGH")
	eventBar.Divider.Texture = eventBar.Divider:CreateTexture(nil, "BACKGROUND")
	eventBar.Divider.Texture:SetTexture(1, 1, 1, 1)
	eventBar.Divider.Texture:SetSize(extent, height + (extent * 2))
	eventBar.Divider.Texture:SetPoint("CENTER")
	
	self:CreateEventBarFactionFrame(eventBar, "Horde", width, height, Colors[States.Horde], "LEFT", "RIGHT", 20)
	
	eventBar:SetScript("OnShow", function(self)
		local parent = self:GetParent()
		parent.Timer:ClearAllPoints()
		parent.Timer:SetPoint("TOP", parent, "BOTTOM", 0, -15)
	end)
	eventBar:SetScript("OnHide", function(self)
		local parent = self:GetParent()
		parent.Timer:ClearAllPoints()
		parent.Timer:SetPoint("TOP", parent, "BOTTOM")
	end)
	
	eventBar:Hide()
	
	parent.EventBar = eventBar
end

function BattleFlow:CreateEventBarFactionFrame(eventBar, faction, width, height, color, anchor1, anchor2, offset)
	eventBar[faction] = eventBar:CreateTexture(nil, "BACKGROUND")
	eventBar[faction]:SetTexture(color.Red, color.Green, color.Blue, 1)
	eventBar[faction]:SetSize(width / 2, height)
	eventBar[faction]:SetPoint(anchor1, eventBar, "CENTER")
	
	eventBar[faction].Text = eventBar:CreateFontString(nil , "BACKGROUND", "GameFontNormalSmall")
	eventBar[faction].Text:SetSize(200, 25)
	eventBar[faction].Text:SetJustifyH(anchor1)
	eventBar[faction].Text:SetPoint(anchor1, eventBar, anchor2, offset, 0)
	eventBar[faction].Text:SetText("")
	
	eventBar[faction].SetMinMaxValues = function(self, minValue, maxValue)
		self.minValue = minValue
		self.maxValue = maxValue
	end
	eventBar[faction].SetValue = function(self, value)
		self.value = value
		if (value == 0) then
			self:Hide()
		else
			self:Show()
		end
		if (self.maxValue > 0) then
			self:SetWidth((self.value / self.maxValue) * self.maxWidth)
		end
	end
	
	eventBar[faction].minValue = 0
	eventBar[faction].maxValue = 0
	eventBar[faction].value = 0
	eventBar[faction].maxWidth = width / 2
end

function BattleFlow:CreateCaptureBarFrame(parent, width)
	local color = Colors[States.Alliance]
	local padding = 10
	local height = 5
	local extent = 4

	local captureBar = CreateFrame("Frame", nil, parent)
	captureBar:SetSize(width, height)
	captureBar:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -(height * 2))
	
	captureBar.maxWidth = width
	
	captureBar.Alliance = captureBar:CreateTexture(nil, "BACKGROUND")
	captureBar.Alliance:SetTexture(color.Red, color.Green, color.Blue, 1)
	captureBar.Alliance:SetSize(padding, height)
	captureBar.Alliance:SetPoint("LEFT", captureBar, "LEFT")
	
	color = Colors[States.Horde]
	
	captureBar.Horde = captureBar:CreateTexture(nil, "BACKGROUND")
	captureBar.Horde:SetTexture(color.Red, color.Green, color.Blue, 1)
	captureBar.Horde:SetSize(padding, height)
	captureBar.Horde:SetPoint("RIGHT", captureBar, "RIGHT")
	
	color = Colors[States.Intermission]
	
	captureBar.Neutral = captureBar:CreateTexture(nil, "BACKGROUND")
	captureBar.Neutral:SetTexture(color.Red, color.Green, color.Blue, 1)
	captureBar.Neutral:SetSize(width - (padding * 2), height)
	captureBar.Neutral:SetPoint("CENTER", captureBar, "CENTER")
	
	captureBar.Divider = CreateFrame("Frame", nil, captureBar)
	captureBar.Divider:SetSize(extent, height + (extent * 2))
	captureBar.Divider:SetPoint("LEFT", captureBar, "LEFT", (width / 2) - (extent / 2), 0)
	captureBar.Divider:SetFrameStrata("HIGH")
	captureBar.Divider.Texture = captureBar.Divider:CreateTexture(nil, "BACKGROUND")
	captureBar.Divider.Texture:SetTexture(1, 1, 1, 1)
	captureBar.Divider.Texture:SetSize(extent, height + (extent * 2))
	captureBar.Divider.Texture:SetPoint("CENTER")
	captureBar.SetValue = function(self, value)
		self.value = value
		self.Divider:ClearAllPoints()
		self.Divider:SetPoint("LEFT", self, "LEFT", (((100 - self.value) / 100) * self.maxWidth) - 2, 0)
	end
	
	captureBar:SetScript("OnShow", function(self)
		local parent = self:GetParent()
		if (parent.EventBar:IsShown()) then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -25)
			parent.Timer:ClearAllPoints()
			parent.Timer:SetPoint("TOP", parent, "BOTTOM", 0, -30)
		else
			parent.Timer:ClearAllPoints()
			parent.Timer:SetPoint("TOP", parent, "BOTTOM", 0, -15)
		end
	end)
	captureBar:SetScript("OnHide", function(self)
		local parent = self:GetParent()
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -10)
		if (parent.EventBar:IsShown()) then
			parent.Timer:ClearAllPoints()
			parent.Timer:SetPoint("TOP", parent, "BOTTOM", 0, -15)
		else
			parent.Timer:ClearAllPoints()
			parent.Timer:SetPoint("TOP", parent, "BOTTOM")
		end
	end)
	
	captureBar:Hide()
	
	parent.CaptureBar = captureBar
end

function BattleFlow:CreateFactionMarkerFrame(parent)
	local alliance = CreateFrame("Frame", nil, parent)
	alliance:SetSize(25, 25)
	alliance:SetPoint("RIGHT", self.controlPoints[1], "LEFT", 12, 0)
	alliance:SetFrameStrata("HIGH")
	
	alliance.Texture = alliance:CreateTexture(nil, "BACKGROUND")
	alliance.Texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-Alliance")
	alliance.Texture:SetSize(40, 40)
	alliance.Texture:SetPoint("LEFT", -1, -7)
	
	local horde = CreateFrame("Frame", nil, parent)
	horde:SetSize(25, 25)
	horde:SetPoint("LEFT", self.controlPoints[7], "RIGHT", -12, 0)
	horde:SetFrameStrata("HIGH")
	
	horde.Texture = horde:CreateTexture(nil, "BACKGROUND")
	horde.Texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-Horde")
	horde.Texture:SetSize(40, 40)
	horde.Texture:SetPoint("LEFT", -1, -8)
end

function BattleFlow:CreateSlainCounterFrame(parent)
	parent.SlainCounter = { }

	local allianceFrame = CreateFrame("Frame", nil, parent)
	allianceFrame:SetSize(100, 25)
	allianceFrame:SetPoint("RIGHT", self.controlPoints[1], "LEFT", -20, 0)
	
	allianceFrame.Counter = allianceFrame:CreateFontString(nil , "BACKGROUND", "GameFontNormalSmall")
	allianceFrame.Counter:SetSize(100, 25)
	allianceFrame.Counter:SetJustifyH("RIGHT")
	allianceFrame.Counter:SetPoint("RIGHT", self.controlPoints[1], "LEFT", -20, 0)
	allianceFrame.Counter:SetText("")
	allianceFrame.Counter.Tooltip = ""
	
	allianceFrame:SetScript("OnEnter", function(self)
		if (self.Counter.ToolTip) then
			GameTooltip:SetOwner(self)
			GameTooltip:SetText(self.Counter.Tooltip)
		end
	end)
	allianceFrame:SetScript("OnLeave", function(self)
		GameTooltip_Hide()
	end)
	
	parent.SlainCounter.Alliance = allianceFrame.Counter
	
	local hordeFrame = CreateFrame("Frame", nil, parent)
	hordeFrame:SetSize(100, 25)
	hordeFrame:SetPoint("LEFT", self.controlPoints[7], "RIGHT", 20, 0)
	
	hordeFrame.Counter = hordeFrame:CreateFontString(nil , "BACKGROUND", "GameFontNormalSmall")
	hordeFrame.Counter:SetSize(100, 25)
	hordeFrame.Counter:SetJustifyH("LEFT")
	hordeFrame.Counter:SetPoint("LEFT", self.controlPoints[7], "RIGHT", 20, 0)
	hordeFrame.Counter:SetText("")
	hordeFrame.Counter.Tooltip = ""
	
	hordeFrame:SetScript("OnEnter", function(self)
		if (self.Counter.ToolTip) then
			GameTooltip:SetOwner(self)
			GameTooltip:SetText(self.Counter.Tooltip)
		end
	end)
	hordeFrame:SetScript("OnLeave", function(self)
		GameTooltip_Hide()
	end)
	
	parent.SlainCounter.Horde = hordeFrame.Counter
end

function BattleFlow:CreateTimerFrame(parent)
	local timerFrame = CreateFrame("Frame", nil, parent)
	timerFrame:SetSize(200, 25)
	timerFrame:SetPoint("TOP", parent, "BOTTOM")

	timerFrame.Timer = timerFrame:CreateFontString(nil , "BACKGROUND", "GameFontNormalSmall")
	timerFrame.Timer:SetSize(200, 25)
	timerFrame.Timer:SetPoint("TOP", parent, "BOTTOM")
	timerFrame.Timer:SetText("")
	timerFrame.Timer.Tooltip = ""
	
	timerFrame:SetScript("OnEnter", function(self)
		if (self.Timer.ToolTip) then
			GameTooltip:SetOwner(self)
			GameTooltip:SetText(self.Timer.Tooltip)
		end
	end)
	timerFrame:SetScript("OnLeave", function(self)
		GameTooltip_Hide()
	end)
	
	parent.Timer = timerFrame.Timer
end

function BattleFlow:CreateBossTooltipFrame(parent)
	local bossTooltip = CreateFrame("Frame", nil, parent)
	bossTooltip:SetSize(200, 25)
	bossTooltip:SetPoint("TOP", parent, "BOTTOM")

	bossTooltip.Text = bossTooltip:CreateFontString(nil , "BACKGROUND", "GameFontNormalSmall")
	bossTooltip.Text:SetSize(200, 25)
	bossTooltip.Text:SetPoint("TOP", parent, "BOTTOM")
	bossTooltip.Text:SetText("")
	
	bossTooltip:SetScript("OnShow", function(self)
		local parent = self:GetParent()
		parent.Timer:ClearAllPoints()
		parent.Timer:SetPoint("TOP", parent, "BOTTOM", 0, -15)
	end)
	bossTooltip:SetScript("OnHide", function(self)
		local parent = self:GetParent()
		if (not parent.EventBar:IsShown() and not parent.CaptureBar:IsShown()) then
			parent.Timer:ClearAllPoints()
			parent.Timer:SetPoint("TOP", parent, "BOTTOM")
		end
	end)
	
	bossTooltip:Hide()
	
	parent.BossTooltip = bossTooltip
end
