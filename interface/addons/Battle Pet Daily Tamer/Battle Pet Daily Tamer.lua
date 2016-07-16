
local _,tamer = ...
local settings
BattlePetDailyTamer = tamer -- global for outside access

tamer.Paws = {} -- frame pool for paws
tamer.IncompleteObjectives = {} -- table of quest objects that are not complete
tamer.CompleteObjectives = {} -- table of quest objects that are complete

--[[	PawInfo describes the paws and the settings that control them.

		[1] = name as it should appear on map options menu/interface options panel
		[2] = name of savedvar key into BattlePetDailyTamerSettings
		[3] = default value of this setting
		[4] = icon
		[5] = red icon color
		[6] = green icon color
		[7] = blue icon color
]]
tamer.PawInfo = {
	{"Pet Reward Dailies","TrackSatchels",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.5,1.0,0.25},
	{"Normal Dailies","TrackNonSatchels",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.5,0.85,1.0},
	{"Legendary","TrackFables",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",1.0,0.5,0},
	{"Completed Dailies","TrackCompleted",false,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.75,0.75,0.75},
	{"On Flight Maps Too","TaxiPaws",false,"Interface\\TaxiFrame\\UI-Taxi-Icon-White",1.0,1.0,1.0},
	{"Stable Masters","StableMasters",false,"Interface\\Minimap\\Tracking\\Stablemaster",1.0,1.0,1.0},
}

--[[	DailyInfo describes the dailies. It's indexed by the questID of each daily quest.

	[questID] = {
		[1] = name of the tamer
		[2] = more detail about daily ("Darkmoon Faire", "Beasts of Fable Book II", etc)
		[3] = mapID
		[4] = mapX zone-level x map coordinate
		[5] = mapY zone-level y map coordinate
		[6] = daily type, 1=satchel, 2=non-satchel, 3=legendary; this is an index to tamer.PawInfo above
		[7] = level of pets for this tamer
		[8] = pet type of tamer's first pet (1-10)
		[9] = pet type of tamer's second pet (1-10)
		[10] = pet type of tamer's third pet (1-10)
	}

	When a questID is Number1:Number2, Number1 is the questID and Number2 is the objective number.
]]
tamer.DailyInfo = {
	-- Satchel dailies (green paws)
	[31916]={"Lydia Accoste",nil,32,0.401,0.765,1,19,4,7,4},
	[31909]={"Stone Cold Trixxy",nil,281,0.656,0.645,1,19,3,8,2},
	[31926]={"Bloodknight Antari",nil,473,0.305,0.418,1,24,6,7,2},
	[31935]={"Major Payne",nil,492,0.774,0.196,1,25,8,10,7},
	[31971]={"Obalis",nil,720,0.566,0.420,1,25,5,3,8},
	[31955]={"Farmer Nishi",nil,807,0.461,0.437,1,25,8,7,7},
	[31991]={"Seeker Zusshi",nil,810,0.363,0.522,1,25,7,5,9},
	[31957]={"Wastewalker Shu",nil,858,0.551,0.376,1,25,9,8,7},
	[31953]={"Hyuna of the Shrines",nil,806,0.480,0.541,1,25,9,8,3},
	[31954]={"Mo'ruk",nil,857,0.622,0.459,1,25,3,9,8},
	[31958]={"Aki the Chosen",nil,811,0.313,0.741,1,25,5,2,9},
	[31956]={"Courageous Yon",nil,809,0.358,0.736,1,25,8,5,3},
	[32434]={"Burning Pandaren Spirit","Pandarian Spirits",810,0.571,0.421,1,25,7,2,3},
	[32441]={"Thundering Pandaren Spirit","Pandarian Spirits",811,0.673,0.144,1,25,7,6,8},
	[32439]={"Flowing Pandaren Spirit","Pandarian Spirits",858,0.611,0.875,1,25,7,9,5},
	[32440]={"Whispering Pandaren Spirit","Pandarian Spirits",806,0.289,0.360,1,25,7,2,3},
	[33222]={"Little Tommy Newcomer","Lil' Oondasta",951,0.346,0.604,2,25,8},
	[33137]={"Celestial Tournament",nil,951,0.347,0.596,1},
	-- Non-satchel dailies (blue paws)
	[31922]={"Nicki Tinytech",nil,465,0.643,0.493,2,20,10,10,10},
	[31923]={"Ras'an",nil,467,0.172,0.505,2,21,3,6,1},
	[31924]={"Narrok",nil,477,0.610,0.494,2,22,5,9,8},
	[31925]={"Morulu The Elder",nil,481,0.587,0.700,2,23,9,9,9},
	[31934]={"Gutretch",nil,496,0.132,0.668,2,25,8,8,5},
	[31931]={"Beegle Blastfuse",nil,491,0.286,0.339,2,25,3,3,9},
	[31932]={"Nearly Headless Jacob",nil,510,0.501,0.590,2,25,4,4,4},
	[31933]={"Okrut Dragonwaste",nil,488,0.590,0.771,2,25,2,4,4},
	[31972]={"Brok",nil,606,0.614,0.327,2,25,8,6,5},
	[31974]={"Goz Banefury",nil,700,0.566,0.568,2,25,7,6,8},
	[31973]={"Bordin Steadyfist",nil,640,0.499,0.570,2,25,7,5,7},
	-- Beasts of Fable (orange paws)
	["32604:1"]={"Ka'wi the Gorger","Beasts of Fable Book I",806,0.484,0.710,3,25,5},
	["32604:2"]={"Kafi","Beasts of Fable Book I",809,0.352,0.562,3,25,8},
	["32604:3"]={"Dos-Ryga","Beasts of Fable Book I",809,0.679,0.847,3,25,9},
	["32604:4"]={"Nitun","Beasts of Fable Book I",806,0.570,0.291,3,25,5},
	["32868:1"]={"Greyhoof","Beasts of Fable Book II",807,0.253,0.785,3,25,8},
	["32868:2"]={"Lucky Yi","Beasts of Fable Book II",807,0.405,0.437,3,25,5},
	["32868:3"]={"Skitterer Xi'a","Beasts of Fable Book II",857,0.362,0.373,3,25,9},
	["32869:1"]={"Gorespine","Beasts of Fable Book III",858,0.262,0.503,3,25,8},
	["32869:2"]={"No-No","Beasts of Fable Book III",811,0.110,0.709,3,25,9},
	["32869:3"]={"Ti'un the Wanderer","Beasts of Fable Book III",810,0.723,0.798,3,25,9},
	-- Draenor dailies (green paws)
	[37201]={"Cymre Brightblade",nil,949,0.511,0.706,1,25,4,6,10},
	[37205]={"Gargra",nil,941,0.686,0.648,1,25,8,8,8},
	[37206]={"Tarr the Terrible",nil,950,0.562,0.098,1,25,1,1,1},
	[37208]={"Taralune",nil,946,0.491,0.804,1,25,3,3,3},
	[37207]={"Vesharr",nil,948,0.463,0.453,1,25,3,10,3},
	[37203]={"Ashlei",nil,947,0.500,0.313,1,25,6,6,8},
	-- Darkmoon Faire
	[32175]={"Jeremy Feasel","Darkmoon Faire",823,0.479,0.625,1,25,6,8,10},
	[36471]={"Christoph VonFeasel","Darkmoon Faire",823,0.474,0.622,1,25,6,8,8},
	-- Tanaan Jungle
	[39160]={"Corrupted Thundertail",nil,945,0.530,0.652,3,25,8},
	[39170]={"Dreadwalker",nil,945,0.473,0.528,3,25,10},
	[39169]={"Vile Blood of Draenor",nil,945,0.440,0.457,3,25,6},
	[39171]={"Netherfist",nil,945,0.484,0.355,3,25,1},
	[39172]={"Skrillix",nil,945,0.486,0.313,3,25,1},
	[39165]={"Direflame",nil,945,0.577,0.374,3,25,7},
	[39173]={"Defiled Earth",nil,945,0.755,0.374,3,25,7},
	[39163]={"Felfly",nil,945,0.559,0.808,3,25,3},
	[39164]={"Tainted Maulclaw",nil,945,0.434,0.845,3,25,9},
	[39166]={"Mirecroak",nil,945,0.422,0.718,3,25,9},
	[39161]={"Chaos Pup",nil,945,0.250,0.762,3,25,8},
	[39162]={"Cursed Spirit",nil,945,0.314,0.381,3,25,4},
	[39157]={"Felsworn Sentry",nil,945,0.261,0.316,3,25,10},
	[39168]={"Bleakclaw",nil,945,0.160,0.447,3,25,3},
	[39167]={"Dark Gazer",nil,945,0.541,0.298,3,25,6},
}
-- faction-specific DailyInfo
tamer.AllianceDailyInfo = {
	[31693]={"Julia Stevens",nil,30,0.417,0.837,2,2,8,8},
	[31780]={"Old MacDonald",nil,39,0.609,0.185,2,3,3,10,5},
	[31781]={"Lindsay",nil,36,0.333,0.526,2,5,5,5,5},
	[31850]={"Eric Davidson",nil,34,0.199,0.446,2,7,8,8,8},
	[31852]={"Steven Lisbane",nil,37,0.460,0.404,2,9,8,8,6},
	[31851]={"Bill Buckler",nil,673,0.515,0.734,2,11,1,3,3},
	[31910]={"David Kosse",nil,26,0.630,0.546,2,13,8,5,6},
	[31911]={"Deiza Plaguehorn",nil,23,0.670,0.524,2,14,8,8,4},
	[31912]={"Kortas Darkhammer",nil,28,0.353,0.277,2,15,2,2,2},
	[31913]={"Everessa",nil,38,0.768,0.415,2,16,9,3,8},
	[31914]={"Durin Darkhammer",nil,29,0.255,0.475,2,17,3,5,7},
	[32604]={"Sara Finkleswitch","Beasts of Fable Book I",811,0.866,0.600,1},
	[32868]={"Sara Finkleswitch","Beasts of Fable Book II",811,0.866,0.600,1},
	[32869]={"Sara Finkleswitch","Beasts of Fable Book III",811,0.866,0.600,1},
}
tamer.HordeDailyInfo = {
	[31818]={"Zunta",nil,4,0.439,0.289,2,2,5,8},
	[31854]={"Analynn",nil,43,0.202,0.295,2,5,3,9,5},
	[31872]={"Merda Stronghoof",nil,101,0.571,0.457,2,9,7,9,5},
	[31862]={"Zonya the Sadist",nil,81,0.597,0.716,2,7,8,8,5},
	[31819]={"Dagra the Fierce",nil,11,0.586,0.531,2,3,8,8,5},
	[31871]={"Traitor Gluk",nil,121,0.597,0.496,2,13,2,5,8},
	[31904]={"Cassandra Kaboom",nil,607,0.396,0.791,2,11,10,10,10},
	[31908]={"Elena Flutterfly",nil,241,0.461,0.603,2,17,6,3,2},
	[31905]={"Grazzle the Great",nil,141,0.539,0.749,2,14,2,2,2},
	[31906]={"Kela Grimtotem",nil,61,0.319,0.329,2,15,8,5,5},
	[31907]={"Zoltan",nil,182,0.400,0.566,2,16,6,10,6},
	[32604]={"Gentle San","Beasts of Fable Book I",811,0.607,0.238,1},
	[32868]={"Gentle San","Beasts of Fable Book II",811,0.607,0.238,1},
	[32869]={"Gentle San","Beasts of Fable Book III",811,0.607,0.238,1},
}

-- these are quest IDs of dailies with objectives (so far just the Beasts of Fables)
tamer.QuestsWithObjectives = {32604,32868,32869}


-- for each of the data tables MapCoordinates, WorldCoordinates and DailyInfo,
-- merge the faction-specific data into the main table and then delete both
-- AllianceTableName and HordeTableName
do
	-- merges table t2 into t1, for merging Alliance/Horde tables into primary ones
	local function merge(t1,t2)
		for k,v in pairs(t2) do
			if type(v)=="table" and type(t1[k])=="table" then
				merge(t1[k], t2[k])
			else
				t1[k] = v
			end
		end
		return t1
	end

	-- go through the tables and merge faction-specific data with live data
	for _,data in pairs({"MapCoordinates","WorldCoordinates","DailyInfo"}) do
		local key = format("%s%s",(UnitFactionGroup("player")),data)
		if tamer[key] then
			merge(tamer[data],tamer[key])
		end
		tamer[format("%s%s","Alliance",data)] = nil -- and delete faction-specific tables
		tamer[format("%s%s","Horde",data)] = nil -- they're no longer needed
	end
end

--[[ Event Frame ]]

tamer.frame = CreateFrame("Frame")
tamer.frame:Hide()

tamer.frame:SetScript("OnEvent",function(self,event,...)
	if tamer[event] then
		tamer[event](self,...)
	end
end)
tamer.frame:RegisterEvent("PLAYER_LOGIN")

function tamer:PLAYER_LOGIN()
	BattlePetDailyTamerSettings = BattlePetDailyTamerSettings or {}
	tamer:InitializeSettings()
	tamer.frame:RegisterEvent("WORLD_MAP_UPDATE")
	tamer.frame:RegisterEvent("TAXIMAP_OPENED")

	OpenCalendar()
--	C_Timer.After(1,tamer.CheckDMF)
end

function tamer:CheckDMF()
  local _,_,day = CalendarGetDate()
	local faireActive
	for i=1,CalendarGetNumDayEvents(0,day) do
	  local texture = select(7,CalendarGetDayEvent(0,day,i))
	  if texture and texture:lower():match("darkmoonfaire") then
			faireActive = true
	  end
	end
	if not faireActive then -- faire not on calendar, remove its dailies
		tamer.DailyInfo[32175] = nil
		tamer.DailyInfo[36471] = nil
	end
end

function tamer:WORLD_MAP_UPDATE()
	if WorldMapFrame:IsVisible() then
		self:Show()
	end
end
-- WORLD_MAP_UPDATE can fire up to a 100 times when crossing zone boundries.
-- instead of reacting to every event, wait one frame after the events fire
tamer.frame:SetScript("OnUpdate",function(self)
	self:Hide()
	if tamer.CheckDMF then -- if we've not checked for DMF being up
		tamer.CheckDMF()
		tamer.CheckDMF = nil
	end
	tamer:UpdatePaws()
end)

function tamer:TAXIMAP_OPENED()
	tamer:UpdateTaxiPaws()
end

--[[ Paws ]]

-- returns the first available paw from the frame pool, or creates one if needed
function tamer:GetAvailablePaw(parent)
	for _,paw in ipairs(tamer.Paws) do
		if not paw:GetParent() then
			paw:SetParent(parent)
			return paw
		end
	end
	local paw = CreateFrame("Button",nil,parent)
	paw:SetSize(18,18)
	paw.texture = paw:CreateTexture(nil,"OVERLAY")
	paw.texture:SetAllPoints(true)
	paw.texture:SetTexture("Interface\\AddOns\\Battle Pet Daily Tamer\\paw")
	paw:SetScript("OnEnter",tamer.PawOnEnter)
	paw:SetScript("OnLeave",tamer.PawOnLeave)
	paw:SetScript("OnClick",tamer.PawOnClick)
	paw:RegisterForClicks("AnyUp")
	tinsert(tamer.Paws,paw)
	return paw
end

-- helper function to convert a variable number of pet type numbers (1=humanoid, 10=mechanical, etc) to a string of icons
local function petsAsText(...)
	local txt=""
	for i=1,select("#",...) do
		local petType = PET_TYPE_SUFFIX[select(i,...)]
		txt=txt..(petType and format("\124TInterface\\PetBattles\\PetIcon-%s:20:20:0:0:128:256:102:63:129:168\124t",petType) or "")
	end
	return txt
end

-- onenter of paws show a tooltip describing the daily
function tamer:PawOnEnter()
	local info = tamer.DailyInfo[self.questID]
	if info then
		if not tamer.tooltip then -- need our own tooltip since GameTooltip is parented to UIParent (which is not always up with map)
			tamer.tooltip = CreateFrame("GameTooltip","BattlePetDailyTamerTooltip",nil,"GameTooltipTemplate")
			tamer.tooltip:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", insets={left=3,right=3,top=3,bottom=3}, tileSize=16, tile=true, edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=16})
			tamer.tooltip:SetBackdropColor(0,0,0,1)
		end
		local parent = self:GetParent()
		parent = parent==WorldMapButton and WorldMapFrame or parent
		tamer.tooltip:SetParent(parent)
		tamer.tooltip:SetFrameStrata("TOOLTIP")
		tamer.tooltip:SetOwner(self,"ANCHOR_RIGHT")
		tamer.tooltip:AddLine(info[1]) -- add name to tooltip
		if info[2] then
			tamer.tooltip:AddLine(info[2],0.85,0.85,0.85) -- add extra info ("Darkmoon Faire", "Beasts of Fables Book II", etc)
		end
		if info[7] then
			tamer.tooltip:AddLine(format("%s level %d",petsAsText(info[8],info[9],info[10]),info[7]),0.85,0.85,0.85) -- add pets and their level
		end
		-- add reward
		tamer.tooltip:Show()
	end
end

function tamer:PawOnLeave()
	if tamer.tooltip then
		tamer.tooltip:Hide()
	end
end

function tamer:PawOnClick(button)
	if button=="RightButton" then
		if IsControlKeyDown() and IsAddOnLoaded("TomTom") then -- ctrl+right click sets TomTom waypoint if addon enabled
			local info = tamer.DailyInfo[self.questID]
			if info then
				TomTom:AddMFWaypoint(info[3],nil,info[4],info[5],{title=info[1]})
			end
		elseif GetCurrentMapAreaID()==823 then -- if we're looking at the darkmoon faire
			SetMapZoom(0,0) -- zoom out to azeroth map
		else
			WorldMapZoomOutButton_OnClick() -- zoom out on paw right-click
		end
	elseif self:GetParent()==WorldMapButton and self.questID then
		local info = tamer.DailyInfo[self.questID]
		if info then
			SetMapByID(info[3])
		end
	end
end

-- returns a paw repurposed for the questID; a nil questID means it's a stable
function tamer:GetPaw(questID,forTaxi)
	local paw = tamer:GetAvailablePaw(forTaxi and TaxiRouteMap or WorldMapButton)
	local pawSize = forTaxi and 16 or (1-WorldMapButton:GetEffectiveScale())*10+18
	paw:SetSize(pawSize,pawSize)
	paw:SetFrameLevel(forTaxi and TaxiRouteMap:GetFrameLevel()+1 or WorldMapButton:GetFrameLevel()+8)

	if questID then -- an actual paw for a questID
		local dailyInfo = tamer.DailyInfo[questID]
		if dailyInfo then
			paw.texture:SetTexture("Interface\\AddOns\\Battle Pet Daily Tamer\\paw")
			paw:SetHighlightTexture("Interface\\AddOns\\Battle Pet Daily Tamer\\paw")
			paw:EnableMouse(true)
			paw.questID = questID
			local pawInfo = tamer.PawInfo[dailyInfo[6]]
			if (type(questID)=="string" and tamer.CompleteObjectives[questID]) or (type(questID)=="number" and IsQuestFlaggedCompleted(questID)) then
				paw.texture:SetVertexColor(0.75,0.75,0.75)
			else
				paw.texture:SetVertexColor(pawInfo[5],pawInfo[6],pawInfo[7])
			end
		else
			return nil -- this is not a valid daily, return nothing/no paw
		end
	else -- no questID, this is a stable
		paw.texture:SetTexture("Interface\\Minimap\\Tracking\\StableMaster")
		paw.texture:SetVertexColor(1,1,1,1)
		paw:SetHighlightTexture(nil)
		paw:EnableMouse(false)
		paw.questID = nil
	end

	return paw
end

-- this function is a mirror of default's GetWorldLocFromMapPos
-- takes world coordinates and converts them to current map's coordinates
function tamer:GetMapPosFromWorldLoc(y,x)
  local _,left,top,right,bottom = GetCurrentMapZone()
	-- the x-axis is flipped, left and right could be called maxX and minX respectively
  if left and x<left and x>right and y>bottom and y<top then
		local mapX = (x-left)/(right-left)
		local mapY = 1-(y-bottom)/(top-bottom)
		if mapX>0.05 and mapX<0.95 and mapY>0.05 and mapY<0.95 then -- only if they're more than 5% from edge
			return mapX,mapY
		end
  end
end

-- places a paw on the regular map, or the taxi if forTaxi is true, used in UpdatePaws
function tamer:PlacePaw(questID,forTaxi,mapX,mapY,mapWidth,mapHeight)
	local button = tamer:GetPaw(questID,forTaxi)
	if not forTaxi then
		button:SetPoint("CENTER",WorldMapButton,"TOPLEFT",mapX*mapWidth,mapY*mapHeight*-1)
	else
		local _,_,xoff,yoff = tamer:ConvertMapToTaxi(mapX,mapY)
		button:SetPoint("CENTER",TaxiRouteMap,"TOPLEFT",xoff,yoff)
	end
	button:Show()
end

-- the heart of the addon: place paws on the map
function tamer:UpdatePaws(forTaxi)

	-- hide any existing paws
	for _,paw in ipairs(tamer.Paws) do
		local taxiPaw = paw:GetParent()==TaxiRouteMap
		if (forTaxi and taxiPaw) or (not forTaxi and not taxiPaw) then
			paw:Hide()
			paw:SetParent(nil)
		end
	end

	local currentMapID = max(0,(GetCurrentMapAreaID()))

	if settings.HideDailies or (GetCurrentMapContinent()==-1 and currentMapID~=823) or GetCurrentMapDungeonLevel()~=0 then
		return -- leave if dailies are hidden or we're looking at cosmic map (and not DMF which is on cosmic continent)
	end

	-- populate tamer.IncompleteObjectives with quest:objectives that are not done
	wipe(tamer.IncompleteObjectives)
	wipe(tamer.CompleteObjectives)
	if settings.TrackFables then
		for _,questID in ipairs(tamer.QuestsWithObjectives) do
			local quest = GetQuestLogIndexByID(questID)
			for i=1,GetNumQuestLeaderBoards(quest) do
				if not select(3,GetQuestLogLeaderBoard(i,quest)) then
					tamer.IncompleteObjectives[questID..":"..i] = 1
				else
					tamer.CompleteObjectives[questID..":"..i] = 1
				end
			end
		end
	end

	local mapWidth = WorldMapButton:GetWidth()
	local mapHeight = WorldMapButton:GetHeight()
	local continent = GetCurrentMapContinent()

	if tamer.WorldCoordinates[continent] then
		-- if WorldCoordinates known for this continent, go through the continent's dailies and
		-- find dailies that would appear on the current map
		for questID,coords in pairs(tamer.WorldCoordinates[continent]) do
			if tamer.DailyInfo[questID] and tamer:PawNeedsShown(questID) then
				local x,y = tamer:GetMapPosFromWorldLoc(coords[1],coords[2])
				if x then
					tamer:PlacePaw(questID,forTaxi,x,y,mapWidth,mapHeight)
				end
			end
		end
	elseif tamer.MapCoordinates[currentMapID] then
		-- if no WorldCoordinates known, and this mapID has a MapCoordinates, use the old-style
		-- map-specific coordinates
		for questID,coords in pairs(tamer.MapCoordinates[currentMapID]) do
			if tamer.DailyInfo[questID] and tamer:PawNeedsShown(questID) then
				tamer:PlacePaw(questID,forTaxi,coords[1],coords[2],mapWidth,mapHeight)
			end
		end
	end

	-- and for stables too
	if settings.StableMasters then
		local stable = tamer.Stables[currentMapID]
		if stable then
			for i=1,#stable do
				local button = tamer:GetPaw()
				button:SetPoint("CENTER",WorldMapButton,"TOPLEFT",(stable[i][1]/1000)*mapWidth,(stable[i][2]/1000)*mapHeight*-1)
				button:Show()
			end
		end
	end

end

-- returns true if the questID should be put on the map
function tamer:PawNeedsShown(questID)
	local dailyInfo = tamer.DailyInfo[questID]
	if dailyInfo then
		local pawInfo = tamer.PawInfo[dailyInfo[6]]
		if pawInfo then
			if type(questID)=="string" then -- this is a "1234:567" questID, a quest with objectives
				if tamer.IncompleteObjectives[questID] or (settings.TrackCompleted and tamer.CompleteObjectives[questID]) then
					return settings[pawInfo[2]]
				end
			elseif not IsQuestFlaggedCompleted(questID) or settings.TrackCompleted then -- this is a normal questID
				return settings[pawInfo[2]]
			end
		end
	end
end

--[[ Taxi Support ]]

tamer.taxiAdjustments = {
  -- The taxi only displays a part of the world map for each continent.
  -- These numbers (tweaked from Homing Digeon by Wobin) are used to
  -- translate a point on the world map to each continent's taxi map
  [1] = { xratio=1.5, yratio=1, xoff=0, yoff=-5 }, -- Kalimdor
  [2] = { xratio=1.4, yratio=.95, xoff=5, yoff=5 }, -- Eastern Kingdom
  [3] = { xratio=1.4, yratio=1, xoff=10, yoff=5 }, -- Outlands
  [4] = { xratio=1.2, yratio=0.75, xoff=15, yoff=-25 }, -- Northrend
  [5] = { xratio=1.0, yratio=1.0, xoff=0, yoff=0 }, -- Maelstrom
  [6] = { xratio=1.3, yratio=0.875, xoff=-10, yoff=0 }, -- Pandaria
  [7] = { xratio=1.35, yratio=0.9, xoff=36, yoff=0 }, -- Draenor
}

-- takes world coordinates and returns taxi coordinates, taxi SetPoint offsets
-- world coordinates must be from current continent's zoom level
function tamer:ConvertMapToTaxi(wx,wy)
  local magic = tamer.taxiAdjustments[GetCurrentMapContinent()]
  local tcx, tcy = TaxiRouteMap:GetSize()
  local tx = tcx/2-tcx*magic.xratio*(.5-wx)+magic.xoff
  local ty = -tcy/2+tcy*magic.yratio*(.5-wy)-magic.yoff
  return tx/tcx,1+ty/tcy,tx,ty
end

function tamer:UpdateTaxiPaws()
	if not TaxiRouteMap:IsVisible() then
		return
	elseif settings.TaxiPaws then
		-- change map to continent view of the player's current map area
		-- taxi maps look at the whole continent
		tamer.frame:UnregisterEvent("WORLD_MAP_UPDATE")
		local userMap = GetCurrentMapAreaID()
		SetMapToCurrentZone()
	  SetMapZoom(GetCurrentMapContinent())
		tamer:UpdatePaws(true)
		SetMapByID(userMap)
		tamer.frame:RegisterEvent("WORLD_MAP_UPDATE")
		-- bump taxi nodes higher so no paws overlap them (paws should always be beneath taxi nodes)
		local nodeFrameLevel = TaxiRouteMap:GetFrameLevel()+2
		for i=1,NumTaxiNodes() do
			_G["TaxiButton"..i]:SetFrameLevel(nodeFrameLevel)
		end
	else -- no taxi paws, hide all paws
		for i=1,#tamer.Paws do
			if tamer.Paws[i]:GetParent()==TaxiRouteMap then
				tamer.Paws[i]:Hide()
				tamer.Paws[i]:SetParent(nil)
			end
		end
	end
end

--[[ Settings

	Settings can be changed two ways:

	1. Through the "Show Pet Tamer" menu in the default map options. This addon hooks
		 the dropdown's menu to add its settings as a submenu.
	2. From the Interface Options Panel, for cases when addons (like PetTracker) completely
		 replace the default menu.
]]

function tamer:InitializeSettings()
	settings = BattlePetDailyTamerSettings
	-- hook the default "Show Pet Tamers" dropdown
	tamer.old_WorldMapShowDropDown_Initialize = WorldMapTrackingOptionsDropDown_Initialize
	WorldMapTrackingOptionsDropDown_Initialize = tamer.new_WorldMapShowDropDown_Initialize
	UIDropDownMenu_Initialize(WorldMapFrameDropDown, WorldMapTrackingOptionsDropDown_Initialize, "MENU")
	-- set default settings if none defined yet
	for _,detail in pairs(tamer.PawInfo) do
		if settings[detail[2]]==nil then
			settings[detail[2]] = detail[3] -- give it a default value
		end
	end
	SetCVar("showTamers","0") -- turn off default paws
	tamer:AddInterfaceOptionsPanel() -- add options panel as additional place to change settings
end

-- this is a pre-hook of the original worldmap dropdown menu
function tamer.new_WorldMapShowDropDown_Initialize(self,level,menuList)
	if level==2 and UIDROPDOWNMENU_MENU_VALUE=="tamers" then -- this addon's submenu
    local info = UIDropDownMenu_CreateInfo()
    info.isNotRadio = true
    info.keepShownOnClick = 1
		for i=1,#tamer.PawInfo do
			info.text = tamer.PawInfo[i][1]
			info.checked = settings[tamer.PawInfo[i][2]]
			info.func = tamer.MenuButtonOnClick
			info.arg1 = tamer.PawInfo[i][2]
			info.icon = tamer.PawInfo[i][4]
			UIDropDownMenu_AddButton(info,2)
			_G["DropDownList2Button"..i.."Icon"]:SetVertexColor(tamer.PawInfo[i][5],tamer.PawInfo[i][6],tamer.PawInfo[i][7])
		end
	else -- this is not our tamer submenu
    tamer.old_WorldMapShowDropDown_Initialize(self,level,menuList) -- run old one
		if level==1 then -- if first level, look for the tamer menu item and make it expandable to our menu
		  local index, button, buttonName = 1
		  repeat
		    buttonName = "DropDownList1Button"..index
		    button = _G[buttonName]
		    if button and button.value=="tamers" then
					button.hasArrow = true -- make the Show Pet Tamers have a sub-menu
		      button.func = tamer.MenuParentOnClick
					button.checked = not settings.HideDailies
					_G[buttonName.."ExpandArrow"]:Show()
					if settings.HideDailies then
						_G[buttonName.."Check"]:Hide()
						_G[buttonName.."UnCheck"]:Show()
					else
						_G[buttonName.."Check"]:Show()
						_G[buttonName.."UnCheck"]:Hide()
					end
					return
		    end
		    index = index+1
		  until not button
	  end
	end
end

-- when "Show Pet Tamers" clicked to turn them all on/off
function tamer:MenuParentOnClick(_,_,checked)
	settings.HideDailies = not checked
	tamer:UpdatePaws()
	tamer:UpdateTaxiPaws()
end

-- when one of the sub-menu buttons clicked
function tamer:MenuButtonOnClick(var,_,checked)
	settings[var] = checked
	tamer:UpdatePaws()
	tamer:UpdateTaxiPaws()
end

--[[ Interface Options Panel ]]

-- PetTracker (and maybe others) removes the default map menu for its own menu
-- so this addon's options via the default map aren't accessable when they run.
-- This function adds the options to the interface options panel for those cases.
function tamer:AddInterfaceOptionsPanel()
	tamer.opt = CreateFrame("Frame",nil,InterfaceOptionsFramePanelContainer)
	tamer.opt:Hide()

	local title = tamer.opt:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	title:SetPoint("TOPLEFT",16,-16)
	title:SetText("Battle Pet Daily Tamer")
	local version = tamer.opt:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
	version:SetPoint("BOTTOMLEFT",title,"BOTTOMRIGHT",4,0)
	version:SetText("version "..GetAddOnMetadata("Battle Pet Daily Tamer","Version"))
	local desc = tamer.opt:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	desc:SetSize(600,40)
	desc:SetPoint("TOPLEFT",title,"BOTTOMLEFT",0,-8)
	desc:SetJustifyH("LEFT")
	desc:SetJustifyV("TOP")
	desc:SetText("This addon puts a paw on the world map to mark daily battle pet tamers you have not completed for the day.")

	if IsAddOnLoaded("TomTom") then
		local tomtom = tamer.opt:CreateFontString(nil,"ARTWORK","GameFontHighlight")
		tomtom:SetSize(550,40)
		tomtom:SetPoint("TOPLEFT",title,"BOTTOMLEFT",25,-240)
		tomtom:SetJustifyH("LEFT")
		tomtom:SetText("You have the addon TomTom enabled. <Ctrl>+Right-Click a paw on the world map to set a TomTom waypoint to that paw.")
	end

	local function createCheck(index,text,icon,r,g,b,anchorPoint,relativeTo,relativePoint,xoff,yoff)
		local check = CreateFrame("CheckButton",nil,tamer.opt,"UICheckButtonTemplate")
		check.text:SetText(text)
		check.text:SetFontObject("GameFontNormal")
		check:SetPoint(anchorPoint,relativeTo,relativePoint,xoff,yoff)
		if r then -- if r,g,b (or direct icon path) defined, this setting wants an icon
			check.icon = check:CreateTexture(nil,"ARTWORK")
			check.icon:SetSize(20,20)
			check.icon:SetPoint("LEFT",check.text,"RIGHT",4,0)
			check.icon:SetTexture(icon)
			check.icon:SetVertexColor(r,g,b)
		end
		check:SetScript("OnClick",tamer.InterfacePanelCheckOnClick)
		check:SetID(index)
		return check
	end

	tamer.opt.checks = {}
	tamer.opt.checks[1] = createCheck(0,"Show Pet Tamers",nil,nil,nil,nil,"TOPLEFT",desc,"BOTTOMLEFT",16,-8)
	for i=1,#tamer.PawInfo do
		local detail = tamer.PawInfo[i]
		tamer.opt.checks[i+1] = createCheck(i,detail[1],detail[4],detail[5],detail[6],detail[7],"TOPLEFT",tamer.opt.checks[1],"BOTTOMLEFT",20,(i-1)*-28+6)
	end

	tamer.opt.name = "Battle Pet Daily Tamer"
	tamer.opt.refresh = tamer.InterfacePanelRefresh
	InterfaceOptions_AddCategory(tamer.opt)
end

-- onclick for the interface panel checkbuttons
function tamer:InterfacePanelCheckOnClick()
	if self:GetID()==0 then -- this is the main switch
		settings.HideDailies = not self:GetChecked()
	else
		settings[tamer.PawInfo[self:GetID()][2]] = self:GetChecked() or false
	end
	tamer:InterfacePanelRefresh()
end

-- refresh for the interface panel business
function tamer:InterfacePanelRefresh()
	for i=1,#tamer.opt.checks do
		local check = tamer.opt.checks[i]
		if check:GetID()==0 then -- this is the main switch
			check:SetChecked(not settings.HideDailies)
		else
			check:SetChecked(settings[tamer.PawInfo[check:GetID()][2]])
			if settings.HideDailies then
				check:Disable()
				check.text:SetTextColor(.5,.5,.5)
			else
				check:Enable()
				check.text:SetTextColor(1,.82,0)
			end
		end
	end
end
