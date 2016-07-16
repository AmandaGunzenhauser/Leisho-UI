-------------------------------------------------------------------------------
--                 L  O  C  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

local addonName, L = ...;

local emptyTable = {};

local MAX_PET_LEVEL     = 25;
local MAX_LOAD_TRIES    = 10;
local TEAM_ICON_PATH    = "Interface\\Addons\\"..addonName.."\\textures\\";
local BATTLE_PET_PSEUDO = "BattlePet-0-P%011X"

-- Info for opponents
local opponentInfo =
{
  {id = 0, flags = 0,name = L["Any Opponent"], zoneId = 0, continentId = 0x0000, petId = {}},
  {id = 1, flags = 0,name = L["PvP Opponents"], zoneId = 0, continentId = 0x0000, petId = {}},
  {id = 63194, flags = 0,name = L["Steven Lisbane"], zoneId = 37, continentId = 0x0002, petId = {885, 884, 883}},
  {id = 64330, flags = 0,name = L["Julia Stevens"], zoneId = 30, continentId = 0x0002, petId = {873, 872}},
  {id = 65648, flags = 0,name = L["Old MacDonald"], zoneId = 39, continentId = 0x0002, petId = {876, 875, 874}},
  {id = 65655, flags = 0,name = L["Eric Davidson"], zoneId = 34, continentId = 0x0002, petId = {882, 881, 880}},
  {id = 65656, flags = 0,name = L["Bill Buckler"], zoneId = 673, continentId = 0x0002, petId = {888, 887, 886}},
  {id = 66126, flags = 0,name = L["Zunta"], zoneId = 4, continentId = 0x0001, petId = {890, 889}},
  {id = 66135, flags = 0,name = L["Dagra the Fierce"], zoneId = 11, continentId = 0x0001, petId = {893, 892, 891}},
  {id = 66136, flags = 0,name = L["Analynn"], zoneId = 43, continentId = 0x0001, petId = {896, 895, 894}},
  {id = 66137, flags = 0,name = L["Zonya the Sadist"], zoneId = 81, continentId = 0x0001, petId = {899, 898, 897}},
  {id = 66352, flags = 0,name = L["Traitor Gluk"], zoneId = 121, continentId = 0x0001, petId = {906, 905, 904}},
  {id = 66372, flags = 0,name = L["Merda Stronghoof"], zoneId = 101, continentId = 0x0001, petId = {902, 901, 900}},
  {id = 66412, flags = 0,name = L["Elena Flutterfly"], zoneId = 241, continentId = 0x0001, petId = {926, 925, 924}},
  {id = 66422, flags = 0,name = L["Cassandra Kaboom"], zoneId = 607, continentId = 0x0001, petId = {909, 908, 907}},
  {id = 66436, flags = 0,name = L["Grazzle the Great"], zoneId = 141, continentId = 0x0001, petId = {913, 912, 911}},
  {id = 66442, flags = 0,name = L["Zoltan"], zoneId = 182, continentId = 0x0001, petId = {923, 922, 921}},
  {id = 66452, flags = 0,name = L["Kela Grimtotem"], zoneId = 61, continentId = 0x0001, petId = {917, 916, 915}},
  {id = 66466, flags = 0,name = L["Stone Cold Trixxy"], zoneId = 281, continentId = 0x0001, petId = {929, 928, 927}},
  {id = 66478, flags = 0,name = L["David Kosse"], zoneId = 26, continentId = 0x0002, petId = {933, 932, 931}},
  {id = 66512, flags = 0,name = L["Deiza Plaguehorn"], zoneId = 23, continentId = 0x0002, petId = {936, 935, 934}},
  {id = 66515, flags = 0,name = L["Kortas Darkhammer"], zoneId = 28, continentId = 0x0002, petId = {939, 938, 937}},
  {id = 66518, flags = 0,name = L["Everessa"], zoneId = 38, continentId = 0x0002, petId = {943, 942, 941}},
  {id = 66520, flags = 0,name = L["Durin Darkhammer"], zoneId = 29, continentId = 0x0002, petId = {946, 945, 944}},
  {id = 66522, flags = 0,name = L["Lydia Accoste"], zoneId = 32, continentId = 0x0002, petId = {949, 948, 947}},
  {id = 66550, flags = 0,name = L["Nicki Tinytech"], zoneId = 465, continentId = 0x0004, petId = {952, 951, 950}},
  {id = 66551, flags = 0,name = L["Ras'an"], zoneId = 467, continentId = 0x0004, petId = {955, 954, 953}},
  {id = 66552, flags = 0,name = L["Narrok"], zoneId = 477, continentId = 0x0004, petId = {958, 957, 956}},
  {id = 66553, flags = 0,name = L["Morulu The Elder"], zoneId = 481, continentId = 0x0004, petId = {961, 960, 959}},
  {id = 66557, flags = 0,name = L["Bloodknight Antari"], zoneId = 473, continentId = 0x0004, petId = {964, 963, 962}},
  {id = 66635, flags = 0,name = L["Beegle Blastfuse"], zoneId = 491, continentId = 0x0008, petId = {967, 966, 965}},
  {id = 66636, flags = 0,name = L["Nearly Headless Jacob"], zoneId = 510, continentId = 0x0008, petId = {970, 969, 968}},
  {id = 66638, flags = 0,name = L["Okrut Dragonwaste"], zoneId = 488, continentId = 0x0008, petId = {973, 972, 971}},
  {id = 66639, flags = 0,name = L["Gutretch"], zoneId = 496, continentId = 0x0008, petId = {976, 975, 974}},
  {id = 66675, flags = 0,name = L["Major Payne"], zoneId = 492, continentId = 0x0008, petId = {979, 978, 977}},
  {id = 66730, flags = 0,name = L["Hyuna of the Shrines"], zoneId = 806, continentId = 0x0020, petId = {994, 993, 992}},
  {id = 66733, flags = 0,name = L["Mo'ruk"], zoneId = 857, continentId = 0x0020, petId = {998, 1000, 999}},
  {id = 66734, flags = 0,name = L["Farmer Nishi"], zoneId = 807, continentId = 0x0020, petId = {997, 996, 995}},
  {id = 66738, flags = 0,name = L["Courageous Yon"], zoneId = 809, continentId = 0x0020, petId = {1003, 1002, 1001}},
  {id = 66739, flags = 0,name = L["Wastewalker Shu"], zoneId = 858, continentId = 0x0020, petId = {1009, 1008, 1007}},
  {id = 66741, flags = 0,name = L["Aki the Chosen"], zoneId = 811, continentId = 0x0020, petId = {1012, 1011, 1010}},
  {id = 66815, flags = 0,name = L["Bordin Steadyfist"], zoneId = 640, continentId = 0x0010, petId = {985, 984, 983}},
  {id = 66819, flags = 0,name = L["Brok"], zoneId = 606, continentId = 0x0001, petId = {982, 981, 980}},
  {id = 66822, flags = 0,name = L["Goz Banefury"], zoneId = 700, continentId = 0x0002, petId = {988, 987, 986}},
  {id = 66824, flags = 0,name = L["Obalis"], zoneId = 720, continentId = 0x0001, petId = {991, 990, 989}},
  {id = 66918, flags = 0,name = L["Seeker Zusshi"], zoneId = 810, continentId = 0x0020, petId = {1006, 1005, 1004}},
  {id = 67370, flags = 0,name = L["Jeremy Feasel"], zoneId = 823, continentId = 0x0010, petId = {1065, 1067, 1066}},
  {id = 68462, flags = 0,name = L["Flowing Pandaren Spirit"], zoneId = 858, continentId = 0x0020, petId = {1132, 1133, 1138}},
  {id = 68463, flags = 0,name = L["Burning Pandaren Spirit"], zoneId = 810, continentId = 0x0020, petId = {1130, 1139, 1131}},
  {id = 68464, flags = 0,name = L["Whispering Pandaren Spirit"], zoneId = 806, continentId = 0x0020, petId = {1135, 1136, 1140}},
  {id = 68465, flags = 0,name = L["Thundering Pandaren Spirit"], zoneId = 809, continentId = 0x0020, petId = {1141, 1134, 1137}},
  {id = 68555, flags = 3,name = "", zoneId = 806, continentId = 0x0020, petId = {1129}},
  {id = 68558, flags = 3,name = "", zoneId = 858, continentId = 0x0020, petId = {1187}},
  {id = 68559, flags = 3,name = "", zoneId = 811, continentId = 0x0020, petId = {1188}},
  {id = 68560, flags = 3,name = "", zoneId = 807, continentId = 0x0020, petId = {1189}},
  {id = 68561, flags = 3,name = "", zoneId = 807, continentId = 0x0020, petId = {1190}},
  {id = 68562, flags = 3,name = "", zoneId = 810, continentId = 0x0020, petId = {1191}},
  {id = 68563, flags = 3,name = "", zoneId = 809, continentId = 0x0020, petId = {1192}},
  {id = 68564, flags = 3,name = "", zoneId = 809, continentId = 0x0020, petId = {1193}},
  {id = 68565, flags = 3,name = "", zoneId = 806, continentId = 0x0020, petId = {1194}},
  {id = 68566, flags = 3,name = "", zoneId = 857, continentId = 0x0020, petId = {1195}},
  {id = 71924, flags = 0,name = L["Wrathion"], zoneId = 955, continentId = 0x0020, petId = {1299, 1301, 1300}},
  {id = 71926, flags = 0,name = L["Lorewalker Cho"], zoneId = 955, continentId = 0x0020, petId = {1285, 1284, 1283}},
  {id = 71927, flags = 0,name = L["Chen Stormstout"], zoneId = 955, continentId = 0x0020, petId = {1282, 1281, 1280}},
  {id = 71929, flags = 0,name = L["Sully \"The Pickle\" McLeary"], zoneId = 955, continentId = 0x0020, petId = {1291, 1289, 1290}},
  {id = 71930, flags = 0,name = L["Shademaster Kiryn"], zoneId = 955, continentId = 0x0020, petId = {1288, 1287, 1286}},
  {id = 71931, flags = 0,name = L["Taran Zhu"], zoneId = 955, continentId = 0x0020, petId = {1295, 1293, 1292}},
  {id = 71932, flags = 0,name = L["Wise Mari"], zoneId = 955, continentId = 0x0020, petId = {1296, 1298, 1297}},
  {id = 71933, flags = 0,name = L["Blingtron 4000"], zoneId = 955, continentId = 0x0020, petId = {1278, 1279, 1277}},
  {id = 71934, flags = 0,name = L["Dr. Ion Goldbloom"], zoneId = 955, continentId = 0x0020, petId = {1269, 1271, 1268}},
  {id = 72009, flags = 3,name = "", zoneId = 955, continentId = 0x0020, petId = {1267}},
  {id = 72285, flags = 3,name = "", zoneId = 955, continentId = 0x0020, petId = {1311}},
  {id = 72290, flags = 3,name = "", zoneId = 955, continentId = 0x0020, petId = {1319}},
  {id = 72291, flags = 3,name = "", zoneId = 955, continentId = 0x0020, petId = {1317}},
  {id = 73626, flags = 0,name = L["Little Tommy Newcomer"], zoneId = 951, continentId = 0x0020, petId = {1339}},
  {id = 79179, flags = 0,name = L["Squirt"], zoneId = 971, continentId = 0x0040, petId = {1400, 1401, 1402}},
  {id = 79751, flags = 3,name = "", zoneId = 976, continentId = 0x0040, petId = {1409}},
  {id = 83837, flags = 0,name = L["Cymre Brightblade"], zoneId = 949, continentId = 0x0040, petId = {1443, 1444, 1424}},
  {id = 85519, flags = 0,name = L["Christoph VonFeasel"], zoneId = 823, continentId = 0x0010, petId = {1477, 1476, 1475}},
  {id = 85561, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1479, 1482}},
  {id = 85650, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1480}},
  {id = 85656, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1483, 1484, 1485}},
  {id = 85659, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1486}},
  {id = 85660, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1488, 1487}},
  {id = 85662, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1489, 1490}},
  {id = 85664, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1492, 1494, 1493}},
  {id = 85674, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1496, 1497, 1498}},
  {id = 85677, flags = 3,name = "", zoneId = 976, continentId = 0x0040, petId = {1500, 1499}},
  {id = 85679, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1501, 1502, 1503}},
  {id = 85682, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1504, 1505, 1506}},
  {id = 85685, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1507}},
  {id = 85686, flags = 3,name = "", zoneId = 971, continentId = 0x0040, petId = {1508, 1509, 1510}},
  {id = 87110, flags = 0,name = L["Tarr the Terrible"], zoneId = 950, continentId = 0x0040, petId = {1555, 1554, 1556}},
  {id = 87122, flags = 0,name = L["Gargra"], zoneId = 941, continentId = 0x0040, petId = {1550, 1552, 1553}},
  {id = 87123, flags = 0,name = L["Vesharr"], zoneId = 948, continentId = 0x0040, petId = {1558, 1559, 1557}},
  {id = 87124, flags = 0,name = L["Ashlei"], zoneId = 947, continentId = 0x0040, petId = {1547, 1548, 1549}},
  {id = 87125, flags = 0,name = L["Taralune"], zoneId = 946, continentId = 0x0040, petId = {1560, 1561, 1562}},
  {id = 90675, flags = 2,name = L["Erris the Collector"], zoneId = 971, continentId = 0x0040, petId = {1640, 1641, 1642}},
  {id = 91014, flags = 2,name = L["Erris the Collector"], zoneId = 971, continentId = 0x0040, petId = {1637, 1643, 1644}},
  {id = 91015, flags = 2,name = L["Erris the Collector"], zoneId = 971, continentId = 0x0040, petId = {1646, 1645, 1647}},
  {id = 91016, flags = 2,name = L["Erris the Collector"], zoneId = 971, continentId = 0x0040, petId = {1648, 1651, 1649}},
  {id = 91017, flags = 2,name = L["Erris the Collector"], zoneId = 971, continentId = 0x0040, petId = {1654, 1653, 1652}},
  {id = 94601, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1671}},
  {id = 94637, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1673}},
  {id = 94638, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1674}},
  {id = 94639, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1675}},
  {id = 94640, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1676}},
  {id = 94641, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1677}},
  {id = 94642, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1678}},
  {id = 94643, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1679}},
  {id = 94644, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1680}},
  {id = 94645, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1681}},
  {id = 94646, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1682}},
  {id = 94647, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1683}},
  {id = 94648, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1684}},
  {id = 94649, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1685}},
  {id = 94650, flags = 3,name = "", zoneId = 945, continentId = 0x0040, petId = {1686}},
};

