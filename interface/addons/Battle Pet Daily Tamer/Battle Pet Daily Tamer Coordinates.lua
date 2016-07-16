--[[
	These are the coordinates for the Battle Pet Daily Tamer paws.

	The primary coordinate system is the "WorldLoc" coordinates that are also
	used by UnitPosition and GetWorldLocFromMapPos.  These are translated
	to map coordinates and grouped by continent.

	In the cases when the world coordinates can't be used (especially for
	Azeroth overview map) then the MapCoordinates are used, which have
	the coordinate for all paws in each affected mapID.

	When a key is "number:number", it means the first number is a questID with multiple parts,
	the second number is the numbered objective of the quest.
]]

local _,tamer = ...

local LEGION = select(4,GetBuildInfo())>=70000

-- These are world(continent) coordinates instead of individual zone coordinates.
-- The function GetMapPosFromWorldLoc converts these to map coordinates based on
-- the zone boundries from GetCurrentMapZone.
tamer.WorldCoordinates = {
	[1] = { -- Kalimdor
		[31971] = { -9763.41602, -1063.99585 }, -- Obalis
		[31909] = { 6149.25000, -5026.06689 }, -- Stone Cold Trixxy
		[31972] = { 5270.01416, -3536.10840 }, -- Brok
	},
	[2] = { -- Eastern Kingdom
		[31974] = { -4152.53320, -5420.79150 }, -- Goz Banefury
		[31916] = { -11141.66602, -1835.83325 }, -- Lydia Accoste
	},
	[3] = { -- Outland
		[31922] = { -216.51880, 2218.75610 }, -- Nicki Tinytech
		[31923] = { 242.61462, 8610.34180 }, -- Ras'an
		[31924] = { -1777.89990, 6925.58301 }, -- Narrok
		[31925] = { -2083.50000, 5368.20020 }, -- Morulu The Elder
		[31926] = { -3480.58325, 2547.50000 }, -- Bloodknight Antari
	},
	[4] = { -- Northrend
		[31934] = { 5444.86621, -1259.17505 }, -- Gutretch
		[31935] = { 8607.55762, 590.12500 }, -- Major Payne
		[31931] = { 1750.07288, -3127.02490 }, -- Beegle Blastfuse
		[31932] = { 5431.47900, 79.56885 }, -- Nearly Headless Jacob
		[31933] = { 2691.78101, 318.16699 }, -- Okrut Dragonwaste
	},
	[5] = { -- Maelstrom
		[31973] = { 857.83325, 507.18311 }, -- Bordin Steadyfist
	},
	[6] = { -- Pandaria
		[31955] = { -47.65051, 869.74158 }, -- Farmer Nishi
		["32869:3"] = { 1503.73071, 2929.30713 }, -- Ti'un the Wanderer
		[31956] = { 2547.48315, 2599.09961 }, -- Courageous Yon
		[33222] = { -732.74603, -4913.56592 }, -- Little Tommy Newcomer
		[31957] = { 74.81665, 3190.58521 }, -- Wastewalker Shu
		[31958] = { 697.29309, 1689.17773 }, -- Aki the Chosen
		[32439] = { -1705.99023, 2869.46021 }, -- Flowing Pandaren Spirit
		[32440] = { 1976.58276, -566.10022 }, -- Whispering Pandaren Spirit
		[31991] = { 2559.50830, 4994.18506 }, -- Seeker Zusshi
		[33137] = { -720.93799, -4916.58984 }, -- Celestial Tournament
		["32868:3"] = { -1277.22852, 1248.79163 }, -- Skitterer Xi'a
		["32869:2"] = { 751.22571, 2202.00049 }, -- No-No
		["32868:1"] = { -959.08789, 1686.41650 }, -- Greyhoof
		["32869:1"] = { -378.52185, 4738.46094 }, -- Gorespine
		["32604:3"] = { 2084.66479, 592.42773 }, -- Dos-Ryga
		["32868:2"] = { -46.65613, 1088.71741 }, -- Lucky Yi
		["32604:1"] = { 348.97412, -1929.52612 }, -- Ka'wi the Gorger
		[32441] = { 1704.91687, 776.31628 }, -- Thundering Pandaren Spirit
		["32604:2"] = { 3274.94775, 2637.15039 }, -- Kafi
		[31953] = { 1134.17871, -1899.91675 }, -- Hyuna of the Shrines
		[32434] = { 2946.25415, 3799.48535 }, -- Burning Pandaren Spirit
		[31954] = { -1544.79102, 32.29150 }, -- Mo'ruk
		["32604:4"] = { 2296.97583, -2531.62939 }, -- Nitun
	},
	[7] = { -- Draenor
		[37206] = { 4551.96338, 6117.27734 }, -- Tarr the Terrible
		[37201] = { 5743.67871, 890.87549 }, -- Cymre Brightblade
		[37203] = { 1264.13892, -1083.52783 }, -- Ashlei
		[37205] = { 5634.64209, 3312.50439 }, -- Gargra
		[37207] = { -447.32690, 1875.76025 }, -- Vesharr
		[37208] = { 1234.73755, 2905.98291 }, -- Taralune
		[39160] = { 3651.500000, -1074.900024 }, -- Corrupted Thundertail
		[39170] = { 4085.100098, -776.100037 }, -- Dreadwalker
		[39169] = { 4333.000000, -603.299988 }, -- Vile Blood of Draenor
		[39171] = { 4692.700195, -831.200012 }, -- Netherfist
		[39172] = { 4839.100098, -841.000000 }, -- Skrillix
		[39165] = { 4625.899902, -1323.200073 }, -- Direflame
		[39173] = { 4625.899902, -2253.100098 }, -- Defiled Earth
		[39163] = { 3105.400146, -1226.500000 }, -- Felfly
		[39164] = { 2977.600098, -568.400024 }, -- Tainted Maulclaw
		[39166] = { 3419.800049, -508.399994 }, -- Mirecroak
		[39161] = { 3265.199951, 394.200012 }, -- Chaos Pup
		[39162] = { 4600.100098, 61.200001 }, -- Cursed Spirit
		[39157] = { 4827.500000, 336.000000 }, -- Felsworn Sentry
		[39168] = { 4366.700195, 868.400024 }, -- Bleakclaw
		[39167] = { 4889.100098, -1130.200073 }, -- Dark Gazer
	},
}
-- faction-specific WorldCoordinates
tamer.AllianceWorldCoordinates = {
	[2] = { -- Eastern Kingdom
		[31781] = { -9415.35840, -2334.56030 }, -- Lindsay
		[31913] = { -10229.67676, -4007.64990 }, -- Everessa
		[31851] = { -14448.00391, 76.22937 }, -- Bill Buckler
		[31910] = { 65.26672, -4000.50000 }, -- David Kosse
		[31914] = { -7982.91602, -1268.36450 }, -- Durin Darkhammer
		[31693] = { -9876.88867, 88.07922 }, -- Julia Stevens
		[31852] = { -12120.93262, -142.25012 }, -- Steven Lisbane
		[31911] = { 2295.91650, -4988.43750 }, -- Deiza Plaguehorn
		[31780] = { -9831.66699, 885.16650 }, -- Old MacDonald
		[31912] = { -6512.03760, -1110.54773 }, -- Kortas Darkhammer
		[31850] = { -10519.46582, 296.03333 }, -- Eric Davidson
	},
	[6] = { -- Pandaria
		[32604] = { 935.61896, 287.66138 }, -- Sara Finkleswitch
		[32868] = { 935.61896, 287.66138 }, -- Sara Finkleswitch
		[32869] = { 935.61896, 287.66138 }, -- Sara Finkleswitch
	}
}
tamer.HordeWorldCoordinates = {
	[1] = { -- Kalimdor
		[31871] = { -4664.79980, 1292.51660 }, -- Traitor Gluk
		[31905] = { -4654.83398, -3804.74976 }, -- Grazzle the Great
		[31872] = { -917.96454, 1666.21240 }, -- Merda Stronghoof
		[31906] = { -4931.73291, -1836.93311 }, -- Kela Grimtotem
		[31854] = { 3539.01025, 535.13318 }, -- Analynn
		[31908] = { 7563.29736, -2445.39160 }, -- Elena Flutterfly
		[31862] = { 587.89990, 379.78320 }, -- Zonya the Sadist
		[31907] = { 4949.91650, -627.08313 }, -- Zoltan
		[31904] = { -3704.69141, -1579.10010 }, -- Cassandra Kaboom
		[31818] = { 789.60822, -4283.71240 }, -- Zunta
		[31819] = { -223.97717, -3164.97534 }, -- Dagra the Fierce
	},
	[6] = { -- Pandaria
		[32604] = { 1547.01733, 944.17493 }, -- Gentle San
		[32868] = { 1547.01733, 944.17493 }, -- Gentle San
		[32869] = { 1547.01733, 944.17493 }, -- Gentle San
	},
}

