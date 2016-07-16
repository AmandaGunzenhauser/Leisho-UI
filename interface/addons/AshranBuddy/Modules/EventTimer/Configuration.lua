local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local EventTimer = Engine:GetModule("EventTimer")

function EventTimer:OnConfiguration(options)
	local settings = Settings:Get(self.Name)
	options.EventTimer = {
		name = Locale.TIMER_NAME,
		type = "group",
		order = 10,
		args = {
			header = {
				name = Locale.TIMER_NAME,
				type = "header",
				order = 0
			},
			headerDescription = {
				name = Locale.TIMER_DESCRIPTION,
				type = "description",
				order = 1
			},
			enabled = {
				name = Locale.ADDON_MODULE_ENABLED,
				desc = Locale.TIMER_ENABLE_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					settings.enabled = val
					if (val) then
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
				name = Locale.TIMER_ENABLE_TOOLTIP,
				type = "description",
				order = 3
			},
			locked = {
				name = Locale.TIMER_LOCK,
				desc = Locale.TIMER_LOCK_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					settings.locked = val
					if (settings.locked) then
						self:Lock()
					else
						self:Unlock()
					end
				end,
				get = function(info)
					return settings.locked
				end,
				order = 4
			},
			lockedDescription = {
				name = Locale.TIMER_LOCK_TOOLTIP,
				type = "description",
				order = 5
			},
			showTimer = {
				name = Locale.TIMER_SHOW_TIME,
				desc = Locale.TIMER_SHOW_TIME_TOOLTIP,
				type = "toggle",
				set = function(info, val)
					settings.showTimer = val
					if (settings.showTimer) then
						for i = 1, #self.statusBars do
							self.statusBars[i].eventTimeFontString:Show()
						end
					else
						for i = 1, #self.statusBars do
							self.statusBars[i].eventTimeFontString:Hide()
						end
					end
				end,
				get = function(info)
					return settings.showTimer
				end,
				order = 6
			},
			showTimerDescription = {
				name = Locale.TIMER_SHOW_TIME_TOOLTIP,
				type = "description",
				order = 7
			},
		},
	}
end