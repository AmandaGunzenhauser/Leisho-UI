local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Initializes a new or existing settings database instance.
function Settings:Initialize()
	self.Defaults = {
		global = {
			version = 7
		},
		profile = {
			firstRun = true,
			DebugMode = false,
			Api = {
				enabled = true,
			},
			General = {
				enabled = true,
			},
			Configuration = {
				enabled = true,
			},
			BattleFlow = {
				enabled = true,
				locked = false,
				point = "TOP",
				relativePoint = "TOP",
				x = 0,
				y = -10
			},
			EventTimer = {
				enabled = true,
				locked = false,
				showTimer = true,
				stacked = true,
				growUp = false,
				point = "CENTER",
				relativePoint = "CENTER",
				x = 0,
				y = 0
			},
			NemesisFinder = {
				enabled = true,
				marking = true,
				target = "AByQuest"
			},
		},
	}

	self.Database = LibStub("AceDB-3.0"):New(GetAddOnMetadata(Engine.AddOnName, "X-SavedVariables"), self.Defaults)
end

-- Gets a per character setting using the specified name.
function Settings:Get(name)
	return self.Database.profile[name]
end

-- Sets a per character setting using the specified name.
function Settings:Set(name, value)
	self.Database.profile[name] = value
end

-- Creates a settings object using the specified name, this
-- does not overwrite extisting values.
function Settings:RegisterDefaults(name, value)
	if type(value) == "table" then
		if self.Database.profile[name] == nil then
			self.Database.profile[name] = value
		else
			for k, v in pairs(value) do
				if self.Database.profile[name].k == nil then
					self.Database.profile[name].k = v
				end
			end
		end
	else
		if self.Database.profile[name] == nil then
			self.Database.profile[name] = value
		end
	end
end

-- Gets a value indicating if debug mode is enabled
function Settings:IsDebug()
	return self.Database.profile["DebugMode"]
end