-- Mapping from opponent ID to info
local opponentById =
{
  [85655] = 85561,
  [85657] = 85656,
  [85658] = 85656,
  [85661] = 85660,
  [85663] = 85662,
  [85665] = 85664,
  [85666] = 85664,
  [85675] = 85674,
  [85676] = 85674,
  [85678] = 85677,
  [85680] = 85679,
  [85681] = 85679,
  [85683] = 85682,
  [85684] = 85682,
  [85687] = 85686,
  [85688] = 85686,
};

-- Mapping from Alliance opponents to Horde opponents
-- NOTE: The mappings are for those opponents that have direct replacements and
--       identical pet teams, such as Erris the Collector/Kura Thunderhoof.
local opponentFactionMapping =
{
  [90675] =
  {
    id = 91026, name = L["Kura Thunderhoof"], zoneId = 941, iconId = 91026
  },
  [91014] =
  {
    id = 91361, name = L["Kura Thunderhoof"], zoneId = 941, iconId = 91026;
  },
  [91015] =
  {
    id = 91362, name = L["Kura Thunderhoof"], zoneId = 941, iconId = 91026
  },
  [91016] =
  {
    id = 91363, name = L["Kura Thunderhoof"], zoneId = 941, iconId = 91026
  },
  [91017] =
  {
    id = 91364, name = L["Kura Thunderhoof"], zoneId = 941, iconId = 91026
  },
};

