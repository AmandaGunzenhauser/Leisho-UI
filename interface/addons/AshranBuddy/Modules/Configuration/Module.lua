local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Constants
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 500

-- Registration
local Configuration = Engine:RegisterModule("Configuration")

local AceDialog = AceDialog or LibStub("AceConfigDialog-3.0")
local AceRegistry = AceRegistry or LibStub("AceConfigRegistry-3.0")
local Options = {}

-- Initialize the module.
function Configuration:OnInitialize()
end

-- Called when the module is enabled.
function Configuration:OnEnable()
	Options = {
		name = Locale.ADDON_NAME,
		type = "group",
		args = {}
	}

	-- Pass option creation to active modules
	for key, module in pairs(Engine.Modules) do
		if type(module.OnConfiguration) == "function" then
			module:OnConfiguration(Options.args)
		end
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable(Engine.AddOnName, Options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(Engine.AddOnName, Locale.ADDON_NAME)
end

-- Called when the module is disabled.
function Configuration:OnDisable()
end

-- Opens the configuration dialog.
function Configuration:Open()
	AceDialog:SetDefaultSize(Engine.AddOnName, WINDOW_WIDTH, WINDOW_HEIGHT)
	AceDialog:Open(Engine.AddOnName)
end