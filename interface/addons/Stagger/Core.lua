-------------------------
-- Stagger, by Siweia
-------------------------
local _, ns = ...
local cfg = ns.cfg
if cfg.MyClass ~= "MONK" then return end
local cr, cg, cb = cfg.cc.r, cfg.cc.g, cfg.cc.b

-- APIs
local CreateNF = function(f, a, w, h)
	f:SetSize(w or f:GetWidth(), h or f:GetHeight())
	f:SetBackdrop({
		bgFile = cfg.normTex, edgeFile = cfg.glowTex, edgeSize = 4 })
	f:SetBackdropColor(0, 0, 0, a or 0.5)
	f:SetBackdropBorderColor(0, 0, 0, 1)
end

local CreateSD = function(f, m, s, n)
	if f.Shadow then return end
	f.Shadow = CreateFrame("Frame", nil, f)
	f.Shadow:SetPoint("TOPLEFT", f, -m, m)
	f.Shadow:SetPoint("BOTTOMRIGHT", f, m, -m)
	f.Shadow:SetBackdrop({
		edgeFile = cfg.glowTex, edgeSize = s })
	f.Shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.Shadow:SetFrameLevel(n or f:GetFrameLevel())
	return f.Shadow
end

local CreateIF = function(f, HL)
	CreateSD(f, 4, 4)
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetAllPoints()
	f.Icon:SetTexCoord(unpack(cfg.TexCoord))
	f.CD = CreateFrame("Cooldown", nil, f, "CooldownFrameTemplate")
	f.CD:SetAllPoints()
	f.CD:SetReverse(true)
	if HL then
		f:EnableMouse(true)
		f.HL = f:CreateTexture(nil, "HIGHLIGHT")
		f.HL:SetTexture(1,1,1,0.35)
		f.HL:SetAllPoints(f.Icon)
	end
end

local CreateSB = function(f)
	f:SetStatusBarTexture(cfg.normTex)
	f:SetStatusBarColor(cr, cg, cb)
	CreateSD(f, 3, 3)
	f.BG = f:CreateTexture(nil, "BACKGROUND")
	f.BG:SetAllPoints()
	f.BG:SetTexture(cfg.normTex)
	f.BG:SetVertexColor(cr, cg, cb, 0.2)
end

local SetMover = function(Frame, Text, key, Pos, w, h)
	if not MoverDB[key] then MoverDB[key] = {} end
	local Mover = CreateFrame("Frame", nil, UIParent)
	Mover:SetWidth(w or Frame:GetWidth())
	Mover:SetHeight(h or Frame:GetHeight())
	CreateNF(Mover)
	Mover.Text = Mover:CreateFontString(nil, "OVERLAY")
	Mover.Text:SetFont(unpack(cfg.Font))
	Mover.Text:SetPoint("CENTER")
	Mover.Text:SetText(Text)
	if not MoverDB[key]["Mover"] then 
		Mover:SetPoint(unpack(Pos))
	else
		Mover:SetPoint(unpack(MoverDB[key]["Mover"]))
	end
	Mover:EnableMouse(true)
	Mover:SetMovable(true)
	Mover:SetClampedToScreen(true)
	Mover:SetFrameStrata("HIGH")
	Mover:RegisterForDrag("LeftButton")
	Mover:SetScript("OnDragStart", function(self) Mover:StartMoving() end)
	Mover:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local AnchorF, _, AnchorT, X, Y = self:GetPoint()
		MoverDB[key]["Mover"] = {AnchorF, "UIParent", AnchorT, X, Y}
	end)
	Mover:Hide()
	Frame:SetPoint("TOPLEFT", Mover)
	return Mover
end

local Numb = function(n)
	if (n >= 1e6) then
		return ("%.1fm"):format(n / 1e6)
	elseif (n >= 1e3) then
		return ("%.1fk"):format(n / 1e3)
	else
		return ("%.0f"):format(n)
	end
end

local CreateAT = function(f, name)
	f:SetScript("OnEnter", function(self)
		GameTooltip:Hide()
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -5)
		GameTooltip:ClearLines()
		GameTooltip:SetUnitAura("player", name)
		GameTooltip:Show()
	end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-- Style