local opponentCustomIcons =
{
  [68462] =  1138, -- Flowing Pandaren Spirit
  [68463] =  1139, -- Burning Pandaren Spirit
  [68464] =  1140, -- Whispering Pandaren Spirit
  [68465] =  1141, -- Thundering Pandaren Spirit
  [90675] = 90675, -- Erris the Collector
  [91014] = 90675, -- Erris the Collector
  [91015] = 90675, -- Erris the Collector
  [91016] = 90675, -- Erris the Collector
  [91017] = 90675, -- Erris the Collector
  [94601] = 94601, -- Felsworn Sentry
  [94637] = 94637, -- Corrupted Thundertail
  [94638] = 94638, -- Chaos Pup
  [94639] = 94639, -- Cursed Spirit
  [94640] = 94640, -- Felfly
  [94641] = 94641, -- Tainted Maulclaw
  [94642] = 94642, -- Direflame
  [94643] = 94643, -- Mirecroak
  [94644] = 94644, -- Dark Gazer
  [94645] = 94645, -- Bleakclaw
  [94646] = 94646, -- Vile Blood of Draenor
  [94647] = 94647, -- Dreadwalker
  [94648] = 94648, -- Netherfist
  [94649] = 94649, -- Skrillix
  [94650] = 94650, -- Defiled Earth
};

local loadOutPlaceholders = {{}, {}, {}};
local loadOutInfo = {};

local teamLoadInfo =
{
  pets     = {},
  numTries = 0
};

-------------------------------------------------------------------------------
--                 A  D  D  O  N     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

-- Automatically caches the info for each species interrogated
L.petSpecies = setmetatable({},
{
  __index = function(table, key)
    table[key] = {};
    table[key].name, table[key].icon, table[key].type =
      C_PetJournal.GetPetInfoBySpeciesID(key);
    table[key].id, table[key].level =
      C_PetJournal.GetPetAbilityList(key);

    return table[key];
  end
});

