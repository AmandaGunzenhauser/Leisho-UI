local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Constants
local MAX_RAID_MEMBERS = 40

local NemesisFinder = Engine:GetModule("NemesisFinder")
NemesisFinder.Quest = nil

local Buttons = { }
local Partners = { }

function NemesisFinder:EnableHighlight()
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "OnRaidUpdate")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnRaidUpdate")
	self:RegisterEvent("QUEST_ACCEPTED", "OnQuestChanged")
	self:RegisterEvent("QUEST_TURNED_IN", "OnQuestChanged")

	self.Quest = self:GetNemesisQuest()

	if (#Buttons == 0) then
		for i = 1, MAX_RAID_MEMBERS do
			Buttons[i] = _G["RaidGroupButton" .. i]
		end
	end

	self:OnRaidUpdate()
end

function NemesisFinder:DisableHighlight()
	for i = 1, GetNumGroupMembers() do
		if Buttons[i] then
			Buttons[i]:UnlockHighlight()
		end
	end
	
	self:UnregisterEvent("QUEST_TURNED_IN")
	self:UnregisterEvent("QUEST_ACCEPTED")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
end

function NemesisFinder:AddHighlight(name)
	if (name ~= nil) then
		local found = false
		for i = 1, GetNumGroupMembers() do
			if (Buttons[i].name ~= nil) then
				if (string.find(Buttons[i].name, name)) then
					Buttons[i]:LockHighlight()
					break
				end
			end
		end
	end
end

function NemesisFinder:RemoveHighlight()
	for i = 1, GetNumGroupMembers() do
		if (Buttons[i] ~= nil and Buttons[i].name ~= nil) then
			if (not self:FindPartner(Buttons[i].name)) then
				Buttons[i]:UnlockHighlight()
			end
		end
	end
end

function NemesisFinder:FindPartner(name)
	local found = false
	for i = 1, #Partners do
		if (string.find(Partners[i], name)) then
			found = true
			break
		end
	end
	return found
end

function NemesisFinder:OnRaidUpdate()
	if self.Quest ~= nil then
		-- Reset Nemesis highlight
		self:RemoveHighlight()
		self:SendRequest(self.Quest.ID)
	end
end

function NemesisFinder:OnQuestChanged()
	self.Quest = self:GetNemesisQuest()
end