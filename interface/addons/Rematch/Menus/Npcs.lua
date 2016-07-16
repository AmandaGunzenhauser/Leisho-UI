local _,L = ...
local rematch = Rematch

--[[

	The following tables describe all of the notable NPCs and their pets, in the
	order to be displayed, in this format:
	{ npcID, group, speciesID1,speciesID2,speciesID3 },

	group is the index into the notableGroups table.

	TODO: arrange speciesIDs in the order they're fought

]]

rematch:InitModule(function()
	rematch:CacheNpcIDs()
	rematch:CreateNpcMenus()
end)

rematch.notableNames = {} -- name of NPCs, indexed by NPC IDs

rematch.notableGroups = {
	[0] = OTHER, -- Little Tommy Newcomer, Jeremy Feasel, Christoph VonFeasel
	[1] = L["Eastern Kingdom"],
	[2] = L["Kalimdor"],
	[3] = L["Outland"],
	[4] = L["Northrend"],
	[5] = L["Cataclysm"],
	[6] = L["Pandaria"],
	[7] = L["Beasts of Fable"],
	[8] = L["Celestial Tournament"],
	[9] = L["Draenor"],
	[10] = L["Garrison"], -- Erris/Kura and Pets Versus Pests
	[11] = L["Menagerie"],
	[12] = L["Tanaan Jungle"],
	[13] = L["Val'sharah"],
	[14] = L["Suramar"],
	[15] = L["Stormheim"],
	[16] = L["Highmountain"],
	[17] = L["Dalaran"],
	[18] = L["Azsuna"],
}