-------------------------------------------------------------------------------
--                 L  O  C  A  L     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function hooked into 'C_PetJournal.SetPetLoadOutInfo". It keeps track of
-- the GUID of the pets in each slots and hides placeholder frames when
-- appropriate.
--
local function petLoadOutOnChange(slotIdx, petGuid)
  -- Local Variables
  local petGuid;

  -- Update the info for each slot
  for idx = 1, L.MAX_ACTIVE_PETS do
    -- Get the GUID of the pet in the slot
    petGuid = C_PetJournal.GetPetLoadOutInfo(idx);

    -- Hide the placeholder frame, if the pet has changed
    if ((loadOutInfo[idx].placeholder ~= nil) and
        (loadOutInfo[idx].placeholder:IsShown()) and
        ((idx == slotIdx) or
         (loadOutInfo[idx].placeholder.guid ~= petGuid))) then
      loadOutInfo[idx].placeholder:Hide();
      loadOutInfo[idx].placeholder.guid = nil;
    end

    -- Save the pet's GUID
    loadOutInfo[idx].guid = petGuid;
  end

  -- Update the Pet Teams list 
  NigglesPetTeams.list.update(NigglesPetTeams.list);

  return;
end

--
-- Function to compare two pet teams for use with 'table.sort'
--
local function petTeamsCompare(first, second)
  -- Local Variables
  local namesCompared = strcmputf8i(first.name, second.name);

  -- Check if the pet teams have the same name
  if (namesCompared == 0) then
    -- Check if the pet teams have the same opponent
    if (first.opponentId-second.opponentId == 0) then
      return (first.editTime > second.editTime);
    else
      return (strcmputf8i(opponentById[first.opponentId].name,
               opponentById[second.opponentId].name) < 0);
    end
  end

  -- Compare the team names and opponents
  if ((first.name ~= "") and (second.name ~= "")) then
    return (namesCompared < 0);
  elseif ((first.name ~= "") and (second.name == "")) then
    if (second.opponentId > 0) then
      return (strcmputf8i(first.name,
        opponentById[second.opponentId].name) < 0);
    else
      return true;
    end
  elseif ((first.name == "") and (second.name ~= "")) then
    if (first.opponentId > 0) then
      return (strcmputf8i(opponentById[first.opponentId].name,
        second.name) < 0);
    else
      return false;
    end
  end

  -- Force an error
  assert(false, "Unhandled pet team comparison.");
  return false;
end

--
-- Function to load a pet team. This function is called by the addon function
-- 'L.petTeamLoad'. It will try several times to load the pets in a team, with
-- a short delay between each try. This is required because the Blizzard
-- function 'C_PetJournal.SetPetLoadOutInfo' isn't reliable.
--
local function teamLoad()
  -- Local Variables
  local cpj = C_PetJournal;
  local numFailed = 0;
  local speciesId;
  local speciesInfo;

  -- Load each pet in the team into the correct slot
  for slotIdx, petInfo in ipairs(teamLoadInfo.pets) do
    -- Check if a pet should be loaded into the slot
    if (petInfo.guid ~= nil) then
      -- Put the pet in the slot
      cpj.SetPetLoadOutInfo(slotIdx, petInfo.guid);
      if (cpj.GetPetLoadOutInfo(slotIdx) == petInfo.guid) then
        -- Check if the pet's abilities should be set
        speciesId   = L.petGetInfo(petInfo.guid);
        speciesInfo = (speciesId ~= nil and L.petSpecies[speciesId] or nil);
        if ((petInfo.abilityId ~= nil) and (speciesInfo ~= nil)) then
          -- Set the pet's abilities
          for abilityIdx, abilityId in ipairs(petInfo.abilityId) do
            if ((speciesInfo.id[abilityIdx                       ] ==
                  abilityId) or
                (speciesInfo.id[abilityIdx+L.NUM_ACTIVE_ABILITIES] ==
                  abilityId)) then
              cpj.SetAbility(slotIdx, abilityIdx, abilityId);
            end
          end
        end
      else
        numFailed = numFailed+1;
      end
    end

    -- Create the placeholder frame, if required
    if ((petInfo.isPlaceholder) and
        (loadOutInfo[slotIdx].placeholder == nil) and
        (_G["PetJournalLoadoutPet"..slotIdx] ~= nil)) then
      loadOutInfo[slotIdx].placeholder = CreateFrame("Frame", nil,
        _G["PetJournalLoadoutPet"..slotIdx],
        "NigglesPetTeamsPlaceholderTemplate");
    end

    -- Show/hide the placeholder frame
    if (loadOutInfo[slotIdx].placeholder ~= nil) then
      loadOutInfo[slotIdx].placeholder:SetShown(petInfo.isPlaceholder);
      loadOutInfo[slotIdx].placeholder.guid = cpj.GetPetLoadOutInfo(slotIdx);
    end
  end

  -- Update the pet journal's load out
  PetJournal_UpdatePetLoadOut();

  -- Check if another attempt is required to load the pet team
  if ((numFailed > 0) and (teamLoadInfo.numTries < MAX_LOAD_TRIES)) then
    teamLoadInfo.numTries = teamLoadInfo.numTries+1;
    C_Timer.After(0.1, teamLoad);
  end

  return;
end

--
-- Function to find the index of a value within a table
--
local function tIndex(table, value)
  -- Local Variables
  local index = nil;

  -- Search the table for the specified value
  for tableIdx, tableValue in ipairs(table) do
    if (tableValue == value) then
      index = tableIdx;
      break;
    end
  end

  return index;
end

-------------------------------------------------------------------------------
--                 A  D  D  O  N     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function to get the path for an opponent's icon
--
L.opponentGetIconPath = function(opponentId)
  return TEAM_ICON_PATH..(opponentCustomIcons[opponentId] or opponentId);
end