-- these are map-specific coordinates for when we can't use WorldCoordinates
tamer.MapCoordinates = {
	[823] = { -- Darkmoon Faire
		[32175] = {0.47900,0.62500}, -- Jeremy Feasel
		[36471] = {0.47400,0.62200}, -- Christoph VonFeasel
	},
	[751] = { -- Maelstrom
		[31973] = {0.50000,0.35000}, -- Bordin Steadyfist
		},
	[0] = { -- Azeroth
		["32604:1"] = {0.57774,0.85923}, -- Ka'wi the Gorger
		["32604:2"] = {0.48868,0.77364}, -- Kafi
		["32604:3"] = {0.52855,0.80846}, -- Dos-Ryga
		["32604:4"] = {0.58948,0.80225}, -- Nitun
		["32868:1"] = {0.50722,0.89750}, -- Greyhoof
		["32868:2"] = {0.51888,0.87081}, -- Lucky Yi
		["32868:3"] = {0.51575,0.90681}, -- Skitterer Xi'a
		["32869:1"] = {0.44769,0.88052}, -- Gorespine
		["32869:2"] = {0.49716,0.84747}, -- No-No
		["32869:3"] = {0.48298,0.82545}, -- Ti'un the Wanderer
		[32175] = {0.59000,0.65000}, -- Jeremy Feasel
		[36471] = {0.59000,0.65000}, -- Christoph VonFeasel
	  [31973] = {0.50000,0.50000}, -- Bordin Steadyfist
	  [31955] = {0.52315,0.87084}, -- Farmer Nishi
	  [31956] = {0.48942,0.79443}, -- Courageous Yon
	  [31957] = {0.47788,0.86725}, -- Wastewalker Shu
	  [31958] = {0.50716,0.84904}, -- Aki the Chosen
	  [31971] = {0.19104,0.74519}, -- Obalis
	  [31909] = {0.25757,0.34435}, -- Stone Cold Trixxy
	  [31974] = {0.90430,0.52051}, -- Goz Banefury
	  [31916] = {0.84387,0.69723}, -- Lydia Accoste
	  [31991] = {0.44271,0.79457}, -- Seeker Zusshi
	  [32434] = {0.46601,0.78325}, -- Burning Pandaren Spirit
	  [31931] = {0.58560,0.25927}, -- Beegle Blastfuse
	  [31932] = {0.52849,0.16092}, -- Nearly Headless Jacob
	  [31933] = {0.52424,0.23411}, -- Okrut Dragonwaste
	  [31935] = {0.51939,0.07606}, -- Major Payne
	  [32440] = {0.55115,0.81162}, -- Whispering Pandaren Spirit
	  [32441] = {0.52497,0.81957}, -- Thundering Pandaren Spirit
	  [32439] = {0.48415,0.91935}, -- Flowing Pandaren Spirit
	  [31972] = {0.23255,0.36650}, -- Brok
	  [31953] = {0.57716,0.83626}, -- Hyuna of the Shrines
	  [31954] = {0.53948,0.91463}, -- Mo'ruk
	  [31934] = {0.55233,0.16056}, -- Gutretch
		[33222] = {0.63594,0.89088}, -- Little Tommy Newcomer
		[33137] = {0.63600,0.89054}, -- Celestial Tournament
  },
}

