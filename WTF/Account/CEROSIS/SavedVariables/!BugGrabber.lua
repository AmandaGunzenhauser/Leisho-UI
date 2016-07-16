
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 1,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\Archy\\Archy-6.2.4.1.lua:443: attempt to index upvalue 'ArtifactFrame' (a nil value)",
			["time"] = "2016/05/15 15:47:53",
			["stack"] = "Interface\\AddOns\\Archy\\Archy-6.2.4.1.lua:443: in function `ConfigUpdated'\nInterface\\AddOns\\Archy\\Archy-6.2.4.1.lua:895: in function `?'\n...ore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:145: in function <...ore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:145>\n[string \"safecall Dispatcher[3]\"]:4: in function <[string \"safecall Dispatcher[3]\"]:4>\n[C]: ?\n[string \"safecall Dispatcher[3]\"]:13: in function `?'\n...ore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0-6.lua:90: in function `Fire'\n...erface\\AddOns\\DataStore\\libs\\AceDB-3.0\\AceDB-3.0-26.lua:217: in function <...erface\\AddOns\\DataStore\\libs\\AceDB-3.0\\AceDB-3.0.lua:206>\nInterface\\AddOns\\Archy\\Archy-6.2.4.1.lua:639: in function <Interface\\AddOns\\Archy\\Archy.lua:624>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\n...\\AddOns\\DataStore\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:529: in function `InitializeAddon'\n...\\AddOns\\DataStore\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:644: in function <...\\AddOns\\DataStore\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:636>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "...ddOns\\DirectionArrow\\Libs\\LibMapData-1.0-1141\\library.lua:2298: Usage: SetMapZoom(continentIndex [,zoneIndex]) .. requested continent out of bounds",
			["time"] = "2016/05/15 15:47:54",
			["locals"] = "(*temporary) = 8\n(*temporary) = 0\n",
			["stack"] = "[C]: in function `SetMapZoom'\n...ddOns\\DirectionArrow\\Libs\\LibMapData-1.0-1141\\library.lua:2298: in main chunk",
			["session"] = 1,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "...e\\AddOns\\Grid\\libs\\AceConsole-2.0\\AceConsole-2.0-91094.lua:2582: AceTab-2.0-91098: Cannot register frame \"ChatFrameEditBox\"; it does not exist",
			["time"] = "2016/05/15 15:47:56",
			["stack"] = "Interface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:619: in function `Register'\nInterface\\AddOns\\Grid\\libs\\AceTab-2.0\\AceTab-2.0-91098.lua:338: in main chunk",
			["session"] = 1,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:298: table index is nil",
			["time"] = "2016/05/15 15:47:57",
			["locals"] = "MAJOR_VERSION = \"LibHealComm-3.0\"\nMINOR_VERSION = 90094\nlib = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\nplayerName = \"Snorunt\"\nplayerRealm = \"Thrall\"\nplayerClass = \"DRUID\"\nisHealer = true\nSpellCache = <table> {\n}\nGlyphCache = <table> {\n}\nHealTime = <table> {\n}\nHealTarget = <table> {\n}\nHealSize = <table> {\n}\nHealModifier = <table> {\n}\nSentTargetName = nil\nLastSpellCastIndex = nil\nCastInfoIsCasting = nil\nCastInfoHealingTargetUnitID = nil\nCastInfoHealingTargetNames = nil\nCastInfoHealingSize = nil\nCastInfoEndTime = nil\nSentTime = 0\nLatency = 0\nVersions = <table> {\n}\nInRaid = nil\nInParty = nil\nSubgroup = <table> {\n}\nItemSetGear = <table> {\n}\nNumItemSet = <table> {\n}\nEquipmentSlotIDs = <table> {\n 1 = 5\n 2 = 8\n 3 = 10\n 4 = 1\n 5 = 7\n 6 = 3\n 7 = 6\n 8 = 9\n}\ntype = <function> defined =[C]:-1\ntonumber = <function> defined =[C]:-1\nmath = <table> {\n log = <function> defined =[C]:-1\n acos = <function> defined =[C]:-1\n ldexp = <function> defined =[C]:-1\n huge = 1.#INF\n pi = 3.1415926535898\n pow = <function> defined =[C]:-1\n tanh = <function> defined =[C]:-1\n deg = <function> defined =[C]:-1\n tan = <function> defined =[C]:-1\n cosh = <function> defined =[C]:-1\n cos = <function> defined =[C]:-1\n random = <function> defined =[C]:-1\n sinh = <function> defined =[C]:-1\n frexp = <function> defined =[C]:-1\n ceil = <function> defined =[C]:-1\n floor = <function> defined =[C]:-1\n rad = <function> defined =[C]:-1\n abs = <function> defined =[C]:-1\n sqrt = <function> defined =[C]:-1\n modf = <function> defined =[C]:-1\n asin = <function> defined =[C]:-1\n min = <function> defined =[C]:-1\n max = <function> defined =[C]:-1\n fmod = <function> defined =[C]:-1\n log10 = <function> defined =[C]:-1\n atan2 = <function> defined =[C]:-1\n exp = <function> defined =[C]:-1\n sin = <function> defined =[C]:-1\n atan = <function> defined =[C]:-1\n}\nstring = <table> {\n split = <function> defined =[C]:-1\n match = <function> defined =[C]:-1\n gmatch = <function> defined =[C]:-1\n upper = <function> defined =[C]:-1\n gsub = <function> defined =[C]:-1\n format = <function> defined =[C]:-1\n utf8sub = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:183\n lower = <function> defined =[C]:-1\n sub = <function> defined =[C]:-1\n gfind = <function> defined =[C]:-1\n len = <function> defined =[C]:-1\n rep = <function> defined =[C]:-1\n utf8len = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:158\n char = <function> defined =[C]:-1\n rtgsub = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:610\n join = <function> defined =[C]:-1\n reverse = <function> defined =[C]:-1\n byte = <function> defined =[C]:-1\n trim = <function> defined =[C]:-1\n utf8reverse = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:286\n find = <function> defined =[C]:-1\n}\nselect = <function> defined =[C]:-1\npairs = <function> defined =[C]:-1\nunpack = <function> defined =[C]:-1\nUnitName = <function> defined =[C]:-1\nSendAddonMessage = <function> defined =[C]:-1\nIsInInstance = <function> defined =[C]:-1\nUnitBuff = <function> defined =[C]:-1\nUnitDebuff = <function> defined =[C]:-1\nUnitLevel = <function> defined =[C]:-1\nGetInventoryItemLink = <function> defined =[C]:-1\nGetTime = <function> defined =[C]:-1\nUnitCastingInfo = <function> defined =[C]:-1\nGetSpellBonusHealing = <function> defined =[C]:-1\nGetTalentInfo = <fun",
			["stack"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:298: in main chunk",
			["session"] = 1,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "...ns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-60200-1.lua:541: Cannot access key \"RegisterNamespace\" in db table. You may want to use db.profile[\"RegisterNamespace\"]",
			["time"] = "2016/05/15 15:47:57",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:666: in function `InitializeAddon'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:541: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:518>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:298: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\GridManaBars\\GridStatusMana-1.30000.2008101801.nil.lua:3: AceModuleCore-2.0-91091: Cannot find module \"GridRoster\".",
			["time"] = "2016/05/15 15:47:57",
			["locals"] = "(*temporary) = \"AceModuleCore-2.0: Cannot find module \"GridRoster\".\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:122: in function `error'\n...ns\\Grid\\libs\\AceModuleCore-2.0\\AceModuleCore-2.0-91091.lua:260: in function `GetModule'\nInterface\\AddOns\\GridManaBars\\GridStatusMana-1.30000.2008101801.nil.lua:3: in main chunk",
			["session"] = 1,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\GridManaBars\\GridManaBar.lua:65: Cannot access key \"RegisterNamespace\" in db table. You may want to use db.profile[\"RegisterNamespace\"]",
			["time"] = "2016/05/15 15:47:57",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:666: in function `InitializeAddon'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:541: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:518>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:298: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "...dStatusDirectionArrows\\GridStatusDirectionArrows-v1.3.lua:12: AceModuleCore-2.0-91091: Cannot find module \"GridRoster\".",
			["time"] = "2016/05/15 15:47:57",
			["locals"] = "(*temporary) = \"AceModuleCore-2.0: Cannot find module \"GridRoster\".\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:122: in function `error'\n...ns\\Grid\\libs\\AceModuleCore-2.0\\AceModuleCore-2.0-91091.lua:260: in function `GetModule'\n...dStatusDirectionArrows\\GridStatusDirectionArrows-v1.3.lua:12: in main chunk",
			["session"] = 1,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridRange-1.30000.2008101801.nil.lua:84: attempt to call global 'GetSpellName' (a nil value)",
			["time"] = "2016/05/15 15:48:11",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:1051: in function `ManualEnable'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:979: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:973>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:260: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:801: MB_mainFrame:SetPoint(): Unknown region point",
			["time"] = "2016/05/15 15:48:11",
			["locals"] = "(*temporary) = MB_mainFrame {\n 0 = <userdata>\n}\n(*temporary) = \"\"\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n variablesLoaded = true\n}\n(*temporary) = 0\n(*temporary) = 0\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:801: in function `MB_setpositions'\nInterface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:1912: in function <Interface\\AddOns\\MarkingBar\\MarkingBar.lua:1870>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridLayout-1.30000.2008101801.nil.lua:779: attempt to call global 'GetNumRaidMembers' (a nil value)",
			["time"] = "2016/05/15 15:48:11",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:1051: in function `ManualEnable'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:979: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:973>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:260: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 2,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridCore.lua:387: attempt to call global 'GetNumPartyMembers' (a nil value)",
			["time"] = "2016/05/15 15:48:13",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:18: attempt to call field '?' (a nil value)",
			["time"] = "2016/05/15 15:48:12",
			["locals"] = "this = <unnamed> {\n 0 = <userdata>\n}\nevent = \"PLAYER_ENTERING_WORLD\"\n(*temporary) = nil\n(*temporary) = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\n(*temporary) = \"attempt to call field '?' (a nil value)\"\nlib = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\n",
			["stack"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:18: in function <...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0.lua:18>",
			["session"] = 1,
			["counter"] = 34,
		}, -- [13]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridStatusHeals-1.30000.2008101801.nil.lua:161: attempt to call method 'UnitIncomingHealGet' (a nil value)",
			["time"] = "2016/05/15 15:48:14",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 1,
			["counter"] = 11,
		}, -- [14]
		{
			["message"] = "...bs\\SpecialEvents-Aura-2.0\\SpecialEvents-Aura-2.0-90209.lua:158: attempt to call upvalue 'GetNumRaidMembers' (a nil value)",
			["time"] = "2016/05/15 15:48:19",
			["stack"] = "",
			["session"] = 1,
			["counter"] = 95,
		}, -- [15]
	},
}