--
-- Function to get info about a pet from its GUID. The function first checks
-- if the info is available from the Pet Journal. If it isn't it then checks
-- the 'pets' table from the addon's saved variables. This allows info for
-- missing pets to be displayed.
--
L.petGetInfo = function(petGuid)
  -- Local Variables
  local health;
  local iterator;
  local level;
  local maxHealth;
  local power;
  local quality;
  local speciesId;
  local speed;
  local isAvailable = false;
  local customName;

  -- Check a pet GUID has been specified
  if (type(petGuid) == "string") then
    -- Try to get the pet's info from the Pet Journal
    speciesId, customName, level = C_PetJournal.GetPetInfoByPetID(petGuid);
    if (speciesId ~= nil) then
      health, maxHealth, power, speed, quality =
        C_PetJournal.GetPetStats(petGuid);
      isAvailable = true;
    elseif (NglPtDB.pets[petGuid] ~= nil) then
      iterator  = string.gmatch(NglPtDB.pets[petGuid], "[^|]+");
      speciesId = tonumber(iterator());
      level     = tonumber(iterator());
      maxHealth = tonumber(iterator());
      health    = maxHealth;
      power     = tonumber(iterator());
      speed     = tonumber(iterator());
      quality   = tonumber(iterator());
    end
  end

  return speciesId, customName, level, health, maxHealth, power, speed,
    quality, isAvailable;
end

--
-- Function to save the info for a pet to the 'pets' table in the addon's
-- saved variables. This info can then be used to display details of the pet
-- even if it is no longer in the Pet Journal, to aid in finding a replacement.
--
L.petSaveInfo = function(petGuid)
  -- Get the info to be saved for the pet
  local speciesId, _, level = C_PetJournal.GetPetInfoByPetID(petGuid);
  local _, maxHealth, power, speed, quality =
    C_PetJournal.GetPetStats(petGuid);

  -- Add the pet's info to the 'pets' table
  if ((type(level) == "number") and (type(quality) == "number")) then
    NglPtDB.pets[petGuid] = speciesId.."|"..level.."|"..maxHealth.."|"..
      power.."|"..speed.."|"..quality;
  end

  return;
end

--
-- Function to save info for a pet that doesn't exist in the player's pet
-- journal in a way that can't conflict with any new pets the player obtains.
--
L.petSavePseudoInfo = function(speciesId, level, maxHealth, power, speed, quality)
  -- Local Variables
  local petGuid;
  local pets = NglPtDB.pets;

  -- Search for a free pseudo GUID
  for idx = 1, 0xFFFF do
    petGuid = format(BATTLE_PET_PSEUDO, idx);
    if (pets[petGuid] == nil) then
      break;
    end
  end

  -- Check a free pseudo GUID was found
  if (pets[petGuid] == nil) then
    -- Add the pet's info to the 'pets' table
    pets[petGuid] = speciesId.."|"..level.."|"..maxHealth.."|"..
      power.."|"..speed.."|"..quality;
  end

  return petGuid;
end

--
-- Function to update the info in the 'pets' table
--
L.petsUpdateInfo = function()
  -- Local Variables
  local isUsed = {};
  local petGuid;

  -- Create a list of all the pets used in pet teams
  for _, petTeam in ipairs(NglPtDB.petTeams) do
    for _, petInfo in ipairs(petTeam.pets) do
      if (petInfo.guid ~= nil) then
        isUsed[petInfo.guid] = true;
      end
    end
  end

  -- Remove any unused pets from the list
  for petGuid, _ in pairs(NglPtDB.pets) do
    if (not isUsed[petGuid]) then
      NglPtDB.pets[petGuid] = nil;
    end
  end

  -- Update the info for the pets in the list
  for petGuid, _ in pairs(isUsed) do
    L.petSaveInfo(petGuid);
  end

  return;
end

--
-- Function to find the FIRST team that matches the current opponent and
-- load out.
--
function L.petTeamByCurrentBattle()
  -- Local Variables
  local current;
  local isMatch;
  local loadOutPets = {{abilityId = {}}, {abilityId = {}}, {abilityId = {}}};
  local opponentId;
  local teamInfo;

  -- Work out the current opponent from the pet species
  opponentId = L.petTeamOpponentByPetSpecies(
    C_PetBattles.GetPetSpeciesID(2, 1),
    C_PetBattles.GetPetSpeciesID(2, 2),
    C_PetBattles.GetPetSpeciesID(2, 3));
  if (opponentId ~= nil) then
    -- Get info for the current pets
    for petIdx = 1, L.MAX_ACTIVE_PETS do
      current = loadOutPets[petIdx];
      current.guid, current.abilityId[1], current.abilityId[2],
        current.abilityId[3] = C_PetJournal.GetPetLoadOutInfo(petIdx);
    end

    -- Check each pet team against the current opponent and load out
    for teamIdx = 1, #NglPtDB.petTeams do
      -- Check the team's opponent matches the current opponent
      current = NglPtDB.petTeams[teamIdx];
      if (current.opponentId == opponentId) then
        -- Check each pet in the pet team matches the load out
        isMatch = true;
        for petIdx = 1, L.MAX_ACTIVE_PETS do
          if (current.pets[petIdx].guid ~= nil) then
            -- Check if the GUID match
            if (current.pets[petIdx].guid ~= loadOutPets[petIdx].guid) then
              isMatch = false;
              break;
            end

            -- Check if the abilities in each slot match
            for abilityIdx = 1, L.NUM_ACTIVE_ABILITIES do
              if (current.pets[petIdx].abilityId[abilityIdx] ~=
                  loadOutPets[petIdx].abilityId[abilityIdx]) then
                isMatch = false;
                break;
              end
            end
          end
        end

        -- Check if the pet team is a match
        if (isMatch) then
          teamInfo = current;
          break;
        end
      end
    end
  end

  return teamInfo;
end

--
-- Function to copy the info for a pet team from one table to another
--
L.petTeamCopy = function(src, dest)
  -- Initialise the source and destination tables for the pet team
  src  = (src or emptyTable);
  dest = (dest or {});

  -- Copy the pet team info from the source to destination table
  dest.name       = (src.name       or ""   );
  dest.opponentId = (src.opponentId or 0    );
  dest.iconPathId = (src.iconPathId or 0    );
  dest.category   = (src.category   or 0    );
  dest.strategy   = (src.strategy   or ""   );
  dest.isHtml     = (src.isHtml     or false);
  dest.editTime   = (src.editTime   or 0    );
  dest.editPatch  = (src.editPatch  or ""   );
  dest.pets       = (dest.pets      or {}   );
  for idx = 1, L.MAX_ACTIVE_PETS do
    dest.pets[idx] = L.petTeamPetCopy(
      (src.pets ~= nil and src.pets[idx] or nil), dest.pets[idx]);
  end

  -- Make sure all string values are valid lengths
  if (strlenutf8(dest.name) > L.MAX_TEAM_NAME_LEN) then
    dest.name = L.utf8ncpy(dest.name, L.MAX_TEAM_NAME_LEN);
  end
  if (strlenutf8(dest.strategy) > L.MAX_TEAM_STRAT_LEN) then
    dest.strategy = L.utf8ncpy(dest.strategy, L.MAX_TEAM_STRAT_LEN);
  end

  return dest;