-- faction-specific MapCoordinates
tamer.AllianceMapCoordinates = {
	[0] = { -- Azeroth
	  [31693] = {0.81144,0.66525}, -- Julia Stevens
	  [31780] = {0.79800,0.66411}, -- Old MacDonald
	  [31781] = {0.85227,0.65358}, -- Lindsay
	  [31850] = {0.80793,0.68150}, -- Eric Davidson
	  [31852] = {0.81532,0.72199}, -- Steven Lisbane
	  [31851] = {0.81164,0.78083}, -- Bill Buckler
	  [31910] = {0.88036,0.41387}, -- David Kosse
	  [31911] = {0.89701,0.35747}, -- Deiza Plaguehorn
	  [31912] = {0.83164,0.58017}, -- Kortas Darkhammer
	  [31913] = {0.88048,0.67417}, -- Everessa
	  [31914] = {0.83430,0.61736}, -- Durin Darkhammer
		[32604] = {0.53450,0.84207}, -- Sara Finkleswitch
		[32868] = {0.53450,0.84207}, -- Sara Finkleswitch
		[32869] = {0.53450,0.84207}, -- Sara Finkleswitch
	},
}
tamer.HordeMapCoordinates = {
	[0] = { -- Azeroth
	  [31818] = {0.24511,0.47936}, -- Zunta
	  [31854] = {0.16418,0.41010}, -- Analynn
	  [31872] = {0.14519,0.52237}, -- Merda Stronghoof
	  [31862] = {0.16679,0.48444}, -- Zonya the Sadist
	  [31819] = {0.22632,0.50489}, -- Dagra the Fierce
	  [31871] = {0.15146,0.61676}, -- Traitor Gluk
	  [31904] = {0.19969,0.59257}, -- Cassandra Kaboom
	  [31908] = {0.21423,0.30873}, -- Elena Flutterfly
	  [31905] = {0.23706,0.61651}, -- Grazzle the Great
	  [31906] = {0.20402,0.62348}, -- Kela Grimtotem
	  [31907] = {0.18370,0.37456}, -- Zoltan
		[32604] = {0.52169,0.82419}, -- Gentle San
		[32868] = {0.52169,0.82419}, -- Gentle San
		[32869] = {0.52169,0.82419}, -- Gentle San
	},
}

