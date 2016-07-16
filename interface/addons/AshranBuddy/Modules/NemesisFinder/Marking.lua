local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local NemesisFinder = Engine:GetModule("NemesisFinder")
NemesisFinder.TargetRace = nil

local Nemesis = {}
local FramePool = {}

function NemesisFinder:EnableMarking()
	local settings = Settings:Get(self.Name)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "OnUpdateMouseOverUnit")

	self:RegisterScript("OnUpdate", function(elapsed)
		NemesisFinder:HookFrames(WorldFrame:GetChildren())
	end)

	self:SetTargetRace(settings.target)
end

function NemesisFinder:DisableMarking()
	self:UnregisterScript("OnUpdate")

	self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT", "OnUpdateMouseOverUnit")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
end

function NemesisFinder:SetTargetRace(race)
	if race == nil or race == "AByQuest" then
		local quest = self:GetNemesisQuest()
		if quest then
			self.TargetRace = quest.Race
		else
			self.TargetRace = ""
		end
	else
		self.TargetRace = race
	end
	Nemesis = {}
	self:UnhookFrames(WorldFrame:GetChildren())
end

function NemesisFinder:AddTarget(name)
	if (name ~= nil) then
		Nemesis[name] = true
		self:HookFrames(WorldFrame:GetChildren())
	end
end

function NemesisFinder:FindTarget(name)
	for key, _ in pairs(Nemesis) do
		if (name:find(key)) then
			return true
		end
	end
	return false
end

function NemesisFinder:NemesisMarked(unitID)
	if (self.TargetRace ~= nil and UnitIsEnemy("player", unitID)) then
		local _, race = UnitRace(unitID)
		if (self.TargetRace == race) then
			local name, _ = UnitName(unitID)
			self:AddTarget(name)
		end
	end
end

function NemesisFinder:HookFrames(...)
	if self.TargetRace ~= nil then
		for i = 1, select("#", ...) do
			local frame = select(i, ...)
			if (frame:GetName() ~= nil and frame:GetName():find("NamePlate")) then
				local child = select(2, frame:GetChildren())
				if (child ~= nil) then
					local region = child:GetRegions()
					if (region ~= nil and region:GetObjectType() == "FontString") then
						if (self:FindTarget(region:GetText())) then
							if (frame.Nemesis == nil) then
								frame.Nemesis = self:ObtainPlateFrame(frame)
								frame.Nemesis:SetParent(frame)
								frame.Nemesis:SetPoint("BOTTOM", frame, "TOP")
								frame.Nemesis:Show()
							end
						else
							if (frame.Nemesis ~= nil) then
								local nemesis = frame.Nemesis
								frame.Nemesis:Hide()
								frame.Nemesis:SetParent(nil)
								frame.Nemesis:ClearAllPoints()
								frame.Nemesis = nil
							
								table.insert(FramePool, nemesis)
							end
						end
					end
				end
			end
		end
	end
end

function NemesisFinder:UnhookFrames(...)
	for i = 1, select("#", ...) do
		local frame = select(i, ...)
		if (frame.Nemesis ~= nil) then
			local nemesis = frame.Nemesis
			frame.Nemesis:Hide()
			frame.Nemesis:SetParent(nil)
			frame.Nemesis:ClearAllPoints()
			frame.Nemesis = nil
			
			table.insert(FramePool, nemesis)
		end
	end
end

function NemesisFinder:ObtainPlateFrame(frame)
	if (#FramePool > 0) then
		return table.remove(FramePool)
	else
		local nemesis = CreateFrame("Frame", nil, frame)
		nemesis:SetPoint("BOTTOM", frame, "TOP")
		nemesis:SetWidth(32)
		nemesis:SetHeight(32)
		
		nemesis.Texture = nemesis:CreateTexture(nil, "BACKGROUND")
		nemesis.Texture:SetTexture("Interface\\AddOns\\AshranBuddy\\Media\\Nemesis")
		nemesis.Texture:SetWidth(32)
		nemesis.Texture:SetHeight(32)
		nemesis.Texture:SetPoint("TOPLEFT")
		return nemesis
	end
end

function NemesisFinder:OnUpdateMouseOverUnit()
	self:NemesisMarked("mouseover")
end

function NemesisFinder:OnPlayerTargetChanged()
	self:NemesisMarked("target")
end