local f = CreateFrame("Frame", nil, UIParent)
local Icon1 = CreateFrame("Frame", nil, UIParent)
local Icon2 = CreateFrame("Frame", nil, UIParent)
local Icon3 = CreateFrame("Frame", nil, UIParent)
local Statue = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")
local function BuildStagger()
	f:SetSize(cfg.IconSize, cfg.IconSize)
	CreateIF(f, true)
	f.Bar = CreateFrame("StatusBar", nil, f)
	f.Bar:SetSize(cfg.IconSize*4 + 12, 5)
	CreateSB(f.Bar)
	f:SetPoint("BOTTOMRIGHT", f.Bar, "TOPRIGHT", 0, 4)
	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(unpack(cfg.Font))
	f.Text:SetPoint("TOPRIGHT", f.Bar, "BOTTOMRIGHT", 0, -2)

	-- Elusive Brew
	Icon3:SetSize(cfg.IconSize, cfg.IconSize)
	Icon3:SetPoint("RIGHT", f, "LEFT", -4, 0)
	CreateIF(Icon3, true)
	Icon3.Icon:SetTexture(select(3, GetSpellInfo(115308)))
	Icon3.Count = Icon3:CreateFontString(nil, "OVERLAY")
	Icon3.Count:SetFont(unpack(cfg.Font))
	Icon3.Count:SetPoint("CENTER")

	-- Guard
	Icon2:SetSize(cfg.IconSize, cfg.IconSize)
	Icon2:SetPoint("RIGHT", Icon3, "LEFT", -4, 0)
	CreateIF(Icon2, true)
	Icon2.Icon:SetTexture(select(3, GetSpellInfo(115295)))
	Icon2.Text = Icon2:CreateFontString(nil, "OVERLAY")
	Icon2.Text:SetFont(cfg.Font[1], cfg.Font[2]-2, cfg.Font[3])
	Icon2.Text:SetPoint("CENTER")

	-- Shuffle
	Icon1:SetSize(cfg.IconSize, cfg.IconSize)
	Icon1:SetPoint("RIGHT", Icon2, "LEFT", -4, 0)
	CreateIF(Icon1, true)
	Icon1.Icon:SetTexture(select(3, GetSpellInfo(115307)))
	
	-- Ox Statue
	Statue:SetSize(cfg.IconSize*3/4, cfg.IconSize*3/4)
	Statue:SetPoint("TOPLEFT", f.Bar, "BOTTOMLEFT", 1, -3)
	CreateIF(Statue, true)
	Statue.Icon:SetTexture(select(3, GetSpellInfo(115069)))
	Statue:SetScript("OnEnter", function(self)
		GameTooltip:Hide()
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
		GameTooltip:ClearLines()
		GameTooltip:SetSpellByID(115315)
		GameTooltip:Show()
	end)
	Statue:SetScript("OnLeave", GameTooltip_Hide)

	f.Mover = SetMover(f.Bar, NPE_MOVE, "Stagger", cfg.StaggerPos, 140, 20)
	SlashCmdList["STAGGER"] = function(msg)
		if msg:lower() == "reset" then
			wipe(MoverDB["Stagger"])
			ReloadUI()
		else
			if f.Mover:IsVisible() then
				f.Mover:Hide()
			else
				f.Mover:Show()
			end
		end
	end
	SLASH_STAGGER1 = "/stg"
end

