local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local BattleFlow = Engine:GetModule("BattleFlow")

function BattleFlow:OnConfiguration(options)
	local settings = Settings:Get(self.Name)
	if (self:IsCompatible()) then
		options.BattleFlow = {
			name = Locale.BATTLEFLOW_NAME,
			type = "group",
			order = 30,
			args = {
				header = {
					name = Locale.BATTLEFLOW_NAME,
					type = "header",
					order = 0
				},
				headerDescription = {
					name = Locale.BATTLEFLOW_DESCRIPTION,
					type = "description",
					order = 1
				},
				enabled = {
					name = Locale.ADDON_MODULE_ENABLED,
					desc = Locale.BATTLEFLOW_ENABLE_TOOLTIP,
					type = "toggle",
					set = function(info, val) settings.enabled = val
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
					name = Locale.BATTLEFLOW_ENABLE_TOOLTIP,
					type = "description",
					order = 3
				},
				locked = {
					name = Locale.BATTLEFLOW_LOCK,
					desc = Locale.BATTLEFLOW_LOCK_TOOLTIP,
					type = "toggle",
					set = function(info, val) settings.locked = val
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
					name = Locale.BATTLEFLOW_LOCK_TOOLTIP,
					type = "description",
					order = 5
				},
				showTimer = {
					name = Locale.BATTLEFLOW_RESET,
					type = "execute",
					func = function(info, val)
						settings.point = "TOP"
						settings.relativePoint = "TOP"
						settings.x = 0
						settings.y = -10
						self.Component:ClearAllPoints()
						self.Component:SetPoint(settings.point, UIParent, settings.relativePoint, settings.x, settings.y)
					end,
					order = 6
				},
			},
		}
	else
		options.BattleFlow = {
			name = Locale.BATTLEFLOW_NAME,
			type = "group",
			order = 30,
			args = {
				header = {
					name = Locale.BATTLEFLOW_NAME,
					type = "header",
					order = 0
				},
				headerDescription = {
					name = Locale.BATTLEFLOW_DESCRIPTION,
					type = "description",
					order = 1
				},
			},
		}
	end
end