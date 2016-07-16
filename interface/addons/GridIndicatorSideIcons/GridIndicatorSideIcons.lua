-- -------------------------------------------------------------------------- --
-- GridIndicatorSideIcons by kunda                                            --
-- -------------------------------------------------------------------------- --

local addonName, prg = ...
if type(prg)   ~= "table" then print("ERROR", addonName) return end
if type(prg.L) ~= "table" then print("ERROR", addonName, "No localization table.") return end
for k, v in pairs(prg.L) do if type(v) ~= "string" then prg.L[k] = tostring(k) end end
local L = setmetatable(prg.L, {
	__index = function(t, k)
		t[k] = k
		--print(addonName, "prg.L:", k)
		return k
	end
})

local Grid = Grid
if not Grid.L then Grid.L = {} end
local LGrid = setmetatable(Grid.L, {
	__index = function(t, k)
		t[k] = k
		--print(addonName, "Grid.L:", k)
		return k
	end
})
local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorSideIcons = GridFrame:NewModule("GridIndicatorSideIcons")

local configMode = false

local BACKDROP = {
	edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 2,
	insets = {left = 2, right = 2, top = 2, bottom = 2},
}



local function NewIndicator(frame)
	local icon = CreateFrame("Frame", nil, frame)
	icon:SetBackdrop(BACKDROP)
	icon:SetBackdropBorderColor(1, 1, 1, 0)
	icon:SetBackdropColor(0, 0, 0, 0)
	icon:Hide()

	local texture = icon:CreateTexture(nil, "ARTWORK")
	texture:SetPoint("CENTER", 0, 0)
	icon.texture = texture

	local cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
	cooldown:SetAllPoints(true)
	cooldown:SetDrawBling(false)
	cooldown:SetDrawEdge(false)
	cooldown:SetHideCountdownNumbers(true)
	cooldown:SetReverse(true)
	icon.cooldown = cooldown

	return icon
end



local function ResetIndicator(self)
	local frame = self.__owner
	local indicator = self.__id
	local AddonProfile = GridIndicatorSideIcons.db.profile
	local GridProfile = GridFrame.db.profile

	local xoffsetTB = AddonProfile.xoffsetTB
	local yoffsetTB = AddonProfile.yoffsetTB
	local xoffsetLR = AddonProfile.xoffsetLR
	local yoffsetLR = AddonProfile.yoffsetLR

	local borderSize = AddonProfile.iconBorderSize
	if AddonProfile.OriginalSize then
		borderSize = GridProfile.iconBorderSize
	end

	local wh = 0
	local point = {"CENTER", frame, "CENTER", 0, 0}
	if     indicator == "icontop"    then wh = AddonProfile.iconSizeTop    point = {"TOP", frame, "TOP", xoffsetTB, yoffsetTB}
	elseif indicator == "iconbottom" then wh = AddonProfile.iconSizeBottom point = {"BOTTOM", frame, "BOTTOM", xoffsetTB, (yoffsetTB*-1)}
	elseif indicator == "iconleft"   then wh = AddonProfile.iconSizeLeft   point = {"LEFT", frame, "LEFT", (xoffsetLR*-1), yoffsetLR}
	elseif indicator == "iconright"  then wh = AddonProfile.iconSizeRight  point = {"RIGHT", frame, "RIGHT", xoffsetLR, yoffsetLR}
	end
	if AddonProfile.OriginalSize then
		wh = GridProfile.iconSize
	end

	BACKDROP.edgeSize      = borderSize
	BACKDROP.insets.left   = borderSize
	BACKDROP.insets.right  = borderSize
	BACKDROP.insets.top    = borderSize
	BACKDROP.insets.bottom = borderSize

	if borderSize == 0 then
		self:SetBackdrop(nil)
	else
		self:SetBackdrop(BACKDROP)
	end

	self:SetWidth(wh + (2*borderSize))
	self:SetHeight(wh + (2*borderSize))
	self:SetParent(frame.indicators.bar)
	self:SetFrameLevel(frame.indicators.bar:GetFrameLevel() + 1)
	self:ClearAllPoints()
	self:SetPoint(point[1], point[2], point[3], point[4], point[5])

	self.texture:SetWidth(wh)
	self.texture:SetHeight(wh)
