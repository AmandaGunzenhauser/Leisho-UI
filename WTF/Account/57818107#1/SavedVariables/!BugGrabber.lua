
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 7,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\HelloWorld\\main.lua:24: attempt to concatenate global 'HaveWeMetCount' (a nil value)",
			["time"] = "2016/02/03 21:55:43",
			["locals"] = "editBox = ChatFrame1EditBox {\n focusMid = ChatFrame1EditBoxFocusMid {\n }\n tabCompleteTableIndex = 1\n focusLeft = ChatFrame1EditBoxFocusLeft {\n }\n focusRight = ChatFrame1EditBoxFocusRight {\n }\n 0 = <userdata>\n headerSuffix = ChatFrame1EditBoxHeaderSuffix {\n }\n setText = 0\n text = \"\"\n header = ChatFrame1EditBoxHeader {\n }\n addHighlightedText = true\n language = \"Orcish\"\n chatFrame = ChatFrame1 {\n }\n languageID = 1\n addSpaceToAutoComplete = true\n}\nsend = 1\nparseIfNoSpaces = nil\ntext = \"/hwm\"\ncommand = \"/HWM\"\nmsg = \"\"\nhash_SecureCmdList = <table> {\n /MA = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1413\n /RANDOMPET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1582\n /WM = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1554\n /RFP = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1588\n /MAINASSISTOFF = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1426\n /EQ = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1208\n /PETMOVETO = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1463\n /STOPCASTING = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1150\n /CLEARTARGET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1327\n /EQUIPSET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1547\n /CASTGLYPH = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1194\n /PETATTACK = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1447\n /CASTSEQUENCE = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1143\n /SP = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1570\n /MT = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1387\n /EQUIP = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1208\n /TARGETEXACT = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1275\n /A = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1353\n /RANDOMFAVORITEPET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1588\n /SWAPACTIONBAR = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1245\n /FOCUS = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1367\n /CAST = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1104\n /USE = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1117\n /PETASSIST = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1494\n /TARGETLASTENEMY = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1339\n /STARTATTACK = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1087\n /TARGETFRIENDPLAYER = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1306\n /PETAUTOCASTON = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1500\n /CWM = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1561\n /USERANDOM = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1129\n /ASSIST = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1353\n /TAR = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1265\n /STOPMACRO = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1521\n /CANCELFORM = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1173\n /FORFEIT = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1443\n /EQUIPSLOT = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1215\n /DUEL = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1439\n /MAINTANKOFF = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1400\n /PETPASSIVE = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1476\n /PETFOLLOW = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1457\n /PETAGGRESSIVE = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1488\n /MAINTANK = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1387\n /TARGETLASTTARGET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1333\n /MTOFF = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1400\n /DISMISSPET = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1594\n /MAINASSIST = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1413\n /USETOY = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1611\n /TARGETFRIEND = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1299\n /TARGETLASTFRIEND = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1346\n /CQS = <function> defined @Interface\\Frame",
			["stack"] = "Interface\\AddOns\\HelloWorld\\main.lua:24: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4454: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4108: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4147: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\DirectionArrow\\DirectionArrow-v5.4.0.002.lua:290: bad argument #1 to 'match' (string expected, got nil)",
			["time"] = "2016/02/03 22:50:40",
			["locals"] = "self = <table> {\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:325\n RegisterChatCommand = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceConsole-3.0\\AceConsole-3.0.lua:85\n EnableModule = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:363\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:241\n IterateEmbeds = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:473\n defaultModuleLibraries = <table> {\n }\n CheckUnit = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:315\n UnregisterChatCommand = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceConsole-3.0\\AceConsole-3.0.lua:111\n Printf = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceConsole-3.0\\AceConsole-3.0.lua:69\n t = OVERLAY {\n }\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:440\n x = <unnamed> {\n }\n name = \"DirectionArrow\"\n IsEnabled = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:482\n orderedModules = <table> {\n }\n DisableModule = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:381\n RegisterMessage = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n GetArgs = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceConsole-3.0\\AceConsole-3.0.lua:144\n Print = <function> defined @Interface\\AddOns\\Bartender4\\libs\\AceConsole-3.0\\AceConsole-3.0.lua:54\n optionsFrames = <table> {\n }\n GROUP_ROSTER_UPDATE = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:179\n f = <unnamed> {\n }\n defaultModuleState = true\n IsModule = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:499\n db = <table> {\n }\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:418\n baseName = \"DirectionArrow\"\n UnregisterMessage = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n SetEnabledState = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:455\n UPDATE_MOUSEOVER_UNIT = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:332\n enabledState = true\n ToggleSticky = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:308\n RegisterEvent = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n UnregisterAllMessages = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n OnInitialize = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:115\n UnregisterAllEvents = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n SendMessage = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:85\n IterateModules = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:468\n SetArrow = <function> defined @Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:365\n NewModule = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:266\n GetName = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:310\n sticky = false\n UnregisterEvent = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n Disable = <function> defined @Interface\\AddOns\\Masque\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:345\n}\np = ElvUF_Parent {\n 0 = <userdata>\n WrapScript = <function> defined @Interface\\FrameXML\\SecureHandlers.lua:704\n SetFrameRef = <function> defined @Interface\\FrameXML\\SecureHandlers.lua:715\n Execute = <function> defined @Interface\\FrameXML\\SecureHandlers.lua:699\n UnwrapScript = <function> defined @Interface\\FrameXML\\SecureHandlers.lua:710\n}\nframe = ElvUF_Pa",
			["stack"] = "[C]: in function `match'\nInterface\\AddOns\\DirectionArrow\\DirectionArrow-v5.4.0.002.lua:290: in function `?'\nInterface\\AddOns\\DirectionArrow\\DirectionArrow-v5.4.0.002.lua:167: in function <Interface\\AddOns\\DirectionArrow\\DirectionArrow.lua:167>",
			["session"] = 4,
			["counter"] = 4,
		}, -- [2]
		{
			["message"] = "...ddOns\\DirectionArrow\\Libs\\LibMapData-1.0-1141\\library.lua:2298: Usage: SetMapZoom(continentIndex [,zoneIndex]) .. requested continent out of bounds",
			["time"] = "2016/02/03 22:00:27",
			["locals"] = "MAJOR = \"LibMapData-1.0\"\nMINOR = 1141\nlib = <table> {\n MAP_NORMAL = 0\n MAP_BG = 3\n MAP_RAID = 2\n callbacks = <table> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n MAP_SENARIO = 5\n UnregisterCallback = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n MAP_ARENA = 4\n MAP_INSTANCE = 1\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\Masque\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n}\nwatchFrame = <unnamed> {\n 0 = <userdata>\n}\nlastMap = nil\nlastFloor = 0\nmapData = <table> {\n 4 = <table> {\n }\n 9 = <table> {\n }\n 11 = <table> {\n }\n 13 = <table> {\n }\n 14 = <table> {\n }\n 16 = <table> {\n }\n 17 = <table> {\n }\n 19 = <table> {\n }\n 20 = <table> {\n }\n 21 = <table> {\n }\n 22 = <table> {\n }\n 23 = <table> {\n }\n 24 = <table> {\n }\n 26 = <table> {\n }\n 27 = <table> {\n }\n 28 = <table> {\n }\n 29 = <table> {\n }\n 30 = <table> {\n }\n 32 = <table> {\n }\n 758 = <table> {\n }\n 886 = <table> {\n }\n 759 = <table> {\n }\n 887 = <table> {\n }\n 760 = <table> {\n }\n 888 = <table> {\n }\n 761 = <table> {\n }\n 889 = <table> {\n }\n 762 = <table> {\n }\n 890 = <table> {\n }\n 763 = <table> {\n }\n 891 = <table> {\n }\n 510 = <table> {\n }\n 40 = <table> {\n }\n 764 = <table> {\n }\n 892 = <table> {\n }\n 765 = <table> {\n }\n 893 = <table> {\n }\n 766 = <table> {\n }\n 894 = <table> {\n }\n 767 = <table> {\n }\n 895 = <table> {\n }\n 512 = <table> {\n }\n 640 = <table> {\n }\n 768 = <table> {\n }\n 896 = <table> {\n }\n 321 = <table> {\n }\n 769 = <table> {\n }\n 897 = <table> {\n }\n 161 = <table> {\n }\n 770 = <table> {\n }\n 898 = <table> {\n }\n 899 = <table> {\n }\n 772 = <table> {\n }\n 900 = <table> {\n }\n 81 = <table> {\n }\n 773 = <table> {\n }\n 775 = <table> {\n }\n 903 = <table> {\n }\n 520 = <table> {\n }\n 776 = <table> {\n }\n 521 = <table> {\n }\n 905 = <table> {\n }\n 522 = <table> {\n }\n 906 = <table> {\n }\n 523 = <table> {\n }\n 779 = <table> {\n }\n 907 = <table> {\n }\n 524 = <table> {\n }\n 41 = <table> {\n }\n 780 = <table> {\n }\n 525 = <table> {\n }\n 781 = <table> {\n }\n 526 = <table> {\n }\n 782 = <table> {\n }\n 910 = <table> {\n }\n 527 = <table> {\n }\n 911 = <table> {\n }\n 528 = <table> {\n }\n 912 = <table> {\n }\n 529 = <table> {\n }\n 530 = <table> {\n }\n 914 = <table> {\n }\n 531 = <table> {\n }\n 532 = <table> {\n }\n 533 = <table> {\n }\n 789 = <table> {\n }\n 534 = <table> {\n }\n 535 = <table> {\n }\n 919 = <table> {\n }\n 536 = <table> {\n }\n 920 = <table> {\n }\n 793 = <table> {\n }\n 461 = <table> {\n }\n 922 = <table> {\n }\n 539 = <table> {\n }\n 795 = <table> {\n }\n 462 = <table> {\n }\n 34 = <table> {\n }\n 42 = <table> {\n }\n 796 = <table> {\n }\n 924 = <table> {\n }\n 541 = <table> {\n }\n 797 = <table> {\n }\n 925 = <table> {\n }\n 542 = <table> {\n }\n 798 = <table> {\n }\n 543 = <table> {\n }\n 799 = <table> {\n }\n 464 = <table> {\n }\n 544 = <table> {\n }\n 800 = <table> {\n }\n 928 = <table> {\n }\n 545 = <table> {\n }\n 673 = <table> {\n }\n 401 = <table> {\n }\n 465 = <table> {\n }\n 201 = <table> {\n }\n 930 = <table> {\n }\n 803 = <table> {\n }\n 466 = <table> {\n }\n 677 = <table> {\n }\n 101 = <table> {\n }\n 467 = <table> {\n }\n 678 = <table> {\n }\n 806 = <table> {\n }\n 934 = <table> {\n }\n 679 = <table> {\n }\n 807 = <table> {\n }\n 935 = <table> {\n }\n 680 = <table> {\n }\n 808 = <table> {\n }\n 681 = <table> {\n }\n 809 = <table> {\n }\n 937 = <table> {\n }\n 682 = <table> {\n }\n 810 = <table> {\n }\n 938 = <table> {\n }\n 683 = <table> {\n }\n 811 = <table> {\n }\n 939 = <table> {\n }\n 35 = <table> {\n }\n 43 = <table> {\n }\n 940 = <table> {\n }\n 685 = <table> {\n }\n 813 = <table> {\n }\n 471 = <table> {\n }\n 686 = <table> {\n }\n 687 = <table> {\n }\n 688 = <table> {\n }\n 816 = <table> {\n }\n 281 = <table> {\n }\n 689 = <table> {\n }\n 473 = <table> {\n }\n 141 = <table> {\n }\n 690 = <table> {\n }\n 691 = <table> {\n }\n 819 = <table> {\n }\n 692 = <table> {\n }\n 820 = <table> {\n }\n 475 = <table> {\n }\n 823 = <table> {\n }\n 476 = <table> {\n }\n 696 = <table> {\n }\n 824 = <table> {\n }\n 697 = <table> {\n }\n 477 = <table> {\n }\n 699 = <table> {\n }\n 478 = <table> {\n }\n 36 = <table> {\n }\n 700 = <table> {\n }\n 479 = <table> {\n }\n 480 = <table> {\n }\n 704 = <table> {\n }\n 481 = <table> {\n }\n 241 = <table> {\n }\n",
			["stack"] = "[C]: in function `SetMapZoom'\n...ddOns\\DirectionArrow\\Libs\\LibMapData-1.0-1141\\library.lua:2298: in main chunk",
			["session"] = 7,
			["counter"] = 5,
		}, -- [3]
		{
			["message"] = "...e\\AddOns\\Grid\\libs\\AceConsole-2.0\\AceConsole-2.0-91094.lua:2582: AceTab-2.0-91098: Cannot register frame \"ChatFrameEditBox\"; it does not exist",
			["time"] = "2016/05/15 11:01:41",
			["stack"] = "Interface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:619: in function `Register'\nInterface\\AddOns\\Grid\\libs\\AceTab-2.0\\AceTab-2.0-91098.lua:338: in main chunk",
			["session"] = 7,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:298: table index is nil",
			["time"] = "2016/05/15 11:01:41",
			["locals"] = "MAJOR_VERSION = \"LibHealComm-3.0\"\nMINOR_VERSION = 90094\nlib = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\nplayerName = \"Leisho\"\nplayerRealm = \"Durotan\"\nplayerClass = \"MONK\"\nisHealer = false\nSpellCache = <table> {\n}\nGlyphCache = <table> {\n}\nHealTime = <table> {\n}\nHealTarget = <table> {\n}\nHealSize = <table> {\n}\nHealModifier = <table> {\n}\nSentTargetName = nil\nLastSpellCastIndex = nil\nCastInfoIsCasting = nil\nCastInfoHealingTargetUnitID = nil\nCastInfoHealingTargetNames = nil\nCastInfoHealingSize = nil\nCastInfoEndTime = nil\nSentTime = 0\nLatency = 0\nVersions = <table> {\n}\nInRaid = nil\nInParty = nil\nSubgroup = <table> {\n}\nItemSetGear = <table> {\n}\nNumItemSet = <table> {\n}\nEquipmentSlotIDs = <table> {\n 1 = 5\n 2 = 8\n 3 = 10\n 4 = 1\n 5 = 7\n 6 = 3\n 7 = 6\n 8 = 9\n}\ntype = <function> defined =[C]:-1\ntonumber = <function> defined =[C]:-1\nmath = <table> {\n log = <function> defined =[C]:-1\n acos = <function> defined =[C]:-1\n ldexp = <function> defined =[C]:-1\n huge = 1.#INF\n pi = 3.1415926535898\n pow = <function> defined =[C]:-1\n tanh = <function> defined =[C]:-1\n deg = <function> defined =[C]:-1\n tan = <function> defined =[C]:-1\n cosh = <function> defined =[C]:-1\n cos = <function> defined =[C]:-1\n random = <function> defined =[C]:-1\n sinh = <function> defined =[C]:-1\n frexp = <function> defined =[C]:-1\n ceil = <function> defined =[C]:-1\n floor = <function> defined =[C]:-1\n rad = <function> defined =[C]:-1\n abs = <function> defined =[C]:-1\n sqrt = <function> defined =[C]:-1\n modf = <function> defined =[C]:-1\n asin = <function> defined =[C]:-1\n min = <function> defined =[C]:-1\n max = <function> defined =[C]:-1\n fmod = <function> defined =[C]:-1\n log10 = <function> defined =[C]:-1\n atan2 = <function> defined =[C]:-1\n exp = <function> defined =[C]:-1\n sin = <function> defined =[C]:-1\n atan = <function> defined =[C]:-1\n}\nstring = <table> {\n split = <function> defined =[C]:-1\n match = <function> defined =[C]:-1\n gmatch = <function> defined =[C]:-1\n upper = <function> defined =[C]:-1\n gsub = <function> defined =[C]:-1\n format = <function> defined =[C]:-1\n utf8sub = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:183\n lower = <function> defined =[C]:-1\n sub = <function> defined =[C]:-1\n gfind = <function> defined =[C]:-1\n len = <function> defined =[C]:-1\n rep = <function> defined =[C]:-1\n utf8len = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:158\n char = <function> defined =[C]:-1\n rtgsub = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:610\n join = <function> defined =[C]:-1\n reverse = <function> defined =[C]:-1\n byte = <function> defined =[C]:-1\n trim = <function> defined =[C]:-1\n utf8reverse = <function> defined @Interface\\AddOns\\ElvUI\\libs\\UTF8\\utf8.lua:286\n find = <function> defined =[C]:-1\n}\nselect = <function> defined =[C]:-1\npairs = <function> defined =[C]:-1\nunpack = <function> defined =[C]:-1\nUnitName = <function> defined =[C]:-1\nSendAddonMessage = <function> defined =[C]:-1\nIsInInstance = <function> defined =[C]:-1\nUnitBuff = <function> defined =[C]:-1\nUnitDebuff = <function> defined =[C]:-1\nUnitLevel = <function> defined =[C]:-1\nGetInventoryItemLink = <function> defined =[C]:-1\nGetTime = <function> defined =[C]:-1\nUnitCastingInfo = <function> defined =[C]:-1\nGetSpellBonusHealing = <function> defined =[C]:-1\nGetTalentInfo = <fun",
			["stack"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:298: in main chunk",
			["session"] = 7,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "...ns\\GridIndicatorSideIcons\\GridIndicatorSideIcons-60200-1.lua:541: Cannot access key \"RegisterNamespace\" in db table. You may want to use db.profile[\"RegisterNamespace\"]",
			["time"] = "2016/05/15 11:01:41",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:666: in function `InitializeAddon'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:541: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:518>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:298: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 7,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\GridManaBars\\GridStatusMana-1.30000.2008101801.nil.lua:3: AceModuleCore-2.0-91091: Cannot find module \"GridRoster\".",
			["time"] = "2016/05/15 11:01:41",
			["locals"] = "(*temporary) = \"AceModuleCore-2.0: Cannot find module \"GridRoster\".\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:122: in function `error'\n...ns\\Grid\\libs\\AceModuleCore-2.0\\AceModuleCore-2.0-91091.lua:260: in function `GetModule'\nInterface\\AddOns\\GridManaBars\\GridStatusMana-1.30000.2008101801.nil.lua:3: in main chunk",
			["session"] = 7,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\GridManaBars\\GridManaBar.lua:65: Cannot access key \"RegisterNamespace\" in db table. You may want to use db.profile[\"RegisterNamespace\"]",
			["time"] = "2016/05/15 11:01:41",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:666: in function `InitializeAddon'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:541: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:518>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:298: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 7,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "...dStatusDirectionArrows\\GridStatusDirectionArrows-v1.3.lua:12: AceModuleCore-2.0-91091: Cannot find module \"GridRoster\".",
			["time"] = "2016/05/15 11:01:41",
			["locals"] = "(*temporary) = \"AceModuleCore-2.0: Cannot find module \"GridRoster\".\"\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\Grid\\libs\\AceLibrary\\AceLibrary-91091.lua:122: in function `error'\n...ns\\Grid\\libs\\AceModuleCore-2.0\\AceModuleCore-2.0-91091.lua:260: in function `GetModule'\n...dStatusDirectionArrows\\GridStatusDirectionArrows-v1.3.lua:12: in main chunk",
			["session"] = 7,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridRange-1.30000.2008101801.nil.lua:84: attempt to call global 'GetSpellName' (a nil value)",
			["time"] = "2016/05/15 11:01:57",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:1051: in function `ManualEnable'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:979: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:973>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:260: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 7,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:801: MB_mainFrame:SetPoint(): Unknown region point",
			["time"] = "2016/05/15 11:01:57",
			["locals"] = "(*temporary) = MB_mainFrame {\n 0 = <userdata>\n}\n(*temporary) = \"\"\n(*temporary) = UIParent {\n 0 = <userdata>\n firstTimeLoaded = 1\n variablesLoaded = true\n}\n(*temporary) = 0\n(*temporary) = 0\n",
			["stack"] = "[C]: in function `SetPoint'\nInterface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:801: in function `MB_setpositions'\nInterface\\AddOns\\MarkingBar\\MarkingBar-2.2.1.lua:1912: in function <Interface\\AddOns\\MarkingBar\\MarkingBar.lua:1870>",
			["session"] = 7,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridCore.lua:387: attempt to call global 'GetNumPartyMembers' (a nil value)",
			["time"] = "2016/05/15 11:01:58",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 7,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\Grid\\GridLayout-1.30000.2008101801.nil.lua:779: attempt to call global 'GetNumRaidMembers' (a nil value)",
			["time"] = "2016/05/15 11:01:57",
			["stack"] = "...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:1051: in function `ManualEnable'\n...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0-91100.lua:979: in function <...rface\\AddOns\\Grid\\libs\\AceAddon-2.0\\AceAddon-2.0.lua:973>\n[C]: ?\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:260: in function `TriggerEvent'\n...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0-91097.lua:910: in function <...rface\\AddOns\\Grid\\libs\\AceEvent-2.0\\AceEvent-2.0.lua:903>",
			["session"] = 7,
			["counter"] = 2,
		}, -- [13]
		{
			["message"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:18: attempt to call field '?' (a nil value)",
			["time"] = "2016/05/15 11:01:58",
			["locals"] = "this = <unnamed> {\n 0 = <userdata>\n}\nevent = \"PLAYER_ENTERING_WORLD\"\n(*temporary) = nil\n(*temporary) = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\n(*temporary) = \"attempt to call field '?' (a nil value)\"\nlib = <table> {\n Callbacks = <table> {\n }\n TooltipTextLeft2 = <unnamed> {\n }\n UnregisterAllCallbacks = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n TooltipTextRight1 = <unnamed> {\n }\n TooltipTextLeft1 = <unnamed> {\n }\n Tooltip = <unnamed> {\n }\n TooltipTextRight5 = <unnamed> {\n }\n RegisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n TooltipTextLeft3 = <unnamed> {\n }\n TooltipTextRight2 = <unnamed> {\n }\n UnregisterCallback = <function> defined @Interface\\AddOns\\DataStore\\libs\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n TooltipTextRight3 = <unnamed> {\n }\n TooltipTextRight4 = <unnamed> {\n }\n TooltipTextLeft4 = <unnamed> {\n }\n EventFrame = <unnamed> {\n }\n TooltipTextLeft5 = <unnamed> {\n }\n}\n",
			["stack"] = "...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0-90094.lua:18: in function <...AddOns\\Grid\\libs\\LibHealComm-3.0\\LibHealComm-3.0.lua:18>",
			["session"] = 7,
			["counter"] = 7,
		}, -- [14]
		{
			["message"] = "...bs\\SpecialEvents-Aura-2.0\\SpecialEvents-Aura-2.0-90209.lua:158: attempt to call upvalue 'GetNumRaidMembers' (a nil value)",
			["time"] = "2016/05/15 11:02:00",
			["stack"] = "",
			["session"] = 7,
			["counter"] = 138,
		}, -- [15]
	},
}