rematch.notableNPCs = {

	-- Other
	{ 85519, 0, 1475,1476,1477 }, -- Christoph VonFeasel
	{ 67370, 0, 1067,1065,1066 }, -- Jeremy Feasel
	{ 73626, 0, 1339 }, -- Little Tommy Newcomer

	-- Eastern Kingdom
	{ 66522, 1, 948,949,947 }, -- Lydia Accoste
	{ 65656, 1, 887,886,888 }, -- Bill Buckler
	{ 66478, 1, 932,931,933 }, -- David Kosse
	{ 66512, 1, 935,936,934 }, -- Deiza Plaguehorn
	{ 66520, 1, 946,945,944 }, -- Durin Darkhammer
	{ 65655, 1, 881,880,882 }, -- Eric Davidson
	{ 66518, 1, 941,943,942 }, -- Everessa
	{ 64330, 1, 873,872 }, -- Julia Stevens
	{ 66515, 1, 939,937,938 }, -- Kortas Darkhammer
	{ 65651, 1, 878,877,879 }, -- Lindsay
	{ 65648, 1, 875,876,874 }, -- Old MacDonald
	{ 63194, 1, 885,884,883 }, -- Steven Lisbane

	-- Kalimdor
	{ 66466, 2, 928,927,929 }, -- Stone Cold Trixxy
	{ 66136, 2, 894,896,895 }, -- Analynn
	{ 66422, 2, 908,909,907 }, -- Cassandra Kaboom
	{ 66135, 2, 891,893,892 }, -- Dagra the Fierce
	{ 66412, 2, 924,925,926 }, -- Elena Flutterfly
	{ 66436, 2, 913,911,912 }, -- Grazzle the Great
	{ 66452, 2, 915,917,916 }, -- Kela Grimtotem
	{ 66372, 2, 901,902,900 }, -- Merda Stronghoof
	{ 66352, 2, 906,904,905 }, -- Traitor Gluk
	{ 66442, 2, 922,923,921 }, -- Zoltan
	{ 66137, 2, 897,899,898 }, -- Zonya the Sadist
	{ 66126, 2, 889,890 }, -- Zunta

	-- Outland
	{ 66557, 3, 964,963,962 }, -- Bloodknight Antari
	{ 66552, 3, 957,958,956 }, -- Narrok
	{ 66550, 3, 952,951,950 }, -- Nicki Tinytech
	{ 66553, 3, 961,959,960 }, -- Morulu The Elder
	{ 66551, 3, 953,955,954 }, -- Ras'an

	-- Northrend
	{ 66675, 4, 978,977,979 }, -- Major Payne
	{ 66635, 4, 967,966,965 }, -- Beegle Blastfuse
	{ 66639, 4, 976,974,975 }, -- Gutretch
	{ 66636, 4, 968,970,969 }, -- Nearly Headless Jacob
	{ 66638, 4, 973,971,972 }, -- Okrut Dragonwaste

	-- Cataclysm
	{ 66815, 5, 984,983,985 }, -- Bordin Steadyfist
	{ 66819, 5, 982,980,981 }, -- Brok
	{ 66822, 5, 987,986,988 }, -- Goz Banefury
	{ 66824, 5, 989,991,990 }, -- Obalis

	-- Pandaria
	{ 66741, 6, 1012,1011,1010 }, -- Aki the Chosen
	{ 66738, 6, 1001,1002,1003 }, -- Courageous Yon
	{ 66734, 6, 995,997,996 }, -- Farmer Nishi
	{ 66730, 6, 992,993,994 }, -- Hyuna of the Shrines
	{ 66733, 6, 1000,999,998 }, -- Mo'ruk
	{ 66918, 6, 1006,1005,1004 }, -- Seeker Zusshi
	{ 66739, 6, 1009,1007,1008 }, -- Wastewalker Shu
	{ 68463, 6, 1130,1131,1139 }, -- Burning Pandaren Spirit
	{ 68462, 6, 1132,1138,1133 }, -- Flowing Pandaren Spirit
	{ 68465, 6, 1137,1141,1134 }, -- Thundering Pandaren Spirit
	{ 68464, 6, 1135,1140,1136 }, -- Whispering Pandaren Spirit

	-- Beasts of Fable
	{ 68555, 7, 1129 }, -- Ka'wi the Gorger
	{ 68563, 7, 1192 }, -- Kafi
	{ 68564, 7, 1193 }, -- Dos-Ryga
	{ 68565, 7, 1194 }, -- Nitun
	{ 68560, 7, 1189 }, -- Greyhoof
	{ 68561, 7, 1190 }, -- Lucky Yi
	{ 68566, 7, 1195 }, -- Skitterer Xi'a
	{ 68558, 7, 1187 }, -- Gorespine
	{ 68559, 7, 1188 }, -- No-No
	{ 68562, 7, 1191 }, -- Ti'un the Wanderer

	-- Celestial Tournament
	{ 71926, 8, 1283,1284,1285 }, -- Lorewalker Cho
	{ 71934, 8, 1271,1269,1268 }, -- Dr. Ion Goldbloom
	{ 71929, 8, 1289,1290,1291 }, -- Sully "The Pickle" McLeary
	{ 71931, 8, 1292,1293,1295 }, -- Taran Zhu
	{ 71927, 8, 1280,1281,1282 }, -- Chen Stormstout
	{ 71924, 8, 1299,1301,1300 }, -- Wrathion
	{ 71932, 8, 1296,1297,1298 }, -- Wise Mari
	{ 71933, 8, 1278,1277,1279 }, -- Blingtron 4000
	{ 71930, 8, 1288,1287,1286 }, -- Shademaster Kiryn
	{ 72285, 8, 1311 }, -- Chi-Chi, Hatchling of Chi-Ji
	{ 72009, 8, 1267 }, -- Xu-Fu, Cub of Xuen
	{ 72291, 8, 1317 }, -- Yu'la, Broodling of Yu'lon
	{ 72290, 8, 1319 }, -- Zao, calfling of Niuzao

	-- Draenor
	{ 87124, 9, 1548,1547,1549 }, -- Ashlei
	{ 83837, 9, 1424,1443,1444 }, -- Cymre Brightblade
	{ 87122, 9, 1552,1553,1550 }, -- Gargra
	{ 87125, 9, 1562,1561,1560 }, -- Taralune
	{ 87110, 9, 1554,1555,1556 }, -- Tarr the Terrible
	{ 87123, 9, 1559,1557,1558 }, -- Vesharr

	-- Garrison
	{ 90675, 10, 1640,1641,1642 }, -- Erris the Collector of Pocket Lint (Spores, Dusty, and Salad)
	{ 91014, 10, 1637,1643,1644 }, -- Erris the Collector of Pocket Lint (Moon, Mouthy, and Carl)
	{ 91015, 10, 1646,1645,1647 }, -- Erris the Collector of Pocket Lint (Enbi'see, Mal, and Bones)
	{ 91016, 10, 1648,1651,1649 }, -- Erris the Collector of Pocket Lint (Sprouts, Prince Charming, and Runts)
	{ 91017, 10, 1654,1653,1652 }, -- Erris the Collector of Pocket Lint (Nicodemus, Brisby, and Jenner)
	{ 91026, 10, 1640,1641,1642 }, -- Kura Thunderhoof (Spores, Dusty, and Salad)
	{ 91361, 10, 1637,1643,1644 }, -- Kura Thunderhoof (Moon, Mouthy, and Carl)
	{ 91362, 10, 1646,1645,1647 }, -- Kura Thunderhoof (Enbi'see, Mal, and Bones)
	{ 91363, 10, 1648,1651,1649 }, -- Kura Thunderhoof (Sprouts, Prince Charming, and Runts)
	{ 91364, 10, 1654,1653,1652 }, -- Kura Thunderhoof (Nicodemus, Brisby, and Jenner)
	{ 85420, 10, 1473 }, -- Carrotus Maximus
	{ 85463, 10, 1474 }, -- Gorefu
	{ 85419, 10, 1472 }, -- Gnawface

	-- Menagerie
	{ 79751, 11, 1409 }, -- Eleanor
	{ 85629, 11, 1500,1499 }, -- Challenge Post (Tirs, Fiero)
	{ 85630, 11, 1501,1502,1503 }, -- Challenge Post (Rockbiter, Stonechewer, Acidtooth)
	{ 85650, 11, 1480 }, -- Quintessence of Light
	{ 85632, 11, 1504,1505,1506 }, -- Challenge Post (Blingtron 4999b, Protectron 022481, Protectron 011803)
	{ 85685, 11, 1507 }, -- Stitches Jr.
	{ 85634, 11, 1508,1509,1510 }, -- Challenge Post (Manos, Hanos, Fatos)
	{ 79179, 11, 1400,1401,1402 }, -- Squirt (Deebs, Tyri, Puzzle)
	{ 85622, 11, 1479,1482 }, -- Challenge Post (Brutus, Rukus)
	{ 85517, 11, 1483,1484,1485 }, -- Challenge Post (Mr. Terrible, Carroteye, Sloppus)
	{ 85659, 11, 1486 }, -- The Beakinator
	{ 85624, 11, 1488,1487 }, -- Challenge Post (Queen Floret, King Floret)
	{ 85625, 11, 1489,1490 }, -- Challenge Post (Kromli, Gromli)
	{ 85626, 11, 1492,1494,1493 }, -- Challenge Post (Grubbles, Scrags, Stings)
	{ 85627, 11, 1496,1497,1498 }, -- Challenge Post (Jahan, Samm, Archimedes)

	-- Tanaan Jungle
	{ 94645, 12, 1681 }, -- Bleakclaw
	{ 94638, 12, 1674 }, -- Chaos Pup
	{ 94637, 12, 1673 }, -- Corrupted Thundertail
	{ 94639, 12, 1675 }, -- Cursed Spirit
	{ 94644, 12, 1680 }, -- Dark Gazer
	{ 94650, 12, 1686 }, -- Defiled Earth
	{ 94642, 12, 1678 }, -- Direflame
	{ 94647, 12, 1683 }, -- Dreadwalker
	{ 94640, 12, 1676 }, -- Felfly
	{ 94601, 12, 1671 }, -- Felsworn Sentry
	{ 94643, 12, 1679 }, -- Mirecroak
	{ 94648, 12, 1684 }, -- Netherfist
	{ 94649, 12, 1685 }, -- Skrillix
	{ 94641, 12, 1677 }, -- Tainted Mudclaw
	{ 94646, 12, 1682 }, -- Vile Blood of Draenor

	-- Azsuna
	{ 105898, 18, 1883 }, -- Size Doesn't Matter (Blottis)
	{ 97294, 18, 1729 }, -- Azsuna Specimens (Olivetail Hare)
	{ 97283, 18, 1728 }, -- Azsuna Specimens (Juvenile Scuttleback)
	{ 97323, 18, 1731 }, -- Azsuna Specimens (Felspider)
	{ 106476, 18, 1893, 1894, 1892 }, -- Dazed and Confused and Adorable (Beguiling Orb)
	{ 106552, 18, 1897, 1898, 1899 }, -- Training with the Nightwatchers (Nightwatcher Merayl)
	{ 106417, 18, 1891 }, -- The Wine's Gone Bad (Vinu)
	{ 106542, 18, 1895, 1896 }, -- Help a Whelp (Wounded Azurewing Whelpling)

	-- Dalaran
	{ 107489, 17, 1904, 1905, 1906 }, -- Fight Night: Amalia
	{ 99210, 17, 1800, 1801, 1799 }, -- Fight Night: Bodhi Sunwayver
	{ 99742, 17, 1815 }, -- Fight Night: Heliosus
	{ 99182, 17, 1795, 1797, 1796 }, -- Fight Night: Sir Galveston
	{ 105241, 17, 1855 }, -- Fight Night: Rats! (Splint Jr.)
	{ 105840, 17, 1880 }, -- Fight Night: Stitches Jr. Jr.
	{ 97804, 17, 1748, 1746, 1745 }, -- Fight Night: Tiffany Nelson

	-- Highmountain (16)
	{ 99077, 16, 1790, 1791, 1792 }, -- Training with Bredda (Bredda Tenderhide)
	{ 99150, 16, 1798, 1793, 1794 }, -- Tiny Poacher, Tiny Animals (Grixis Tinypop)
	{ 104782, 16, 1843 }, -- Wildlife Protection Force (Hungry Icefang)
	-- MISSING: "It's Illid... Wait"
	{ 104553, 16, 1842, 1841, 1840 }, -- Snail Fight (Odrogg)
	{ 98572, 16, 1811 }, -- Rocko Needs a Shave (Rocko)

	-- Stormheim (15)
	{ 105842, 15, 1882 }, -- All Howl, No Bite (Chromadon)
--	{ 105455, 15, }, -- Jarrun's Ladder (Trapper Jarrun) MISSING: opponent pets
	{ 99878, 15, 1816, 1817, 1818 }, -- Oh, Ominitron (need npcID for Mini Magmatron)
	{ 98270, 15, 1770, 1772, 1771 }, -- My Beast's Bidding (Robert Craig)
	{ 105512, 15, 1871, 1872 }, -- All Pets Go to Heaven (Envoy of the Hunt)
	{ 105387, 15, 1867 }, -- Beasts of Burden (Andurs)
	{ 105386, 15, 1866 }, -- Beasts of Burden (Rydyr)

	-- Suramar (14)
	-- MISSING: "The Master of Pets"
	{ 105323, 14, 1860, 1861, 1862 }, -- Clear the Catacombs (Ancient Catacomb Eggs)
--	{ 105674, 14, }, -- Chopped (Varenne) MISSING: opponent pets
	{ 97709, 14, 1742 }, -- Flummoxed (Master Tamer Flummox) MISSING: speciesID for Master Tamer Flummox
	{ 105779, 14, 1877, 1878, 1879 }, -- Threads of Fate (Felsoul Seer)
	{ 105352, 14, 1863, 1864, 1865 }, -- Mana Tap (Surging Mana Crystal)

	-- Val'sharah (13)
	{ 99035, 13, 1789, 1787, 1788 }, -- Training with Durian (Durian Strongfruit)
	{ 105093, 13, 1851, 1852, 1853 }, -- Only Pets can Prevent Forest Fires (Fragment of Fire) Cackling Flame, Devouring Blaze, Living Coals
	{ 104992, 13, 1849 }, -- Meet The Maw (The Maw)
	{ 105009, 13, 1850 }, -- Stand Up to Bullies (Thistleleaf Bully)
	{ 97511, 13, 1734 }, -- Wildlife Conservationist (Shimmering Aquafly)
	{ 97547, 13, 1737 }, -- Wildlife Conservationist (Vale Flitter)
	{ 97559, 13, 1739 }, -- Wildlife Conservationist (Spring Strider)
	{ 104970, 13, 1847, 1846, 1848 }, -- Dealing with Satyrs (Xorvasc) Trixy, Globs, Nightmare Sprout
}

-- table of npcID's and the npcID they should actually refer to
-- GetUnitNameandID swaps these npcIDs for their redirected npcIDs, unless a team is already saved
rematch.notableRedirects = {

	[105353] = 105352, -- Font of Mana -> Surging Mana Crystal
	[105356] = 105352, -- Seed of Mana -> Surging Mana Crystal
	[105355] = 105352, -- Essence of Mana -> Surging Mana Crystal

	[106535] = 106542, -- Hungry Rat -> Wounded Azurewing Whelpling
	[106525] = 106542, -- Hungry Owl -> Wounded Azurewing Whelpling

	[106422] = 106476, -- Subjugated Tadpole -> Beguiling Orb
	[106424] = 106476, -- Confused Tadpole -> Beguiling Orb
	[106423] = 106476, -- Allured Tadpole -> Beguiling Orb

	[105318] = 105323, -- Catacomb Spider -> Ancient Catacomb Eggs
	[105319] = 105323, -- Catacomb Bat -> Ancient Catacomb Eggs
	[105320] = 105323, -- Catacomb Snake -> Ancient Catacomb Eggs

	-- the following all redirect to their respective Challenge Post in the WoD Menagerie
	[85678] = 85629, -- Tirs
	[85677] = 85629, -- Fiero
	[85681] = 85630, -- Rockbiter
	[85680] = 85630, -- Stonechewer
	[85679] = 85630, -- Acidtooth
	[85682] = 85632, -- Blingtron 4999b
	[85683] = 85632, -- Protectron 022481
	[85684] = 85632, -- Protectron 011803
	[85686] = 85634, -- Manos
	[85687] = 85634, -- Hanos
	[85688] = 85634, -- Fatos
	[85561] = 85622, -- Brutus
	[85655] = 85622, -- Rukus
	[85656] = 85517, -- Mr. Terrible
	[85657] = 85517, -- Carroteye
	[85658] = 85517, -- Sloppus
	[85661] = 85624, -- Queen Floret
	[85660] = 85624, -- King Floret
	[85662] = 85625, -- Kromli
	[85663] = 85625, -- Gromli
	[85664] = 85626, -- Grubbles
	[85666] = 85626, -- Scrags
	[85665] = 85626, -- Stings
	[85674] = 85627, -- Jahan
	[85675] = 85627, -- Samm
	[85676] = 85627, -- Archimedes
}


-- returns name of an npcID from a lookup table, or a tooltip scan if it's not in the table yet
function rematch:GetNameFromNpcID(npcID)
	if type(npcID)~="number" then
		return L["No Target"]
	end
	if rematch.notableNames[npcID] then
		return rematch.notableNames[npcID]
	end
	return rematch:GetNameFromNpcTooltip(npcID)
end

-- returns true if the npcID is within the notableNPCs table (used for team parsing)
function rematch:IsNotableNPC(npcID)
	for _,info in ipairs(rematch.notableNPCs) do
		if info[1]==npcID then
			return true
		end
	end
end

-- returns the name (if possible) from the given npcID by creating a fake tooltip of the npcID
-- if the creature isn't cached, it will return "NPC #"
-- if success passed, will return it if the name was valid
function rematch:GetNameFromNpcTooltip(npcID,success)
	local tooltip = RematchTooltipScan or CreateFrame("GameTooltip","RematchTooltipScan",nil,"GameTooltipTemplate")
	tooltip:SetOwner(rematch,"ANCHOR_NONE")
	tooltip:SetHyperlink(format("unit:Creature-0-0-0-0-%d-0000000000",npcID))
	if tooltip:NumLines()>0 then
		local name = RematchTooltipScanTextLeft1:GetText()
		if name and name:len()>0 then
			if success then
				return name,success -- if success parameter passed to function, send it back on success
			else
				return name -- otherwise just return the name (for parameter issues, can't have false for a second return)
			end
		end
	else
		return format("NPC %d",npcID)
	end
end

-- goes through and caches all notable NPCs; note that some NPCs will remain uncached until
-- the user interacts with a team (teams saved for wild pets or for pets around challenge posts)
function rematch:CacheNpcIDs()
	if not rematch.notablesCached then
		local failed
		-- cache notable NPCs
		for _,info in ipairs(rematch.notableNPCs) do
			if rematch.LEGION or info[2]<13 then -- skip legion notable NPCs unless on legion client
				local name,success = rematch:GetNameFromNpcTooltip(info[1],true)
				if success and not rematch.notableNames[info[1]] then
					rematch.notableNames[info[1]] = name
				elseif not success then
					failed = true
				end
			end
		end
		-- cache saved NPCs
		for key in pairs(RematchSaved) do
			if type(key)=="number" and not rematch.notableNames[key] then
				local name,success = rematch:GetNameFromNpcTooltip(key,true)
				if success then
					rematch.notableNames[key] = name
				else
					failed = true
				end
			end
		end
		if failed then
			C_Timer.After(0.5,rematch.CacheNpcIDs) -- some weren't cached, try again later
		else
			rematch.notablesCached = true
		end
	end
end


-- this returns the passed speciesIDs as a string of type icons 
function rematch:NotablePetsAsText(...)
	local pets = ""
	for i=1,select("#",...) do
		local speciesID = select(i,...)
		if speciesID then
			local name,icon,petType = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
			if petType then
				local petIcon = format("\124T%s:16:16:0:0:64:64:59:5:5:59\124t",icon)
				local typeIcon = rematch:PetTypeAsText(petType)
				pets = pets..format("%s %s %s",petIcon,typeIcon,name).."\n"
			end
		end
	end
	return (pets:gsub("\n$",""))
end

-- creates the "NotableNPCs" menu and its submenus
function rematch:CreateNpcMenus()
	if not rematch.notablesCached then -- not all notables cached, try again later
		C_Timer.After(1,rematch.CreateNpcMenus)
		return
	end
	local menu = {}
	-- create "NotableNPCs" to display each group
	for i=#rematch.notableGroups,0,-1 do
		if rematch.LEGION or i<13 then
			tinsert(menu,{text=rematch.notableGroups[i],subMenu=format("NotableSubMenu%02d",i)})
		end
	end
	tinsert(menu,{text=L["Help"], hidden=function() return RematchSettings.HideMenuHelp or rematch:GetMenuParent()~=RematchLoadoutPanel.Target.TargetButton end, stay=true, icon="Interface\\Common\\help-i", iconCoords={0.15,0.85,0.15,0.85}, tooltipTitle=L["Noteworthy Targets"], tooltipBody=L["These are noteworthy targets such as tamers and legendary pets.\n\nChoose one to view the pets you would battle.\n\nTargets with a \124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t already have a team saved."]})

	rematch:RegisterMenu("NotableNPCs",menu)
	-- now create "NotableSubMenu00" for each numbered group
	local menu = {} -- a new table to contain the submenus
	for index,info in pairs(rematch.notableNPCs) do
		if rematch.LEGION or info[2]<13 then
			local groupName = format("NotableSubMenu%02d",info[2])
			menu[groupName] = menu[groupName] or {}
			local name = rematch:GetNameFromNpcID(info[1])
			tinsert(menu[groupName],{text=name,npcID=info[1],icon=rematch.NpcHasTeamSaved,iconCoords={0,1,0,1},tooltipBody=rematch.NotableTooltipBody,func=rematch.PickNpcID})
		end
	end
	-- now register them all
	for groupName in pairs(menu) do
		rematch:RegisterMenu(groupName,menu[groupName])
	end
end

-- this is called from the npc menus when a npc is chosen
function rematch:PickNpcID()
	local npcID = type(self.npcID)=="function" and self.npcID(self) or self.npcID
	if npcID=="loaded" then
		npcID = RematchSettings.loadedTeam
	elseif npcID=="target" then
		npcID = rematch.recentTarget
	end
	if type(npcID)=="number" then
		rematch.recentTarget = npcID
		rematch.LoadoutPanel:UpdateTarget()
	else
		npcID = nil
	end
	if rematch:IsDialogOpen("SaveAs") then
		rematch:SetSaveAsTarget(npcID)
	end
end

function rematch:NpcHasTeamSaved()
	local npcID = type(self.npcID)=="function" and self.npcID(self) or self.npcID
	return RematchSaved[self.npcID] and "Interface\\RaidFrame\\ReadyCheck-Ready" or ""
end

function rematch:NotableTooltipBody()
	local npcID = type(self.npcID)=="function" and self.npcID(self) or self.npcID
	local index
	for _,info in ipairs(rematch.notableNPCs) do
		if info[1]==npcID then
			return rematch:NotablePetsAsText(info[3],info[4],info[5])
		end
	end
end
