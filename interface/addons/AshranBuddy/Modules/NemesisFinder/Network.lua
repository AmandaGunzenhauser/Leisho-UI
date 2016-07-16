local Engine, Api, Locale, Settings = unpack(AshranBuddy)

local NemesisFinder = Engine:GetModule("NemesisFinder")

function NemesisFinder:SendRequest(id)
	if (IsInRaid() and self.Quest ~= nil) then
		local packet = { module = "NemesisFinder", type = "request", data = { quest = id } }
		-- Send the nemesis quest that I am currently on
		Api:SendCommMessage(Engine.AddOnName, Api:Serialize(packet), "RAID", nil, "NORMAL")
	end
end

function NemesisFinder:OnNetworkResponse(packet, distribution, sender)
	-- A raid member has requested a synchronise
	if (packet.type == "request") then
		NemesisFinder:OnCommRequest(sender, packet.data.quest)
	end
	
	-- You requested a synchronise and here it is
	if (packet.type == "synchronise" and distribution == "WHISPER") then
		NemesisFinder:OnCommSynchronise(sender)
	end
end

function NemesisFinder:OnCommRequest(sender, quest)
	if (self.Quest ~= nil) then
		local packet = { module = "NemesisFinder", type = "synchronise", data = {} }
		-- If I have the same nemesis quest then respond otherwise ignore
		if (self.Quest.ID == quest) then
			Api:SendCommMessage(Engine.AddOnName, Api:Serialize(packet), "WHISPER", sender, "NORMAL")
		end
	end
end

function NemesisFinder:OnCommSynchronise(sender)
	NemesisFinder:AddHighlight(sender)
	table.insert(Partners, sender)
end
