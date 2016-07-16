local Engine, Api, Locale, Settings = unpack(AshranBuddy)

-- Registration
local General = Engine:RegisterModule("General")

local BrokenBones = 118043

-- Initialize the module.
function General:OnInitialize()
end

-- Called when the module is enabled.
function General:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", General.OnChatMessage)
end

-- Called when the module is disabled.
function General:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", General.OnChatMessage)
end

-- Called when a loot chat message is receive.
function General:OnChatMessage(event, message)
	return message ~= nil and message:find(BrokenBones)
end