end

--
-- Function to delete a pet team
--
function L.petTeamDelete(teamInfo)
  -- Delete the pet team from the list
  tDeleteItem(NglPtDB.petTeams, teamInfo);

  return;
end

-- 
-- Function to check if a pet team is loaded
--
function L.petTeamIsLoaded(teamInfo)
  -- Local Variables
  local pets = teamInfo.pets;

  -- Check if the specified team is loaded
  return (((pets[1].guid == nil) or (pets[1].guid == loadOutInfo[1].guid)) and
          ((pets[2].guid == nil) or (pets[2].guid == loadOutInfo[2].guid)) and
          ((pets[3].guid == nil) or (pets[3].guid == loadOutInfo[3].guid)));
end

--
-- Function to load a pet team
--
function L.petTeamLoad(teamInfo)
  -- Local Variables
  local _;
  local cpj = C_PetJournal;
  local loadInfoPet;
  local lvlIdx = 1;
  local lvlPets = {};
  local numLvlPets = 0;
  local petGuid;
  local petLevel;

  -- Get the GUID of any levelling pets currently in the load out
  for slotIdx, petInfo in ipairs(teamInfo.pets) do
    petGuid = cpj.GetPetLoadOutInfo(slotIdx);
    if (petGuid ~= nil) then
      _, _, petLevel = C_PetJournal.GetPetInfoByPetID(petGuid);
      if ((petLevel ~= nil) and (petLevel < MAX_PET_LEVEL)) then
        numLvlPets = numLvlPets+1;
        lvlPets[numLvlPets] = {guid = petGuid, level = petLevel};
      end
    end
  end

  -- Sort the levelling pets by level
  if (numLvlPets > 1) then
    table.sort(lvlPets,
      function(first, second)
        return first.level < second.level;
      end);
  end

  -- Work out which pet to load into each slot
  for slotIdx, teamInfoPet in ipairs(teamInfo.pets) do
    -- Reset the info for the slot's pet
    if (teamLoadInfo.pets[slotIdx] == nil) then
      teamLoadInfo.pets[slotIdx] = {};
    end
    loadInfoPet = teamLoadInfo.pets[slotIdx];
    loadInfoPet.guid          = nil;
    loadInfoPet.isPlaceholder = true;
    loadInfoPet.abilityId     = nil;

    -- Work out which pet should go in the slot
    if ((teamInfoPet.guid ~= nil) and
        (cpj.GetPetInfoByPetID(teamInfoPet.guid) ~= nil)) then
      loadInfoPet.guid          = teamInfoPet.guid;
      loadInfoPet.isPlaceholder = false;
      loadInfoPet.abilityId     = teamInfoPet.abilityId;
    elseif (lvlIdx <= numLvlPets) then
      loadInfoPet.guid = lvlPets[lvlIdx].guid;
      lvlIdx = lvlIdx+1;
    end
  end

  -- Load the pets into the slots
  teamLoadInfo.numTries = 0;
  teamLoad();

  return;
end

--
-- Function to get info for an opponent by NPC ID
--
function L.petTeamOpponentById(id)
  -- Check if an opponent with the specified NPC ID is known
  if (opponentById[id] ~= nil) then
    -- NOTE: The ID is returned as the 2nd argument, rather than the first,
    --       because the name is required far more often.
    local current = opponentById[id];
    return current.name, current.id, current.zoneId, current.continentId;
  else
    return nil;
  end
end

--
-- Function to get info for an opponent by index
--
function L.petTeamOpponentByIndex(idx)
  -- Check if an opponent with the specified NPC ID is known
  if (opponentInfo[idx] ~= nil) then
    local current = opponentInfo[idx];
    return current.id, current.name, current.zoneId, current.continentId;
  else
    return nil;
  end
end

