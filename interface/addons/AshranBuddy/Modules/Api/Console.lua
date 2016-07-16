local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Embeds
Api = Engine:GetModule("Api")
LibStub("AceConsole-3.0"):Embed(Api)

-- Enable command console functionality
function Api:EnableConsole()
	self:RegisterChatCommand("ashranbuddy", "OnCommand")
	self:RegisterChatCommand("ab", "OnCommand")
end

-- Process the slash command ('input' contains whatever follows the slash command)
function Api:OnCommand(input)
	if input == "" then
		local configuration = Engine:GetModule("Configuration")
		configuration:Open()
	end

	-- Pass chat commands to active modules
	for key, module in pairs(Engine.Modules) do
		if module.Name ~= "Api" and module.Enabled and type(module.OnCommand) == "function" then
			module:OnCommand(input)
		end
	end
end