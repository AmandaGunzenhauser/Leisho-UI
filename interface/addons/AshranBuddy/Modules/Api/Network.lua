local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Embeds
Api = Engine:GetModule("Api")
LibStub("AceComm-3.0"):Embed(Api)
LibStub("AceSerializer-3.0"):Embed(Api)

-- Enable network messaging functionality.
function Api:EnableNetwork()
	self:RegisterComm(Engine.AddOnName, "OnNetworkResponse")
end

-- Called when a AddOn message has been received from another client.
function Api:OnNetworkResponse(input)
	local success, packet = self:Deserialize(input)
	if (not success) then
		return
	end

	-- Pass messages to correct module
	local module = Engine.Modules[packet.module]
	if module.Name ~= "Api" and module ~= nil and type(module.OnNetworkResponse) == "function" then
		module:OnNetworkResponse(packet, distribution, sender)
	end
end