if LEGION then
	-- Azeroth world map changed in Legion
	tamer.MapCoordinates[0] = {
		-- both factions
		["32604:1"] = {0.53070,0.87062}, -- Ka'wi the Gorger
		["32604:2"] = {0.44887,0.79198}, -- Kafi
		["32604:3"] = {0.48553,0.82399}, -- Dos-Ryga
		["32604:4"] = {0.54148,0.81827}, -- Nitun
		["32868:1"] = {0.46593,0.90577}, -- Greyhoof
		["32868:2"] = {0.47663,0.88127}, -- Lucky Yi
		["32868:3"] = {0.47375,0.91433}, -- Skitterer Xi'a
		["32869:1"] = {0.41122,0.89017}, -- Gorespine
		["32869:2"] = {0.45668,0.85979}, -- No-No
		["32869:3"] = {0.44365,0.83958}, -- Ti'un the Wanderer
		[32175] = {0.59000,0.65000}, -- Jeremy Feasel
		[36471] = {0.59000,0.65000}, -- Christoph VonFeasel
	  [31973] = {0.44000,0.46000}, -- Bordin Steadyfist
		[31955] = {0.48051,0.88128}, -- Farmer Nishi
		[31956] = {0.44961,0.81156}, -- Courageous Yon
		[31957] = {0.43897,0.87796}, -- Wastewalker Shu
		[31958] = {0.46586,0.86127}, -- Aki the Chosen
		[31971] = {0.19749,0.77819}, -- Obalis
		[31909] = {0.26048,0.39922}, -- Stone Cold Trixxy
		[31974] = {0.92159,0.56619}, -- Goz Banefury
		[31916] = {0.86523,0.73097}, -- Lydia Accoste
		[31991] = {0.40667,0.81121}, -- Seeker Zusshi
		[32434] = {0.42810,0.80083}, -- Burning Pandaren Spirit
		[31931] = {0.56037,0.24636}, -- Beegle Blastfuse
		[31932] = {0.50659,0.15373}, -- Nearly Headless Jacob
		[31933] = {0.50259,0.22264}, -- Okrut Dragonwaste
		[31935] = {0.49801,0.07381}, -- Major Payne
		[32440] = {0.50627,0.82691}, -- Whispering Pandaren Spirit
		[32441] = {0.48224,0.83416}, -- Thundering Pandaren Spirit
		[32439] = {0.44474,0.92586}, -- Flowing Pandaren Spirit
		[31972] = {0.23676,0.42014}, -- Brok
		[31953] = {0.53013,0.84960}, -- Hyuna of the Shrines
		[31954] = {0.49559,0.92152}, -- Mo'ruk
		[31934] = {0.52905,0.15340}, -- Gutretch
		[33222] = {0.58418,0.89970}, -- Little Tommy Newcomer
		[33137] = {0.58423,0.89939}, -- Celestial Tournament
	}
	tamer.AllianceMapCoordinates[0] = {
		[31693] = {0.83499,0.70114}, -- Julia Stevens
		[31780] = {0.82247,0.70009}, -- Old MacDonald
		[31781] = {0.87307,0.69027}, -- Lindsay
		[31850] = {0.83173,0.71631}, -- Eric Davidson
		[31852] = {0.83864,0.75410}, -- Steven Lisbane
		[31851] = {0.83518,0.80890}, -- Bill Buckler
		[31910] = {0.89927,0.46674}, -- David Kosse
		[31911] = {0.91479,0.41417}, -- Deiza Plaguehorn
		[31912] = {0.85385,0.62185}, -- Kortas Darkhammer
		[31913] = {0.89939,0.70948}, -- Everessa
		[31914] = {0.85635,0.65651}, -- Durin Darkhammer
		[32604] = {0.49098,0.85486}, -- Sara Finkleswitch
		[32868] = {0.49098,0.85486}, -- Sara Finkleswitch
		[32869] = {0.49098,0.85486}, -- Sara Finkleswitch
	}
	tamer.HordeMapCoordinates[0] = {
		[31818] = {0.24862,0.52682}, -- Zunta
		[31854] = {0.17214,0.46142}, -- Analynn
		[31872] = {0.15419,0.56751}, -- Merda Stronghoof
		[31862] = {0.17456,0.53165}, -- Zonya the Sadist
		[31819] = {0.23090,0.55094}, -- Dagra the Fierce
		[31871] = {0.16017,0.65680}, -- Traitor Gluk
		[31904] = {0.20571,0.63394}, -- Cassandra Kaboom
		[31908] = {0.21948,0.36550}, -- Elena Flutterfly
		[31905] = {0.24101,0.65651}, -- Grazzle the Great
		[31906] = {0.20979,0.66314}, -- Kela Grimtotem
		[31907] = {0.19055,0.42774}, -- Zoltan
		[32604] = {0.47927,0.83839}, -- Gentle San
		[32868] = {0.47927,0.83839}, -- Gentle San
		[32869] = {0.47927,0.83839}, -- Gentle San
	}