--
-- Function to get info for an opponent by the species of the specified pets
--
function L.petTeamOpponentByPetSpecies(...)
  -- Local Variables
  local opponentId;
  local opponentPetInfo;
  local petSpecies = {...};
  local numMatches;

  -- Search all the opponents for one with the specified pet species
  for opponentIdx = 1, #opponentInfo do
    -- Check the current opponent isn't 'Any Opponent'
    if (opponentInfo[opponentIdx].id > 0) then
      -- Compare the opponent's pets to the specified list
      opponentPetInfo = opponentInfo[opponentIdx].petId
      numMatches = 0;
      for petIdx = 1, L.MAX_ACTIVE_PETS do
        if ((opponentPetInfo[petIdx] ~= nil) and
            (opponentPetInfo[petIdx] == petSpecies[petIdx])) then
          numMatches = numMatches+1;
        end
      end

      -- Check if all the opponent's pets match the specified list
      if ((numMatches > 0) and (numMatches == #opponentPetInfo)) then
        opponentId = opponentInfo[opponentIdx].id;
        break;
      end
    end
  end

  return opponentId;
end

--
-- Function to get the number of opponents
--
function L.petTeamOpponentCount()
  return #opponentInfo;
end

--
-- Function to get the icons for an opponent.
--
function L.petTeamOpponentIconById(id, idx)
  -- Local Variables
  local iconId = nil;
  local opponent = opponentById[id];

  -- Check the opponent ID is valid
  if (opponent ~= nil) then
    if (idx == 1) then
      -- Check if the opponent has a custom icon
      if (opponentCustomIcons[opponent.id] ~= nil) then
        iconId = opponentCustomIcons[opponent.id];
      elseif (bit.band(opponent.flags, 0x01) ~= 0) then
        -- Use the first pet's icon
        iconId = opponent.petId[1];
      else
        -- Use the opponent's icon
        iconId = opponent.id;
      end
    elseif ((idx >= 2) and (idx <= 4)) then
      iconId = opponent.petId[idx-1];
    end
  end

  return iconId;
end

--
-- Function to copy the info for a pet from one table to another
--
function L.petTeamPetCopy(src, dest)
  -- Initialise the source and destination tables for the pet
  src  = src or emptyTable;
  dest = dest or {};

  -- Copy the pet info from the source to destination table
  dest.guid      = src.guid;
  dest.abilityId = dest.abilityId or {};
  for idx = 1, L.NUM_ACTIVE_ABILITIES do
    dest.abilityId[idx] = (src.abilityId ~= nil and src.abilityId[idx] or nil);
  end

  return dest;
end

--
-- Function to save a pet team
--
function L.petTeamSave(newInfo, newStrategy, teamInfo)
  -- Local Variables
  local petTeams = NglPtDB.petTeams;

  -- Save the pet team
  if (teamInfo == nil) then
    petTeams[#petTeams+1] = {};
    teamInfo = petTeams[#petTeams];
  end
  L.petTeamCopy(newInfo, teamInfo);

  -- Save info for the pet team's pets, for use if the pet is caged/released
  for _, petInfo in ipairs(teamInfo.pets) do
    if (petInfo.guid ~= nil) then
      L.petSaveInfo(petInfo.guid);
    end
  end

  -- Save the team's strategy
  teamInfo.strategy = newStrategy;

  -- Set the edit time and patch
  teamInfo.editTime  = time();
  teamInfo.editPatch = L.buildGetNumber();

  return teamInfo;
end

--
-- Function to save a new strategy for a pet team
--
function L.petTeamSaveStrategy(strategy, isHtml, teamInfo)
  -- Check a team has been specified
  if (teamInfo ~= nil) then
    -- Save the strategy
    teamInfo.strategy = strategy;
    teamInfo.isHtml   = isHtml;

    -- Set the edit time and patch
    teamInfo.editTime  = time();
    teamInfo.editPatch = L.buildGetNumber();
  end

  return;
end

--
-- Function to dismiss any pet summoned by the loading of a pet team
--
L.petTeamsDismissSummonedPet = function()
  -- Local Variables
  local summonedGuid = C_PetJournal.GetSummonedPetGUID();

  -- Check a pet team has been loaded
  if ((teamLoadInfo.pets[1] ~= nil) and 
      (teamLoadInfo.pets[1].guid ~= nil)) then
    -- Check if the summoned pet is from the pet team
    if ((summonedGuid ~= nil) and 
        (summonedGuid == teamLoadInfo.pets[1].guid)) then
      -- Dismiss the pet
      C_PetJournal.SummonPetByGUID(summonedGuid);

      -- Check in a short while that pet was dismissed
      C_Timer.After(0.25, L.petTeamsDismissSummonedPet);
    else
      teamLoadInfo.pets[1].guid = nil;
    end
  end

  return;
end

--
-- Function to check if there is an identical pet team to the specified one,
-- ignoring another team so an existing pet team being edited can be skipped.
--
function L.petTeamsHaveIdentical(teamInfo, ignoreTeam)
  -- Local Variables
  local current;
  local haveIdentical = false;
  local isIdentical;
  local petTeams = NglPtDB.petTeams;

  -- Check each pet team to see if it is identical to the specified team
  for teamIdx = 1, #petTeams do
    -- Set the flag that indicates if the pet teams are identical
    isIdentical = true;

    -- Compare the general info for the teams
    current = petTeams[teamIdx];
    if ((current.name       ~= teamInfo.name      ) or
        (current.opponentId ~= teamInfo.opponentId) or
        (current.strategy   ~= teamInfo.strategy  ) or
        (current.isHtml     ~= teamInfo.isHtml    )) then
      isIdentical = false;
    else
      -- Compare the pets for the teams
      for petIdx = 1, L.MAX_ACTIVE_PETS do
        if (current.pets[petIdx].guid ~= teamInfo.pets[petIdx].guid)  then
          isIdentical = false;
        elseif (current.pets[petIdx].guid ~= nil)  then
          -- Compare the abilities for the pets
          for abilityIdx = 1, L.NUM_ACTIVE_ABILITIES do
            if (current.pets[petIdx].abilityId[abilityIdx] ~=
                 teamInfo.pets[petIdx].abilityId[abilityIdx]) then
              isIdentical = false;
              break;
            end
          end
        end
      end
    end

    -- Check if the current pet team is a match for the specified pet team
    if ((isIdentical) and (current ~= ignoreTeam)) then
      haveIdentical = true;
      break;
    end
  end

  return haveIdentical;
end

--
-- Function to initialise the pet team software
--
L.petTeamsInit = function()
  -- Local Variables
  local _;
  local abilityIdx;
  local categories = NglPtDB.settings.categories;
  local cpjGetPetInfoBySpeciesID = C_PetJournal.GetPetInfoBySpeciesID;
  local currentPatch = L.buildGetNumber();
  local currentTime = time();
  local index;
  local numPets;
  local numValid;
  local opponent;
  local petInfo;
  local petLevel;
  local petSpeciesId;
  local speciesInfo;
  local validAbilities = {};

  -- Create a list of all opponent IDs
  for _, opponent in pairs(opponentInfo) do
    opponentById[opponent.id] = opponent;
  end

  -- Assign the correct opponent info to those opponents without a pet tamer
  for opponentId, opponentInfo in pairs(opponentById) do
    if (type(opponentInfo) == "number") then
      opponentById[opponentId] = opponentById[opponentInfo];
    end
  end

  -- Check if the player is Horde
  if (UnitFactionGroup("player") == "Horde") then
    -- Map Alliance opponents to their Horde equivalents with identical teams
    for allianceId, hordeInfo in pairs(opponentFactionMapping) do
      -- Add the opponent to the list of IDs
      opponent = opponentById[allianceId];
      opponentById[hordeInfo.id] = opponent;

      -- Update the opponent's info with the Horde details
      opponent.name   = hordeInfo.name;
      opponent.zoneId = hordeInfo.zoneId;

      -- Update the opponent's icon with the one for the Horde NPC
      opponentCustomIcons[allianceId] = hordeInfo.iconId;
    end
  end

  -- Initialise the names of the opponents
  for _, opponent in pairs(opponentInfo) do
    -- Create the opponent's name, if derived from the pets
    if (bit.band(opponent.flags, 0x02) ~= 0) then
      numPets = #opponent.petId;
      opponent.name = format("%s%s%s%s%s%s%s",
        (opponent.name),
        (opponent.name ~= "" and ": " or ""),
        (numPets >= 1 and cpjGetPetInfoBySpeciesID(opponent.petId[1]) or ""),
        ((numPets == 3) and ", " or ((numPets == 2) and " & " or "")),
        (numPets >= 2 and cpjGetPetInfoBySpeciesID(opponent.petId[2]) or ""),
        ((numPets == 3) and " & " or ""),
        (numPets >= 3 and cpjGetPetInfoBySpeciesID(opponent.petId[3]) or ""));
    end
  end

  -- Sort the opponents by name
  table.sort(opponentInfo,
    function(first, second)
      if ((first.id <= 1) or (second.id <= 1)) then
        return (first.id < second.id);
      else
        return (first.name < second.name);
      end
    end);

  -- Update the info stored for pets used in teams
  L.petsUpdateInfo();

  -- Validate the info for each team
  for _, teamInfo in ipairs(NglPtDB.petTeams) do
    -- Validate the opponent ID
    if (opponentById[teamInfo.opponentId] == nil) then
      teamInfo.opponentId = 0;
    end

    -- Validate the team name
    teamInfo.name = (teamInfo.name or
      ((teamInfo.opponentId == 0) and L["Unnamed Team"] or ""));
    if (strlenutf8(teamInfo.name) > L.MAX_TEAM_NAME_LEN) then
      teamInfo.name = L.utf8ncpy(teamInfo.name, L.MAX_TEAM_NAME_LEN);
    end

    -- Validate the strategy
    teamInfo.isHtml = (teamInfo.isHtml or false);
    if (teamInfo.strategy == nil) then
      teamInfo.strategy = "";
    elseif (strlenutf8(teamInfo.strategy) > L.MAX_TEAM_STRAT_LEN) then
      teamInfo.strategy = L.utf8ncpy(teamInfo.strategy, L.MAX_TEAM_STRAT_LEN);
    end

    -- Validate the edit time
    if ((teamInfo.editTime == nil) or
        (teamInfo.editTime > currentTime)) then
      teamInfo.editTime  = currentTime;
      teamInfo.editPatch = currentPatch;
    elseif (type(teamInfo.editPatch) == "string") then
      -- TODO: Remove when not likely to be needed any more
      teamInfo.editPatch = L.buildGetNumber(teamInfo.editPatch);
    end

    -- Validate the category
    if ((type(teamInfo.category) ~= "number") or
        (categories[teamInfo.category] == nil)) then
      teamInfo.category = 0;
    end

    -- Validate the pets
    for petIdx = 1, L.MAX_ACTIVE_PETS do
      -- Check the pet's entry is the correct type
      if (type(teamInfo.pets[petIdx]) ~= "table") then
        teamInfo.pets[petIdx] = L.petTeamPetCopy(nil);
      end

      -- Get info about the pet and its species
      petInfo = teamInfo.pets[petIdx];
      if (petInfo.guid ~= nil) then
        petSpeciesId, _, petLevel = L.petGetInfo(petInfo.guid);
        speciesInfo = (petSpeciesId ~= nil and
          L.petSpecies[petSpeciesId] or nil);
      end

      -- Check the pet's info could be obtained
      if ((petInfo.guid ~= nil) and (speciesInfo  ~= nil)) then
        -- NOTE: The following code is to handle pet abilities being moved
        --       by Blizzard, which has happened in the past, or a pet being
        --       de-levelled by it's quality being upgraded.

        -- Check which selected abilities are valid, based on species and level
        numValid = 0;
        for slotIdx = 1, L.NUM_ACTIVE_ABILITIES do
          index = tIndex(speciesInfo.id, petInfo.abilityId[slotIdx]);
          if ((index ~= nil) and (speciesInfo.level[index] <= petLevel)) then
            numValid = numValid+1;
            validAbilities[numValid] = petInfo.abilityId[slotIdx];
          end
        end

        -- Re-initialise selected abilities in their current slot
        abilityIdx = L.NUM_ACTIVE_ABILITIES+1;
        for slotIdx = 1, L.NUM_ACTIVE_ABILITIES do
          index = tIndex(validAbilities, speciesInfo.id[abilityIdx]);
          if ((index ~= nil) and (index <= numValid)) then
            petInfo.abilityId[slotIdx] = speciesInfo.id[abilityIdx];
          else
            petInfo.abilityId[slotIdx] = speciesInfo.id[slotIdx];
          end
          abilityIdx = abilityIdx+1;
        end
      else
        -- Remove the invalid pet
        teamInfo.pets[petIdx] = L.petTeamPetCopy(nil);
      end
    end
  end

  -- Sort the pet teams
  L.petTeamsSort();

  -- Initialise the load out info
  for slotIdx = 1, L.MAX_ACTIVE_PETS do
    loadOutInfo[slotIdx] = {};
  end

  -- Hook the function used to change the load out
  hooksecurefunc(C_PetJournal, "SetPetLoadOutInfo", petLoadOutOnChange);

  return;
end

--
-- Function to sort the pet teams by name and opponent
--
L.petTeamsSort = function()
  -- Sort the pet teams
  table.sort(NglPtDB.petTeams, petTeamsCompare);
  return;
end

--
-- Function to initialise the load out info
--
function L.petLoadOutInit()
  -- Get the GUID of the pet in each slot
  for slotIdx = 1, L.MAX_ACTIVE_PETS do
    loadOutInfo[slotIdx].guid = C_PetJournal.GetPetLoadOutInfo(slotIdx);
  end

  return;
end