end



local function SetIndicator(self, color, text, value, maxValue, texture, texCoords, count, start, duration)
	if not texture then return end

	local enableIconCooldown = GridIndicatorSideIcons.db.profile.enableIconCooldown
	local enableIconStackText = GridIndicatorSideIcons.db.profile.enableIconStackText
	if GridIndicatorSideIcons.db.profile.OriginalSize then
		enableIconCooldown = GridFrame.db.profile.enableIconCooldown
		enableIconStackText = GridFrame.db.profile.enableIconStackText
	end

	if type(texture) == "table" then
		self.texture:SetTexture(texture.r, texture.g, texture.b, texture.a or 1)
	else
		self.texture:SetTexture(texture)
	end

	if type(texCoords) == "table" then
		self.texture:SetTexCoord(texCoords.left, texCoords.right, texCoords.top, texCoords.bottom)
	else
		self.texture:SetTexCoord(0, 1, 0, 1)
	end

	if type(color) == "table" then
		self:SetAlpha(color.a or 1)
		self:SetBackdropBorderColor(color.r, color.g, color.b, color.ignore and 0 or color.a or 1)
	else
		self:SetAlpha(1)
		self:SetBackdropBorderColor(0, 0, 0, 0)
	end

	if enableIconCooldown and type(duration) == "number" and duration > 0 and type(start) == "number" and start > 0 then
		self.cooldown:SetCooldown(start, duration)
		self.cooldown:Show()
	else
		self.cooldown:Hide()
	end

	if enableIconStackText then
		self.cooldown:SetHideCountdownNumbers(false)
	else
		self.cooldown:SetHideCountdownNumbers(true)
	end

	self:Show()
end



local function ClearIndicator(self)
	if configMode then return end
	self:Hide()
	self.texture:SetTexture(1, 1, 1, 0)
	self.texture:SetTexCoord(0, 1, 0, 1)
	self.cooldown:Hide()
end



local function SetIconSize(frame)
	ResetIndicator(frame.indicators.icontop)
	ResetIndicator(frame.indicators.iconbottom)
	ResetIndicator(frame.indicators.iconleft)
	ResetIndicator(frame.indicators.iconright)
end



GridIndicatorSideIcons.defaultDB = {
	iconSizeTop = 8,
	iconSizeBottom = 8,
	iconSizeLeft = 8,
	iconSizeRight = 8,
	xoffsetTB = 0,
	yoffsetTB = 0,
	xoffsetLR = 0,
	yoffsetLR = 0,
	iconBorderSize = 0,
	enableIconCooldown = false,
	enableIconStackText = false,
	OriginalSize = false,
}