end

--[[

	Stable Coordinates

	Stables are only displayed on zone-level maps and have no quest or NPC associated with them.

]]
if UnitFactionGroup("player")=="Alliance" then
	tamer.Stables = {
	  [11] = {{676,742}}, -- Northern Barrens
	  [16] = {{400,490}}, -- Arathi Highlands
	  [17] = {{656,364},{210,566}}, -- Badlands
	  [19] = {{602,160},{460,854}}, -- Blasted Lands
	  [22] = {{472,318}}, -- Western Plaguelands
	  [26] = {{144,452},{664,450}}, -- The Hinterlands
	  [27] = {{540,510}}, -- Dun Morogh
	  [28] = {{406,686}}, -- Searing Gorge
	  [30] = {{428,658}}, -- Elwynn Forest
	  [34] = {{740,462}}, -- Duskwood
	  [35] = {{840,628},{346,480}}, -- Loch Modan
	  [36] = {{262,430}}, -- Redridge Mountains
	  [38] = {{286,336},{720,148}}, -- Swamp of Sorrows
	  [39] = {{530,530}}, -- Westfall
	  [40] = {{106,596},{576,402},{262,258}}, -- Wetlands
	  [41] = {{562,520}}, -- Teldrassil
	  [42] = {{504,192}}, -- Darkshore
	  [43] = {{364,504}}, -- Ashenvale
	  [81] = {{586,566},{398,322},{318,616}}, -- Stonetalon Mountains
	  [101] = {{570,496},{656,78}}, -- Desolace
	  [121] = {{468,456},{510,180}}, -- Feralas
	  [141] = {{658,454}}, -- Dustwallow Marsh
	  [161] = {{526,274}}, -- Tanaris
	  [182] = {{444,286},{616,254}}, -- Felwood
	  [261] = {{532,346}}, -- Silithus
	  [281] = {{586,502}}, -- Winterspring
	  [301] = {{670,376},{778,672}}, -- Stormwind City
	  [341] = {{690,846}}, -- Ironforge
	  [381] = {{436,296}}, -- Darnassus
	  [464] = {{490,498}}, -- Azuremyst Isle
	  [465] = {{544,626}}, -- Hellfire Peninsula
	  [467] = {{676,496},{788,642}}, -- Zangarmarsh
	  [471] = {{600,256}}, -- The Exodar
	  [473] = {{376,560}}, -- Shadowmoon Valley
	  [475] = {{360,646},{276,526}}, -- Blade's Edge Mountains
	  [476] = {{550,598}}, -- Bloodmyst Isle
	  [477] = {{558,746}}, -- Nagrand
	  [478] = {{568,538}}, -- Terokkar Forest
	  [479] = {{320,648}}, -- Netherstorm
	  [481] = {{566,796},{286,476}}, -- Shattrath City
	  [486] = {{584,686},{566,730},{570,190},{780,490}}, -- Borean Tundra
	  [488] = {{616,534},{288,560},{484,746},{774,508}}, -- Dragonblight
	  [490] = {{326,596},{590,264},{138,846}}, -- Grizzly Hills
	  [491] = {{606,160},{316,414},{586,630},{254,590}}, -- Howling Fjord
	  [492] = {{696,220},{442,224},{758,202},{718,224}}, -- Icecrown
	  [493] = {{272,596}}, -- Sholazar Basin
	  [495] = {{306,368},{286,744},{408,860}}, -- The Storm Peaks
	  [496] = {{590,576},{402,652}}, -- Zul'Drak
		[499] = {{502,354}}, -- Isle of Quel'Danas
	  [606] = {{632,230},{194,362},{418,450}}, -- Mount Hyjal
	  [607] = {{390,112},{660,468},{490,682}}, -- Southern Barrens
	  [614] = {{560,730}}, -- Abyssal Depths
	  [615] = {{490,576},{494,420}}, -- Shimmering Expanse
	  [640] = {{474,516}}, -- Deepholm
	  [673] = {{414,736}}, -- The Cape of Stranglethorn
	  [700] = {{556,148},{806,774},{602,580},{436,574},{486,296}}, -- Twilight Highlands
	  [720] = {{546,338},{270,76}}, -- Uldum
	  [806] = {{446,848},{464,438},{548,630}}, -- The Jade Forest
	  [807] = {{552,496}}, -- Valley of the Four Winds
	  [809] = {{422,692},{654,616}}, -- Kun-Lai Summit
	  [810] = {{714,576},{748,812},{500,714}}, -- Townlong Steppes
	  [811] = {{846,632},{360,752}}, -- Vale of Eternal Blossoms
	  [857] = {{672,322}}, -- Krasarang Wilds
	  [858] = {{536,324},{558,696}}, -- Dread Wastes
	  [873] = {{558,758}}, -- The Veiled Stair
	  [928] = {{632,738}}, -- Isle of Thunder
	  [951] = {{372,468}}, -- Timeless Isle
		[971] = {{288,385}}, -- Alliance Garrison
		[947] = {{252,070},{592,266}}, -- Shadowmoon Valley (Draenor)
		[949] = {{526,596}}, -- Gorgrond
		[948] = {{608,718}}, -- Spires of Arak
		[1009] = {{340,642}}, -- Stormshield
		[946] = {{694,212}}, -- Talador
	}
