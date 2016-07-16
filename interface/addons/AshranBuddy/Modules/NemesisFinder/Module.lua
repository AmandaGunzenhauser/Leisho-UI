local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Registration
local NemesisFinder = Engine:RegisterModule("NemesisFinder")

local NemesisQuests = {
	[36964] = { ID = 36964, Title = "Nemesis: Orcslayer", Race = "Orc" },
	[36921] = { ID = 36921, Title = "Nemesis: Manslayer", Race = "Human" },
	[36960] = { ID = 36960, Title = "Nemesis: Death Stalker", Race = "Scourge" },
	[36932] = { ID = 36932, Title = "Nemesis: Scourge of the Kaldorei", Race = "NightElf" },
	[36958] = { ID = 36958, Title = "Nemesis: Slayer of Sindorei", Race = "BloodElf" },
	[36962] = { ID = 36962, Title = "Nemesis: The Butcher", Race = "Tauren" },
	[36966] = { ID = 36966, Title = "Nemesis: Troll Hunter", Race = "Troll" },
	[36968] = { ID = 36968, Title = "Nemesis: Huojins Fall", Race = "Pandaren" },
	[36934] = { ID = 36934, Title = "Nemesis: Terror of the Tushui", Race = "Pandaren" },
	[36930] = { ID = 36930, Title = "Nemesis: Draenei Destroyer", Race = "Draenei" },
	[36928] = { ID = 36928, Title = "Nemesis: Worgen Hunter", Race = "Worgen" },
	[36926] = { ID = 36926, Title = "Nemesis: Gnomebane", Race = "Gnome" },
	[36970] = { ID = 36970, Title = "Nemesis: Killer of Kezan", Race = "Goblin" },
	[36924] = { ID = 36924, Title = "Nemesis: Dwarfstalker", Race = "Dwarf" },
}

-- Initialize the module.
function NemesisFinder:OnInitialize()
end

-- Called when the module is enabled.
function NemesisFinder:OnEnable()
	self:EnableHighlight()
	self:EnableMarking()
end

-- Called when the module is disabled.
function NemesisFinder:OnDisable()
	self:DisableMarking()
	self:DisableHighlight()
end

function NemesisFinder:GetNemesisQuest()
	local nemesisQuest = nil
	local count = GetNumQuestLogEntries()
	for i = 1, count do
        local _, _, _, _, _, _, _, ID, _, _, _, _, _, _ = GetQuestLogTitle(i)
		if (NemesisQuests[ID] ~= nil) then
			nemesisQuest = NemesisQuests[ID]
			break
		end
	end
	return nemesisQuest
end