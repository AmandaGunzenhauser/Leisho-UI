local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local General = Engine:GetModule("General")

function General:OnConfiguration(options)
	local settings = Settings:Get(self.Name)
	options.General = {
		name = Locale.GENERAL_NAME,
		type = "group",
		order = 30,
		args = {
			header = {
				name = Locale.GENERAL_NAME,
				type = "header",
				order = 0
			},
			headerDescription = {
				name = Locale.GENERAL_DESCRIPTION,
				type = "description",
				order = 1
			},
			enabled = {
				name = Locale.ADDON_MODULE_ENABLED,
				desc = Locale.GENERAL_ENABLE_TOOLTIP,
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
				name = Locale.GENERAL_ENABLE_TOOLTIP,
				type = "description",
				order = 3
			},
			debug = {
				name = Locale.GENERAL_DEBUG,
				desc = Locale.GENERAL_DEBUG_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					Settings:Set("DebugMode", val)
				end,
				get = function(info)
					return Settings:Get("DebugMode")
				end,
				order = 4
			},
			debugDescription = {
				name = Locale.GENERAL_DEBUG_TOOLTIP,
				type = "description",
				order = 5
			},
		},
	}
end