local options = {
	type = "group",
	icon = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-TRBL",
	name = L["Icon (Sides)"],
	desc = format(LGrid["Options for %s indicator."], L["Icon (Sides)"]),
	order = -0.581,
	args = {
		["configuration"] = {
			type = "toggle",
			name = L["Configuration Mode"],
			order = 5,
			get = function(self) return configMode end,
			set = function(_, v)
				configMode = v
				GridIndicatorSideIcons:ConfigMode()
			end
		},
		["header1"] = {
			type = "header",
			order = 10,
			width = "full",
			name = "",
		},
		["desc1"] = {
			type = "description",
			order = 11,
			width = "full",
			name = L["Offset"].." ("..LGrid["Top"].."/"..LGrid["Bottom"].."):",
		},
		["xoffsetTB"] = {
			type = "range",
			name = LGrid["Horizontal"],
			order = 20,
			width = "fill",
			min = -20,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSideIcons.db.profile.xoffsetTB end,
			set = function(_, v)
				GridIndicatorSideIcons.db.profile.xoffsetTB = v
				for _, f in pairs(GridFrame.registeredFrames) do
					SetIconSize(f)
				end
				if configMode then
					GridIndicatorSideIcons:ConfigMode()
				end
			end,
		},
		["yoffsetTB"] = {
			type = "range",
			name = LGrid["Vertical"],
			order = 30,
			width = "fill",
			min = -20,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSideIcons.db.profile.yoffsetTB end,
			set = function(_, v)
				GridIndicatorSideIcons.db.profile.yoffsetTB = v
				for _, f in pairs(GridFrame.registeredFrames) do
					SetIconSize(f)
				end
				if configMode then
					GridIndicatorSideIcons:ConfigMode()
				end
			end,
		},
		["desc1a"] = {
			type = "description",
			order = 31,
			width = "full",
			name = L["Offset"].." ("..LGrid["Left"].."/"..LGrid["Right"].."):",
		},
		["xoffsetLR"] = {
			type = "range",
			name = LGrid["Horizontal"],
			order = 40,
			width = "fill",
			min = -20,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSideIcons.db.profile.xoffsetLR end,
			set = function(_, v)
				GridIndicatorSideIcons.db.profile.xoffsetLR = v
				for _, f in pairs(GridFrame.registeredFrames) do
					SetIconSize(f)
				end
				if configMode then
					GridIndicatorSideIcons:ConfigMode()
				end
			end,
		},
		["yoffsetLR"] = {
			type = "range",
			name = LGrid["Vertical"],
			order = 50,
			width = "fill",
			min = -20,
			max = 20,
			step = 1,
			get = function() return GridIndicatorSideIcons.db.profile.yoffsetLR end,
			set = function(_, v)
				GridIndicatorSideIcons.db.profile.yoffsetLR = v
				for _, f in pairs(GridFrame.registeredFrames) do
					SetIconSize(f)
				end
				if configMode then
					GridIndicatorSideIcons:ConfigMode()
				end
			end,
		},
		["header2"] = {
			type = "header",
			order = 55,
			width = "full",
			name = "",
		},
		["originalsize"] = {
			type = "toggle",
			name = L["Same settings as Grid"],
			order = 60,
			width = "full",
			get = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
			set = function(_, v)
				GridIndicatorSideIcons.db.profile.OriginalSize = v
				for _, f in pairs(GridFrame.registeredFrames) do
					SetIconSize(f)
				end
				if configMode then
					GridIndicatorSideIcons:ConfigMode()
				end
			end,
		},
		["originalopt"] = {
			name = " ",
			order = 61,
			type = "group",
			dialogInline = true,
			args = {
				["iconbordersize"] = {
					type = "range",
					name = LGrid["Icon Border Size"],
					order = 70,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					min = 0,
					max = 4,
					step = 1,
					get = function() return GridIndicatorSideIcons.db.profile.iconBorderSize end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.iconBorderSize = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["dummy1"] = {
					type = "description",
					order = 71,
					width = "full",
					name = "",
				},
				["iconcooldown"] = {
					type = "toggle",
					name = format(LGrid["Enable %s"], LGrid["Icon Cooldown Frame"]),
					order = 80,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					get = function() return GridIndicatorSideIcons.db.profile.enableIconCooldown end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.enableIconCooldown = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["dummy2"] = {
					type = "description",
					order = 81,
					width = "full",
					name = "",
				},
				["iconstacktext"] = {
					type = "toggle",
					name = format(LGrid["Enable %s"], LGrid["Icon Stack Text"]),
					order = 90,
					width = "double",
					disabled = function()
						local a = GridIndicatorSideIcons.db.profile.OriginalSize
						local b = GridIndicatorSideIcons.db.profile.enableIconCooldown
						if not a and b then
							return false
						else
							return true
						end
					end,
					get = function() return GridIndicatorSideIcons.db.profile.enableIconStackText end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.enableIconStackText = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["header5"] = {
					type = "header",
					order = 91,
					width = "full",
					name = "",
				},
				["desc2"] = {
					type = "description",
					order = 92,
					width = "full",
					name = LGrid["Icon Size"]..":",
				},
				["iconsizetop"] = {
					type = "range",
					name = LGrid["Top"],
					order = 120,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					min = 5,
					max = 50,
					step = 1,
					get = function() return GridIndicatorSideIcons.db.profile.iconSizeTop end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.iconSizeTop = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["dummy3"] = {
					type = "description",
					order = 121,
					width = "full",
					name = "",
				},
				["iconsizebottom"] = {
					type = "range",
					name = LGrid["Bottom"],
					order = 130,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					min = 5,
					max = 50,
					step = 1,
					get = function() return GridIndicatorSideIcons.db.profile.iconSizeBottom end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.iconSizeBottom = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["dummy4"] = {
					type = "description",
					order = 131,
					width = "full",
					name = "",
				},
				["iconsizeleft"] = {
					type = "range",
					name = LGrid["Left"],
					order = 140,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					min = 5,
					max = 50,
					step = 1,
					get = function() return GridIndicatorSideIcons.db.profile.iconSizeLeft end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.iconSizeLeft = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				},
				["dummy5"] = {
					type = "description",
					order = 141,
					width = "full",
					name = "",
				},
				["iconsizeright"] = {
					type = "range",
					name = LGrid["Right"],
					order = 150,
					width = "double",
					disabled = function() return GridIndicatorSideIcons.db.profile.OriginalSize end,
					min = 5,
					max = 50,
					step = 1,
					get = function() return GridIndicatorSideIcons.db.profile.iconSizeRight end,
					set = function(_, v)
						GridIndicatorSideIcons.db.profile.iconSizeRight = v
						for _, f in pairs(GridFrame.registeredFrames) do
							SetIconSize(f)
						end
						if configMode then
							GridIndicatorSideIcons:ConfigMode()
						end
					end,
				}
			}
		}
	}
}
Grid.options.args["GridIndicatorSideIcons"] = options



local statusmap = GridFrame.db.profile.statusmap
if not statusmap["icontop"] then
	statusmap["icontop"] = {}
	statusmap["iconbottom"] = {}
	statusmap["iconleft"] = {}
	statusmap["iconright"] = {}
end



function GridIndicatorSideIcons:OnInitialize()
	if not self.db then
		self.db = Grid.db:RegisterNamespace(self.moduleName, { profile = self.defaultDB or { } })
	end
	GridFrame:RegisterIndicator("icontop",    LGrid["Top"],    NewIndicator, ResetIndicator, SetIndicator, ClearIndicator)
	GridFrame:RegisterIndicator("iconbottom", LGrid["Bottom"], NewIndicator, ResetIndicator, SetIndicator, ClearIndicator)
	GridFrame:RegisterIndicator("iconleft",   LGrid["Left"],   NewIndicator, ResetIndicator, SetIndicator, ClearIndicator)
	GridFrame:RegisterIndicator("iconright",  LGrid["Right"],  NewIndicator, ResetIndicator, SetIndicator, ClearIndicator)

	hooksecurefunc(GridFrame, "UpdateOptionsMenu", self.ChangeOptionsMenu)
	GridIndicatorSideIcons:ChangeOptionsMenu()
	GridIndicatorSideIcons:CreateConfigFrame()
end



function GridIndicatorSideIcons:OnEnable()
end



function GridIndicatorSideIcons:OnDisable()
end



function GridIndicatorSideIcons:Reset()
end



function GridIndicatorSideIcons:ChangeOptionsMenu()
	if not GridIndicatorSideIcons:IsEnabled() then return end
	if not Grid.options then return end
	if not Grid.options.args then return end
	local GridIndicator
	if     type(Grid.options.args.GridIndicator) == "table" then GridIndicator = "GridIndicator"
	elseif type(Grid.options.args.Indicators)    == "table" then GridIndicator = "Indicators" end
	if not Grid.options.args[GridIndicator] then return end
	if not Grid.options.args[GridIndicator].args then return end

	if not Grid.options.args[GridIndicator].args.icontop then return end

	Grid.options.args[GridIndicator].args.icontop.icon  = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-T"
	Grid.options.args[GridIndicator].args.iconright.icon = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-R"
	Grid.options.args[GridIndicator].args.iconbottom.icon = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-B"
	Grid.options.args[GridIndicator].args.iconleft.icon  = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-L"

	Grid.options.args[GridIndicator].args.icontop.order  = 1
	Grid.options.args[GridIndicator].args.iconright.order = 2
	Grid.options.args[GridIndicator].args.iconbottom.order = 3
	Grid.options.args[GridIndicator].args.iconleft.order  = 4
	
	Grid.options.args[GridIndicator].args.GridIndicatorSideIcons = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-icon-TRBL",
		name = L["Icon (Sides)"],
		order = 8.1,
		args = {
			["icontop"] = Grid.options.args[GridIndicator].args.icontop,
			["iconright"] = Grid.options.args[GridIndicator].args.iconright,
			["iconbottom"] = Grid.options.args[GridIndicator].args.iconbottom,
			["iconleft"] = Grid.options.args[GridIndicator].args.iconleft
		}
	}

	Grid.options.args[GridIndicator].args.icontop = nil
	Grid.options.args[GridIndicator].args.iconright = nil
	Grid.options.args[GridIndicator].args.iconbottom = nil
	Grid.options.args[GridIndicator].args.iconleft = nil
end



function GridIndicatorSideIcons:CreateConfigFrame()
	GridIndicatorSideIcons.ConfigWarningFrame = CreateFrame("Frame", nil, UIParent)
	local frame = GridIndicatorSideIcons.ConfigWarningFrame
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetHeight(100)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = {left = 8, right = 8, top = 8, bottom = 8}
	})
	frame:SetPoint("LEFT", GridLayoutFrame, "RIGHT", 40, 0)
	frame:SetScript("OnMouseDown", function(self)
		self.isMoving = true
		self:StartMoving()
	end)
	frame:SetScript("OnMouseUp", function(self)
		if not self.isMoving then return end
		self.isMoving = nil
		self:StopMovingOrSizing()
	end)
	frame:Hide()

	local background = frame:CreateTexture(nil, "ARTWORK")
	background:SetPoint("TOP", 0, -15)
	background:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
	background:SetHeight(24)
	background:SetWidth(24)

	local txt = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	txt:SetPoint("TOP", background, "BOTTOM", 0, -5)
	txt:SetText("Grid - "..L["Icon (Sides)"].." - "..L["Configuration Mode"])
	txt:SetTextColor(1, 1, 1, 1)

	local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	button:SetHeight(24)
	button:SetPoint("TOP", txt, "BOTTOM", 0, -5)
	button:SetText(CLOSE)
	button:SetScript("OnClick", function()
		configMode = false
		GridIndicatorSideIcons:ConfigMode()
	end)

	local w = txt:GetStringWidth()
	button:SetWidth(w+50)
	frame:SetWidth(w+50+60)
end



function GridIndicatorSideIcons:ConfigMode()
	if configMode then
		GridIndicatorSideIcons.ConfigWarningFrame:Show()
		local curTime = GetTime()
		for _, frame in pairs(GridFrame.registeredFrames) do
			SetIndicator(frame.indicators.icontop,    {r=0.29, g=0.21, b=0.81, a=1}, "3", 3, 8, "Interface\\Icons\\Spell_Holy_ArcaneIntellect",     {left=0   , right=1   , top=0   , bottom=1   }, 8, curTime, 9)
			SetIndicator(frame.indicators.iconbottom, {r=0.78, g=0.69, b=0.97, a=1}, "4", 4, 8, "Interface\\Icons\\Spell_Holy_WordFortitude",       {left=0   , right=1   , top=0   , bottom=1   }, 8, curTime, 15)
			SetIndicator(frame.indicators.iconleft,   {r=0.42, g=0.07, b=0.24, a=1}, "5", 5, 8, "Interface\\TargetingFrame\\UI-RaidTargetingIcons", {left=0   , right=0.25, top=0   , bottom=0.25}, 8, curTime, 9)
			SetIndicator(frame.indicators.iconright,  {r=0.16, g=0.21, b=0.78, a=1}, "8", 8, 8, "Interface\\Icons\\Spell_Shadow_DemonBreath",       {left=0   , right=1   , top=0   , bottom=1   }, 8, curTime, 80)
		end
	else
		GridIndicatorSideIcons.ConfigWarningFrame:Hide()
		for _, frame in pairs(GridFrame.registeredFrames) do
			ClearIndicator(frame.indicators.icontop)
			ClearIndicator(frame.indicators.iconbottom)
			ClearIndicator(frame.indicators.iconleft)
			ClearIndicator(frame.indicators.iconright)
		end
	end
end