elseif UnitFactionGroup("player")=="Horde" then
	tamer.Stables = {
	  [4] = {{520,418}}, -- Durotar
	  [9] = {{470,596}}, -- Mulgore
	  [11] = {{566,398},{676,742},{490,576},{624,168}}, -- Northern Barrens
	  [16] = {{690,340}}, -- Arathi Highlands
	  [17] = {{656,364},{182,422}}, -- Badlands
	  [19] = {{416,128}}, -- Blasted Lands
	  [20] = {{618,520}}, -- Tirisfal Glades
	  [21] = {{446,208},{460,426}}, -- Silverpine Forest
	  [22] = {{472,318},{478,640}}, -- Western Plaguelands
	  [24] = {{596,648},{362,616},{568,468}}, -- Hillsbrad Foothills
	  [26] = {{790,796},{320,576}}, -- The Hinterlands
	  [28] = {{406,686}}, -- Searing Gorge
	  [37] = {{380,512}}, -- Northern Stranglethorn
	  [38] = {{472,552},{720,148}}, -- Swamp of Sorrows
	  [43] = {{386,424},{126,338},{732,606},{502,658}}, -- Ashenvale
	  [81] = {{662,640},{508,630}}, -- Stonetalon Mountains
	  [101] = {{248,688},{570,496}}, -- Desolace
	  [121] = {{516,480},{746,432},{414,156}}, -- Feralas
	  [161] = {{526,274}}, -- Tanaris
	  [181] = {{568,500}}, -- Azshara
	  [182] = {{444,286}}, -- Felwood
	  [261] = {{532,346}}, -- Silithus
	  [281] = {{586,502}}, -- Winterspring
	  [321] = {{408,806},{396,492},{626,356},{326,648}}, -- Orgrimmar
	  [362] = {{450,596}}, -- Thunder Bluff
	  [382] = {{678,386}}, -- Undercity
	  [462] = {{476,472}}, -- Eversong Woods
	  [463] = {{484,312}}, -- Ghostlands
	  [465] = {{544,410}}, -- Hellfire Peninsula
	  [467] = {{788,642},{318,498}}, -- Zangarmarsh
	  [473] = {{292,294}}, -- Shadowmoon Valley
	  [475] = {{536,532},{756,604},{276,526}}, -- Blade's Edge Mountains
	  [477] = {{568,408}}, -- Nagrand
	  [478] = {{494,446}}, -- Terokkar Forest
	  [479] = {{320,648}}, -- Netherstorm
	  [480] = {{834,304}}, -- Silvermoon City
	  [481] = {{566,796},{286,476}}, -- Shattrath City
	  [486] = {{498,106},{402,550},{770,372},{780,490}}, -- Borean Tundra
	  [488] = {{768,626},{616,534},{370,486},{484,746}}, -- Dragonblight
	  [490] = {{216,640},{138,848},{650,478}}, -- Grizzly Hills
	  [491] = {{494,110},{520,666},{790,308},{254,590}}, -- Howling Fjord
	  [492] = {{696,220},{442,224},{756,236},{718,224}}, -- Icecrown
	  [493] = {{272,596}}, -- Sholazar Basin
	  [495] = {{306,368},{408,860},{498,660},{674,502}}, -- The Storm Peaks
	  [496] = {{590,576},{402,652}}, -- Zul'Drak
	  [499] = {{502,354}}, -- Isle of Quel'Danas
	  [606] = {{632,230},{194,362},{418,450}}, -- Mount Hyjal
	  [607] = {{408,696},{440,336},{392,198}}, -- Southern Barrens
	  [614] = {{530,592}}, -- Abyssal Depths
	  [615] = {{514,626},{494,420}}, -- Shimmering Expanse
	  [640] = {{512,502}}, -- Deepholm
	  [673] = {{348,276},{414,736}}, -- The Cape of Stranglethorn
	  [700] = {{756,526},{756,168},{538,430},{452,764}}, -- Twilight Highlands
	  [720] = {{546,338},{270,76}}, -- Uldum
	  [806] = {{278,468},{464,438},{548,630},{286,130}}, -- The Jade Forest
	  [807] = {{552,496}}, -- Valley of the Four Winds
	  [809] = {{422,692},{654,616}}, -- Kun-Lai Summit
	  [810] = {{714,576},{748,812},{500,714}}, -- Townlong Steppes
	  [811] = {{360,752},{604,226}}, -- Vale of Eternal Blossoms
	  [857] = {{592,244}}, -- Krasarang Wilds
	  [858] = {{536,324},{558,696}}, -- Dread Wastes
	  [873] = {{558,758}}, -- The Veiled Stair
	  [928] = {{328,326}}, -- Isle of Thunder
	  [951] = {{372,468}}, -- Timeless Isle
		[976] = {{328,418}}, -- Horde Garrison
		[941] = {{220,562},{524,402},{388,520}}, -- Frostfire Ridge
		[949] = {{458,698}}, -- Gorgrond
		[948] = {{608,718}}, -- Spires of Arak
		[1011] = {{776,590}}, -- Warspear
		[946] = {{708,296}}, -- Talador
		[945] = {{598,456}}, -- Tanaan Jungle
	}
else
	tamer.Stables = {} -- no idea what faction you are!
end

