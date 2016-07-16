local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local NemesisFinder = Engine:GetModule("NemesisFinder")

function NemesisFinder:OnConfiguration(options)
	local settings = Settings:Get(self.Name)
	options.NemesisFinder = {
		name = Locale.NEMESIS_NAME,
		type = "group",
		order = 30,
		args = {
			header = {
				name = Locale.NEMESIS_NAME,
				type = "header",
				order = 0
			},
			headerDescription = {
				name = Locale.NEMESIS_DESCRIPTION,
				type = "description",
				order = 1
			},
			enabled = {
				name = Locale.ADDON_MODULE_ENABLED,
				desc = Locale.NEMESIS_ENABLE_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					settings.enabled = val
					if val then
						self:Enable()
					else
						self:Disable()
					end
				end,
				get = function(info)
					return settings.enabled
				end,
				order = 2
			},
			enabledDescription = {
				name = Locale.NEMESIS_ENABLE_TOOLTIP,
				type = "description",
				order = 3
			},
			marked = {
				name = Locale.NEMESIS_MARKING,
				desc = Locale.NEMESIS_MARKING_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					settings.marking = val
					if (val) then
						self.Component:SetScript("OnUpdate", function(self, elapsed)
							NemesisFinder:HookFrames(WorldFrame:GetChildren())
						end)
					else
						self.Component:SetScript("OnUpdate", nil)
						NemesisFinder:UnhookFrames(WorldFrame:GetChildren())
					end
				end,
				get = function(info)
					return settings.marking
				end,
				order = 4
			},
			markedDescription = {
				name = Locale.NEMESIS_MARKING_TOOLTIP,
				type = "description",
				order = 5
			},
			target = {
				name = Locale.NEMESIS_TARGET,
				desc = Locale.NEMESIS_TARGET_TOOLTIP,
				type = "select",
				style = "dropdown",
				values = {
					["AByQuest"] = "By Quest",
					["BloodElf"] = "Blood Elf",
					["Draenei"] = "Draenei",
					["Dwarf"] = "Dwarf",
					["Gnome"] = "Gnome",
					["Goblin"] = "Goblin",
					["Human"] = "Human",
					["NightElf"] = "Night Elf",
					["Orc"] = "Orc",
					["Pandaren"] = "Pandaren",
					["Tauren"] = "Tauren",
					["Troll"] = "Troll",
					["Scourge"] = "Undead",
					["Worgen"] = "Worgen"
				},
				set = function(info, val)
					settings.target = val
					self:SetTargetRace(val)
				end,
				get = function(info)
					return settings.target
				end,
				order = 6
			},
			targetDescription = {
				name = Locale.NEMESIS_TARGET_TOOLTIP,
				type = "description",
				order = 7
			}
		}
	}
end