-- Function
f:RegisterUnitEvent("UNIT_AURA", "player")
f:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_MAXHEALTH")
f:SetScript("OnEvent", function()
	if not f.styled then
		BuildStagger()
		f.styled = true
	end
	if f.styled then
		if GetSpecialization() == 1 then
			f:SetAlpha(1)
			Icon1:SetAlpha(1)
			Icon2:SetAlpha(1)
			Icon3:SetAlpha(1)
			Statue:SetAlpha(1)

			-- Stagger
			do
				local Total, Per
				local name, _, icon, _, _, duration, expire, _, _, _, _, _, _, _, value = UnitAura("player", GetSpellInfo(124275), "", "HARMFUL")
				if (not name) then name, _, icon, _, _, duration, expire, _, _, _, _, _, _, _, value = UnitAura("player", GetSpellInfo(124274), "", "HARMFUL") end
				if (not name) then name, _, icon, _, _, duration, expire, _, _, _, _, _, _, _, value = UnitAura("player", GetSpellInfo(124273), "", "HARMFUL") end
				if name and value > 0 and duration > 0 then
					Total = value * math.floor(duration)
					Per = Total / UnitHealthMax("player") * 100
					f:SetAlpha(1)
					f.Icon:SetTexture(icon)
					f.CD:SetCooldown(expire - 10, 10)
				else
					value = 0
					Per = 0
					f:SetAlpha(cfg.FadeAlpha)
					f.Icon:SetTexture(select(3, GetSpellInfo(124275)))
					f.CD:SetCooldown(0, 0)
				end
				f.Bar:SetMinMaxValues(0, 100)
				f.Bar:SetValue(Per)
				f.Text:SetText(cfg.InfoColor..Numb(value).." "..cfg.MyColor..Numb(Per).."%")
				if UnitAura("player", GetSpellInfo(124273), "", "HARMFUL") then
					ActionButton_ShowOverlayGlow(f)
				else
					ActionButton_HideOverlayGlow(f)
				end
			end

			-- Shuffle
			do
				local name, _, _, _, _, dur, exp = UnitBuff("player", GetSpellInfo(115307))
				if exp then
					Icon1:SetAlpha(1)
					Icon1.CD:SetCooldown(exp - dur, dur)
					CreateAT(Icon1, name)
				else
					Icon1:SetAlpha(cfg.FadeAlpha)
					Icon1.CD:SetCooldown(0, 0)
				end
			end

			-- Guard
			do
				local name, _, _, _, _, dur, exp, _, _, _, _, _, _, _, value  = UnitBuff("player", GetSpellInfo(115295))
				if exp then
					Icon2:SetAlpha(1)
					--Icon2.CD:SetCooldown(exp - dur, dur)
					Icon2.Text:SetText(Numb(value))
					CreateAT(Icon2, name, "ANCHOR_RIGHT")
				else
					Icon2:SetAlpha(cfg.FadeAlpha)
					--Icon2.CD:SetCooldown(0, 0)
					Icon2.Text:SetText("")
				end
			end

			-- Elusive Brew
			do
				local name1, _, _, _, _, dur, exp = UnitBuff("player", GetSpellInfo(115308))
				local name2, _, _, count = UnitBuff("player", GetSpellInfo(128939))
				if name1 then
					Icon3:SetAlpha(1)
					Icon3.CD:SetCooldown(exp - dur, dur)
					Icon3.Count:SetText(nil)
					CreateAT(Icon3, name1)
				elseif name2 then
					Icon3:SetAlpha(1)
					Icon3.CD:SetCooldown(0,0)
					Icon3.Count:SetText(count)
					CreateAT(Icon3, name2)
				else
					Icon3:SetAlpha(cfg.FadeAlpha)
					Icon3.Count:SetText("")
				end
				if count and count == 15 then
					ActionButton_ShowOverlayGlow(Icon3)
				else
					ActionButton_HideOverlayGlow(Icon3)
				end
			end

			-- Ox Statue
			do
				local haveStatue, name, start, dur = GetTotemInfo(1)
				if haveStatue and dur > 0 then
					Statue:SetAlpha(1)
					Statue.CD:SetCooldown(start, dur)
				else
					Statue:SetAlpha(cfg.FadeAlpha)
					Statue.CD:SetCooldown(0, 0)
				end
				Statue:SetAttribute("*type*", "macro")
				Statue:SetAttribute("macrotext", "/click TotemFrameTotem1 RightButton")
			end
		else
			f:SetAlpha(0)
			Icon1:SetAlpha(0)
			Icon2:SetAlpha(0)
			Icon3:SetAlpha(0)
			Statue:SetAlpha(0)
		end
	end
end)