-------------------------------------------------------------------------------
--               G  L  O  B  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--                 L  O  C  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

local addonName, L = ...;

local TEAM_BUTTON_HEIGHT  = 46;
local TEAM_BUTTON_OFFSETX = 44;

local MASK_CONTINENT_ANY     = 0x8000;
local MASK_TEAM_COMPLETE     = 0x0001;
local MASK_TEAM_INCOMPLETE   = 0x0002;
local MASK_SEARCH_TEAM       = 0x0001;
local MASK_SEARCH_OPPONENT   = 0x0002;
local MASK_SEARCH_PETS       = 0x0004;
local MASK_OPPONENT_ANY      = 0x0001;
local MASK_OPPONENT_PVP      = 0x0002;
local MASK_OPPONENT_SPECIFIC = 0x0004;

local MAX_LASTEDITED_PATCHES = 5;

local NEW_TEAM_ICON = "Interface\\Addons\\Niggles-PetTeams\\textures\\NewTeam";

local petTeamsFrame;
local petTeamFilterInfo = {};
local petTeamsFiltered = {[0] = 0};
local petTeamFilters;

local petTeamcategoryFlags = 
{
  [0] = L.MASK_CATEGORY_NONE,
  [1] = 0x0001,
  [2] = 0x0002,
  [3] = 0x0004,
  [4] = 0x0008,
  [5] = 0x0010,
  [6] = 0x0020,
  [7] = 0x0040,
  [8] = 0x0080,
};

-------------------------------------------------------------------------------
--              L  O  C  A  L     D  E  F  I  N  I  T  I  O  N  S
-------------------------------------------------------------------------------

local filteredBarOnClick;
local petTeamFiltersReset;
local petTeamsFrameCreate;
local petTeamsListOnScroll;
local petTeamsOnEvent;
local petTeamsOnShowHide;
local searchDropDownSetCallbacks;

-------------------------------------------------------------------------------
--                 L  O  C  A  L     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function called when the addon is completely loaded. It initialises the
-- rest of the addon's software.
--
local function addonOnLoad()
  -- Create the menus used by the addon
  L.menu = NigglesPetTeamsMenuClass:New();
  L.searchDropDown = CreateFrame("Frame", "NigglesPetTeamsSearchDropDown",
    UIParent, "NigglesPetTeamsSearchDropDownTemplate");
  L.searchDropDown.SetCallbacks = searchDropDownSetCallbacks;

  -- Initialise the addon's settings
  L.settingsInit();

  -- Initialise the pet teams
  L.petTeamsInit();

  -- If the Pet Journal has already been loaded...
  if (PetJournal ~= nil) then
    -- ...create the Pet Teams frame
    petTeamsFrameCreate();
  end

  return;
end

--
-- Function called when the filter button is clicked.
--
local function filterButtonOnClick(self)
  -- Toggle the Filer drop down
  L.menu:Toggle(L.menuPetTeamsFilter, self);
  PlaySound("igMainMenuOptionCheckBoxOn");

  return;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- Categories sub-menu
--
local function filterCategoriesIsChecked(menu, menuArgs, index, value)
  return (bit.band(petTeamFilters.categories, value) > 0);
end

--
-- Function that returns the items for the Categories sub-menu
--
local function filterCategoriesItems(menu, menuArgs, value)
  -- Local Variables
  local categories = NglPtDB.settings.categories;
  local items =
  {
    {type = "Button",      label = CHECK_ALL,   value = L.MASK_UNFILTERED   },
    {type = "Button",      label = UNCHECK_ALL, value = 0x0000              },
    {type = "CheckButton", label = L["None"],   value = L.MASK_CATEGORY_NONE},
  };

  -- Add any categories that have a name
  for idx, icon in ipairs(L.categoryIcons) do
    if ((categories[idx] ~= nil) and (categories[idx] ~= "")) then
      items[#items+1] = 
      {
        type  = "CheckButton",
        label = icon.." "..categories[idx],
        value = bit.lshift(1, idx-1);
      };
    end
  end

  return items;
end

--
-- Function called when a menu item is clicked in the Filter Search drop down
--
local function filterCategoriesOnClick(menu, menuArgs, index, value, isChecked)
  -- Check if a '(Un)check All' button has been clicked
  if (index <= 2) then
    petTeamFilters.categories = value;
  else
    -- Update the categories filter value
    if (isChecked) then
      petTeamFilters.categories = bit.bor(petTeamFilters.categories, value);
    else
      petTeamFilters.categories =
        bit.band(petTeamFilters.categories, bit.bnot(value));
    end
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return false, 1;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- drop down.
--
local function filterCompleteDropDownIsChecked(menu, menuArgs, index, value)
  return (bit.band(petTeamFilters.completeness, value) ~= 0);
end

--
-- Function called when a menu item is clicked in the Filter Search drop down
--
local function filterCompleteDropDownOnClick(menu, menuArgs, index, value, isChecked)
  -- Update the completeness filter value
  if (isChecked) then
    petTeamFilters.completeness = bit.bor(petTeamFilters.completeness, value);
  else
    petTeamFilters.completeness =
      bit.band(petTeamFilters.completeness, bit.bnot(value));
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- Continents drop down.
--
local function filterContinentsDropDownIsChecked(menu, menuArgs, index, value)
  return (bit.band(petTeamFilters.continents , value) ~= 0);
end

--
-- Function called when a menu item is clicked in the Filter Continents
-- drop down
--
local function filterContinentsDropDownOnClick(menu, menuArgs, index, value, isChecked)
  -- Check if a '(Un)check All' button has been clicked
  if (index <= 2) then
    petTeamFilters.continents = value;
  else
    -- Update the continents filter value
    if (isChecked) then
      petTeamFilters.continents = bit.bor(petTeamFilters.continents, value);
    else
      petTeamFilters.continents = bit.band(petTeamFilters.continents,
        bit.bnot(value));
    end
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return false, 1;
end

--
-- Function called when the filtered bar is clicked. It clears all filtering
--
filteredBarOnClick = function(self, mouseButton)
  -- Clear all filtering
  petTeamsFrame.searchBox:SetText("");
  petTeamFiltersReset();

  -- Re-filter the pet teams
  L.petTeamsFilter();

  return;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- Last Edited sub-menu.
--
local function filterLastEditedIsChecked(menu, menuArgs, index, value)
  return (petTeamFilters.lastEdited[value] or false);
end

--
-- Function that returns the items for the Filter Last Edited sub-menu.
--
local function filterLastEditedItems(menu, menuArgs, value)
  -- Local Variables
  local alreadyKnown = {};
  local items =
  {
    {type = "Button", label = CHECK_ALL,   value = true },
    {type = "Button", label = UNCHECK_ALL, value = false},
  };
  local lastEdited = petTeamFilters.lastEdited;
  local patches = {};
  local petTeams = NglPtDB.petTeams;
  local teamInfo;

  -- Add the current patch to the list of patches
  patches[1] = L.buildGetNumber();
  alreadyKnown[patches[1]] = false;

  -- Get a list of the patches from the pet teams
  for teamIdx = 1, #petTeams do
    teamInfo = petTeams[teamIdx];
    if (alreadyKnown[teamInfo.editPatch] == nil) then
      patches[#patches+1] = teamInfo.editPatch;
      alreadyKnown[teamInfo.editPatch] = false;
    end
  end

  -- Sort the patches in descending order
  table.sort(patches, function(first, second) return first > second end);

  -- Add menu items for the 5 most recent patches
  for idx = 1, math.min(MAX_LASTEDITED_PATCHES, #patches) do
    items[#items+1] = 
    {
      type  = "CheckButton",
      label = L.buildGetString(patches[idx]),
      value = patches[idx],
    };
    alreadyKnown[patches[idx]] = true;
    if (lastEdited[patches[idx]] == nil) then
      lastEdited[patches[idx]] = (lastEdited[0] == 1);
    end
  end

  -- If there are more than the maximum number of patches allowed...
  if (#patches > MAX_LASTEDITED_PATCHES) then
    -- ...add an 'Older' menu item
    items[#items+1] = 
    {
      type  = "CheckButton",
      label = L["Older"],
      value = 1,
    };
    alreadyKnown[1] = true;
    if (lastEdited[1] == nil) then
      lastEdited[1] = (lastEdited[0] == 1);
    end
  end

  -- Clear any patches that are no longer relevant from the filters
  for patch, _ in pairs(lastEdited) do
    if ((patch ~= 0) and (not alreadyKnown[patch])) then
      lastEdited[patch] = nil;
    end
  end

  return items;
end

--
-- Function called when a menu item is clicked in the Filter Last Edited
-- sub-menu.
--
local function filterLastEditedOnClick(menu, menuArgs, index, value, isChecked)
  -- Local Variables
  local lastEdited = petTeamFilters.lastEdited;
 
  -- Process the button click
  if (index <= 2) then
    -- Set all patches to the selected state
    for patch, _ in pairs(lastEdited) do
      lastEdited[patch] = value;
    end

    -- Update the state for all patches
    lastEdited[0] = (index == 1 and 1 or 0);
  else
    -- Update the state for the selected patch
    lastEdited[value] = isChecked;

    -- Update the state for all patches
    lastEdited[0] = (isChecked and 1 or 0);
    for patch, patchChecked in pairs(lastEdited) do
      if (patch ~= 0) then
        if (patchChecked ~= isChecked) then
          lastEdited[0] = 2;
          break;
        end
      end
    end
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return false, 1;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- Opponents drop down.
--
local function filterOpponentsDropDownIsChecked(menu, menuArgs, index, value)
  return (bit.band(petTeamFilters.opponents , value) ~= 0);
end

--
-- Function called when a menu item is clicked in the Filter Opponents
-- drop down
--
local function filterOpponentsDropDownOnClick(menu, menuArgs, index, value, isChecked)
  -- Check if a '(Un)check All' button has been clicked
  if (index <= 2) then
    petTeamFilters.opponents = value;
  else
    -- Update the opponents filter value
    if (isChecked) then
      petTeamFilters.opponents = bit.bor(petTeamFilters.opponents, value);
    else
      petTeamFilters.opponents = bit.band(petTeamFilters.opponents,
        bit.bnot(value));
    end
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return false, 1;
end

--
-- Function that returns the checked state for a menu item in the Filter
-- Search drop down.
--
local function filterSearchDropDownIsChecked(menu, menuArgs, index, value)
  return (bit.band(petTeamFilters.search , value) ~= 0);
end

--
-- Function called when a menu item is clicked in the Filter menu
--
local function filterSearchDropDownOnClick(menu, menuArgs, index, value, isChecked)
  -- Update the search filter value
  if (isChecked) then
    petTeamFilters.search = bit.bor(petTeamFilters.search, value);
  else
    petTeamFilters.search = bit.band(petTeamFilters.search, bit.bnot(value));
  end

  -- Filter the pet teams
  L.petTeamsFilter();

  return;
end

--
-- Function called when the Pet Battle button is clicked
--
local function petBattleButtonOnClick(self, mouseButton)
  -- Hide the tutorial alert
  L.tutorialAlertHide(self);

  -- Show/hide the Strategy panel
  L.petTeamStrategyToggle(self, "battle", nil);

  return;
end

--
-- Function to process events for the Pet Battle button
--
local function petBattleButtonOnEvent(self, event, ...)
  -- Process the event
  if (event == "ADDON_LOADED") then
    local addonLoaded = select(1, ...);
    if (addonLoaded == addonName) then
      -- Initialise once the saved variables are available
      addonOnLoad();
    elseif (addonLoaded == "Blizzard_Collections") then
      petTeamsFrameCreate();
    elseif (addonLoaded == "PetBattleTeams") then
      L.petBattleTeamsHook();
    end
  elseif (event == "PLAYER_REGEN_ENABLED") then
    petTeamsFrameCreate();
  end

  return;
end

--
-- Function called when the Pet Battle button is shown or hidden
--
local function petBattleButtonOnShowHide(self)
  -- Show/hide the tutorial alert frame
  if ((self:IsShown()) and
      (NglPtDB.settings.generalShowTutorials) and
      (bit.band(NglPtDB.tutorialSeen, L.TUTORIALSEENFLAG_STRATEGY) == 0)) then
    L.tutorialAlertShow(self, L["PetBattleTutorial"],
      L.TUTORIALSEENFLAG_STRATEGY, 3, self);
    NglPtDB.tutorialSeen = bit.bor(NglPtDB.tutorialSeen,
      L.TUTORIALSEENFLAG_STRATEGY);
  else
    L.tutorialAlertHide(self);
  end
 
  -- Do any processing that is dependant on the frame's state
  if (self:IsVisible()) then
    local teamInfo = L.petTeamByCurrentBattle();
    if ((teamInfo ~= nil) and 
        (teamInfo.strategy ~= "") and
        (NglPtDB.settings.generalAutoShowStrat)) then
      L.petTeamStrategyShow(UIParent, "battle", teamInfo);
    end
  end

  return;
end

--
-- Function called when an item is selected in the right-click menu for
-- buttons in the Pet Teams scroll frame.
--
local function petTeamButtonMenuOnClick(menu, menuArgs, index, value, isChecked)
  -- Local Variables
  local teamInfo = menuArgs[1];
  local name = L["Unnamed Team"];

  -- Process the menu item selection
  if (index == 1) then
    L.petTeamEdit(teamInfo);
  elseif (index == 2) then
    L.petTeamLoad(teamInfo);
  elseif (index == 3) then
    if (teamInfo.name ~= "") then
      name = teamInfo.name;
    elseif (teamInfo.opponentId > 0) then
      name = L.petTeamOpponentById(teamInfo.opponentId);
    end
    StaticPopup_Show("NIGGLES_PETTEAMS_DELETE", (name or ""), nil, teamInfo);
  elseif (index == 4) then
    L.petTeamExport(teamInfo, NigglesPetTeams);
  end

  return;
end

--
-- Function to determine if items in Pet Teams scroll frame's right-click menu
-- should be enabled.
--
local function petTeamButtonMenuOnEnable(menu, menuArgs, index, value)
  -- Local Variables
  local isEnabled = true;

  -- Work out if the menu item should be enabled
  if (index == 2) then
    isEnabled = ((not C_PetBattles.IsInBattle()) and
                 (C_PetJournal.IsFindBattleEnabled()) and
                 (C_PetJournal.IsJournalUnlocked()))
  elseif (index == 3) then
    isEnabled = ((type(L.petTeamEditFrame) ~= "table") or
                 (not L.petTeamEditFrame:IsShown()) or
                 (L.petTeamEditFrame.teamInfo.team ~= menuArgs[1]));
  end

  return isEnabled;
end

--
-- Function that returns the items for the Category sub-menu
--
local function petTeamCategoryIsChecked(menu, menuArgs, index, value)
  return (menuArgs[1].category == value);
end

--
-- Function that returns the items for the Category sub-menu
--
local function petTeamCategoryIsEnabled(menu, menuArgs, index, value)
  -- Local Variables
  local categories = NglPtDB.settings.categories;
  local isEnabled = false;

  -- Search for any pet team category with a name
  for idx = 1, 8 do
    if ((categories[idx] ~= nil) and (categories[idx] ~= "")) then
      isEnabled = true;
      break;
    end
  end
  
  return isEnabled;
end

--
-- Function that returns the items for the Category sub-menu
--
local function petTeamCategoryItems(menu, menuArgs, value)
  -- Local Variables
  local categories = NglPtDB.settings.categories;
  local items =
  {
    {type = "RadioButton", label = L["None"], value = 0x0000},
  };

  -- Add any categories that have a name
  for idx, icon in ipairs(L.categoryIcons) do
    if ((categories[idx] ~= nil) and (categories[idx] ~= "")) then
      items[#items+1] = 
      {
        type  = "RadioButton",
        label = icon.." "..categories[idx],
        value = idx,
      };
    end
  end

  return items;
end

--
-- Function that returns the items for the Categories sub-menu
--
local function petTeamCategoryOnClick(menu, menuArgs, index, value, isChecked)
  -- Local Variables
  local teamInfo = menuArgs[1];

  -- Set the pet team's category
  teamInfo.category = value;

  -- Update the list of teams
  L.petTeamsFilter();

  return true;
end

--
-- Function to delete a pet team
--
local function petTeamDeleteConfirmed(teamInfo)
  -- Delete the team
  L.petTeamDelete(teamInfo);

  -- Update the list of teams
  L.petTeamsFilter();

  return
end

--
-- Function to reset the pet team filters
--
petTeamFiltersReset = function()
  -- Set the pet team filters to their default values
  petTeamFilters.completeness = L.MASK_UNFILTERED;
  petTeamFilters.continents   = L.MASK_UNFILTERED;
  petTeamFilters.opponents    = L.MASK_UNFILTERED;
  petTeamFilters.search       = L.MASK_UNFILTERED;
  petTeamFilters.categories   = L.MASK_UNFILTERED;
  petTeamFilters.lastEdited   = {[0] = 1};

  return;
end

--
-- Function to set the filtering of the pet teams to the current target, if
-- the current target is a known opponent.
--
local function petTeamsFilterOnTarget()
  -- Local Variables
  local _;
  local bor = bit.bor;
  local opponentContinentId;
  local opponentName;
  local targetId;

  -- If the current target is a known opponent...
  targetId = tonumber(string.match((UnitGUID("target") or ""),
               "[^-]+-[^-]+-[^-]+-[^-]+-[^-]+-([^-]+)-"));
  if (targetId ~= nil) then
    opponentName, _, _, opponentContinentId = L.petTeamOpponentById(targetId);
    if (opponentName ~= nil) then
      -- ...filter on the opponent's name
      petTeamFilters.completeness = bor(petTeamFilters.completeness,
        MASK_TEAM_COMPLETE+MASK_TEAM_INCOMPLETE);
      petTeamFilters.continents   =
        bor(petTeamFilters.continents, opponentContinentId);
      petTeamFilters.opponents    =
        bor(petTeamFilters.opponents, MASK_OPPONENT_SPECIFIC);
      petTeamFilters.lastEdited   = {[0] = 1};
      petTeamFilters.search       =
        bor(petTeamFilters.search, MASK_SEARCH_OPPONENT);
      petTeamsFrame.searchBox:SetText(opponentName);
      petTeamsFrame.searchBox:SetCursorPosition(0);
    end
  end

  return;
end

--
-- Function to create the Pet Teams frame
--
petTeamsFrameCreate = function()
  -- Local Variables
  local frame;
  local menuItems;

  -- Check if the frame needs to be created
  if (petTeamsFrame ~= nil) then
    -- Do nothing
  elseif (UnitAffectingCombat("player")) then
    NigglesPetBattleButton:RegisterEvent("PLAYER_REGEN_ENABLED");
  else
    -- Assign some info to more convenient variables
    petTeamFilters = NglPtDB.filters;

    -- Increase the frame level of the Collections Journal
    CollectionsJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel()+20);

    -- Create the Pet Teams frame
    petTeamsFrame = CreateFrame("Frame", "NigglesPetTeams", PetJournal,
      "NigglesPetTeamsTemplate");

    -- Adjust the frame level of some frames
    petTeamsFrame:SetFrameLevel(CollectionsJournal:GetFrameLevel()-20);
    petTeamsFrame.toggle:SetFrameLevel(
      NigglesPetTeamsListScrollBar:GetFrameLevel()+1);

    -- Set scripts for the Pet Teams frame
    petTeamsFrame:SetScript("OnEvent", petTeamsOnEvent);
    petTeamsFrame:SetScript("OnHide", petTeamsOnShowHide);
    petTeamsFrame:SetScript("OnShow", petTeamsOnShowHide);
    petTeamsFrame:RegisterUnitEvent("UNIT_PET", "player");

    -- Initialise the search box
    petTeamsFrame.searchBox:HookScript("OnTextChanged", L.petTeamsFilter);
    petTeamsFrame.searchBox:SetText(petTeamFilters.text);

    -- Initialise the filter button
    petTeamsFrame.filter:SetScript("OnClick", filterButtonOnClick);
    menuItems = L.menuPetTeamsFilter.items[4].items;
    for idx, name in ipairs({GetMapContinents()}) do
      if (idx%2 == 0) then
        table.insert(menuItems,
          {
            type  = "CheckButton",
            label = name,
            value = bit.lshift(1, (idx/2)-1);
          });
      end
    end

    -- Initialise the filtered bar
    petTeamsFrame.filteredBar:SetScript("OnClick", filteredBarOnClick);

    -- Initialise the scroll frame
    frame = petTeamsFrame.list
    frame.update = L.petTeamsListUpdate;
    frame.scrollBar.doNotHide = true;
    frame.scrollBar.trackBG:Show();
    frame.scrollBar.trackBG:SetVertexColor(0, 0, 0, 0.75);
    frame.scrollBar:HookScript("OnValueChanged", petTeamsListOnScroll);
    HybridScrollFrame_CreateButtons(frame, "NigglesPetTeamButtonTemplate",
      TEAM_BUTTON_OFFSETX, 0);

    -- Initialise the load out info
    L.petLoadOutInit();

    -- Initialise the Pet Teams list
    L.petTeamsFilter();

    -- Show/Hide the frame
    L.petTeamsShow(NglPtDB.settings.generalIsVisible);

    -- Unregister the event used to create the frame when in combat
    NigglesPetBattleButton:UnregisterEvent("PLAYER_REGEN_ENABLED");
  end

  return;
end

--
-- Function called when the Pet Teams list is scrolled. It hides the right-
-- click menu for the list.
--
petTeamsListOnScroll = function(self, value)
  -- Hide the right-click menu, if required
  if ((L.menu:IsShown()) and
      (L.menu:GetAnchor():GetParent():GetParent() == petTeamsFrame.list)) then
    L.menu:Hide();
  end

  return;
end

--
-- Function to process events for the Pet Teams panel
--
petTeamsOnEvent = function(self, event, ...)
  -- Process the event
  if (event == "PET_JOURNAL_LIST_UPDATE") then
    -- Check if the number of pets know has decreased
    local _, numPets = C_PetJournal.GetNumPets();
    if (numPets < self.numPets) then
      -- Filter the pet teams
      L.petTeamsFilter();
      self.numPets = numPets;
    end
  elseif (event == "PLAYER_TARGET_CHANGED") then
    petTeamsFilterOnTarget();
  elseif (event == "UNIT_PET") then
    -- Dismiss the pet, if required
    if (NglPtDB.settings.generalDismissPet) then
      L.petTeamsDismissSummonedPet();
    end
  end

  return
end

--
-- Function called when the Pet Teams frame is shown/hidden
--
petTeamsOnShowHide = function(self)
  -- Local Variables
  local _;
  local eventFunc =
    (self:IsVisible() and self.RegisterEvent or self.UnregisterEvent);

  -- (Un)register events
  eventFunc(self, "PET_JOURNAL_LIST_UPDATE");
  eventFunc(self, "PLAYER_TARGET_CHANGED");

  -- Save the number of pets so filtering can be redone only on decreases
  _, self.numPets = C_PetJournal.GetNumPets();

  -- Do any processing that is dependant on the frame's state
  if (self:IsVisible()) then
    -- Filter on the current target, if it's a known opponent
    petTeamsFilterOnTarget();

    -- Filter the pet teams
    L.petTeamsFilter();

    -- Show the tutorial alert, if required
    if ((self:IsVisible()) and
        (NglPtDB.settings.generalShowTutorials) and
        (bit.band(NglPtDB.tutorialSeen, L.TUTORIALSEENFLAG_PETTEAMS) == 0)) then
      L.tutorialAlertShow(self, L["PetTeamsTutorial1"],
        L.TUTORIALSEENFLAG_PETTEAMS, 1, self.toggle);
    end
  else
    -- Hide child frames
    L.menu:Hide();
    L.petTeamImportExportHide();
  end

  return;
end

--
-- Function to set the callbacks for the search drop down
--
searchDropDownSetCallbacks = function(self, updateFunc, onClickFunc, onTextChanged, userData)
  -- Set the callbacks for the search drop down
  self.userData                = userData;
  self.searchBox.onTextChanged = onTextChanged;
  self.scrollFrame.update      = updateFunc;
  self.scrollFrame.onClick     = onClickFunc;

  return;
end

-------------------------------------------------------------------------------
--                 A  D  D  O  N     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function to filter the list of pet teams
--
L.petTeamsFilter = function()
  -- Local variables
  local _;
  local band = bit.band;
  local current;
  local filterInfo;
  local isAvailable;
  local isMatch;
  local numFiltered = 0;
  local numTeams = #NglPtDB.petTeams;
  local opponentContinent;
  local opponentName;
  local petCustomName;
  local searchText;
  local speciesId;
  local speciesName;
  local strlower = string.lower;

  -- Save the search text
  petTeamFilters.text = (NigglesPetTeams.searchBox:GetText() or "");
  searchText          = strlower(petTeamFilters.text);

  -- Cache info used to filter the teams
  for teamIdx, teamInfo in ipairs(NglPtDB.petTeams) do
    -- Initialise the pet team filter info, if required
    if (petTeamFilterInfo[teamIdx] == nil) then
      petTeamFilterInfo[teamIdx] = {};
    end
    filterInfo      = petTeamFilterInfo[teamIdx];
    filterInfo.info = teamInfo;

    -- Work out the opponent's name and continent
    if (teamInfo.opponentId > 1) then
      filterInfo.opponent, _, _, filterInfo.continent =
        L.petTeamOpponentById(teamInfo.opponentId);
      filterInfo.opponent = strlower(filterInfo.opponent);
    else
      filterInfo.opponent  = "";
      filterInfo.continent = MASK_CONTINENT_ANY;
    end

    -- Work out the team's name
    filterInfo.name = (teamInfo.name ~= nil and strlower(teamInfo.name) or
      filterInfo.opponent);

    -- Work out the flag for the type of the team's opponent
    filterInfo.opponentType = (teamInfo.opponentId > 1 and
      MASK_OPPONENT_SPECIFIC or teamInfo.opponentId+1);
     
    -- Save the patch the team was last edited
    filterInfo.editPatch = teamInfo.editPatch;

    -- Work out the flag for team's category
    filterInfo.category = (petTeamcategoryFlags[teamInfo.category] or 0);

    -- Get the names of all the pets
    filterInfo.pets         = "";
    filterInfo.completeness = MASK_TEAM_COMPLETE;
    for _, petInfo in ipairs(teamInfo.pets) do
      if ((petInfo.guid ~= nil) and
          (L.petGetInfo(petInfo.guid) ~= nil)) then
        speciesId, petCustomName, _, _, _, _, _, _, isAvailable =
          L.petGetInfo(petInfo.guid);
        speciesName = L.petSpecies[speciesId].name;
        if (speciesName ~= nil) then
          filterInfo.pets = filterInfo.pets.."|"..speciesName:lower();
        end
        if (petCustomName ~= nil) then
          filterInfo.pets = filterInfo.pets.."|"..petCustomName:lower();
        end
        if (not isAvailable) then
          filterInfo.completeness = MASK_TEAM_INCOMPLETE;
        end
      end
    end
  end

  -- Filter the pet teams
  if ((searchText                   == "") and
      (petTeamFilters.completeness  == L.MASK_UNFILTERED) and
      (petTeamFilters.continents    == L.MASK_UNFILTERED) and
      (petTeamFilters.opponents     == L.MASK_UNFILTERED) and
      (petTeamFilters.categories    == L.MASK_UNFILTERED) and
      (petTeamFilters.lastEdited[0] == 1)) then
    -- Add all teams to the filtered list
    for teamIdx, teamInfo in ipairs(petTeamFilterInfo) do
      petTeamsFiltered[teamIdx] = teamInfo;
    end
    numFiltered = numTeams;
  elseif ((petTeamFilters.completeness  == 0) or
          (petTeamFilters.continents    == 0) or
          (petTeamFilters.opponents     == 0) or
          (petTeamFilters.categories    == 0) or
          (petTeamFilters.lastEdited[0] == 0)) then
    -- Remove all teams from the filtered list
    numFiltered = 0;
  else
    -- Initialise some variables
    local searchName     = (band(petTeamFilters.search, MASK_SEARCH_TEAM) ~= 0);
    local searchOpponent = (band(petTeamFilters.search,
      MASK_SEARCH_OPPONENT) ~= 0);
    local searchPets     = (band(petTeamFilters.search, MASK_SEARCH_PETS) ~= 0);
    local lastEdited     = petTeamFilters.lastEdited;

    -- Add all pet teams that match the filers to the filtered list
    for _, filterInfo in ipairs(petTeamFilterInfo) do
      if ((band(filterInfo.continent, petTeamFilters.continents) ~= 0) and
          (band(filterInfo.completeness, petTeamFilters.completeness) ~= 0) and
          (band(filterInfo.opponentType, petTeamFilters.opponents) ~= 0) and
          (band(filterInfo.category, petTeamFilters.categories) ~= 0) and
          ((lastEdited[0] == 1) or
           (lastEdited[filterInfo.editPatch]) or
           ((lastEdited[filterInfo.editPatch] == nil) and
            (lastEdited[1] == true))) and
          ((searchText == "") or
           ((searchName) and
            (string.find(filterInfo.name, searchText, 1, true) ~= nil)) or
           ((searchOpponent) and
            (string.find(filterInfo.opponent, searchText, 1, true) ~= nil)) or
           ((searchPets) and
            (string.find(filterInfo.pets, searchText, 1, true) ~= nil)))) then
        numFiltered = numFiltered+1;
        petTeamsFiltered[numFiltered] = filterInfo;
      end
    end
  end

  -- Show/Hide the filtered bar
  if (numFiltered < numTeams) then
    NigglesPetTeams.filteredBar:SetFormattedText(L["FilteredShownHidden"],
      numFiltered, numTeams-numFiltered);
  end
  NigglesPetTeams.filteredBar:SetHeight(numFiltered < numTeams and 18 or 1);

  -- Save the number of filtered pet teams
  -- NOTE: This number is kept so it can be used instead of '#' and save
  --       the table being wiped when rebuilding the filtered list.
  petTeamsFiltered[0] = numFiltered;

  -- Update the Pet Teams scroll frame
  NigglesPetTeams.list:update();

  return;
end

--
-- Function to show/hide the Pet Teams frame
--
L.petTeamsShow = function(show)
  -- Check the Pet Teams frame exists
  if (petTeamsFrame == nil) then
    return;
  end

  -- Work out if the pet teams should be shown or hidden
  if (show == nil) then
    show = petTeamsFrame.toggle:GetChecked();
  else
    petTeamsFrame.toggle:SetChecked(show);
  end

  -- Show/Hide some of the frame's children
  petTeamsFrame.searchBox:SetShown(show);
  petTeamsFrame.list:SetShown(show);

  -- Position the Pet Teams frame
  petTeamsFrame:SetPoint("LEFT", PetJournalPetCardInset, "RIGHT",
    (show and 3 or -237), 0);

  -- Show the tutorial alert for the frame, if required
  if ((show) and
      (NglPtDB.settings.generalShowTutorials) and
      (bit.band(NglPtDB.tutorialSeen, L.TUTORIALSEENFLAG_NEWTEAM) == 0)) then
    L.tutorialAlertShow(petTeamsFrame, L["PetTeamsTutorial2"],
      L.TUTORIALSEENFLAG_NEWTEAM, 3, petTeamsFrame.list.buttons[1]);
  end

  return;
end

--
-- Function to update the Pet Teams list
--
L.petTeamsListUpdate = function(self)
  -- Local Variables
  local coordX;
  local coordY;
  local filterInfo;
  local loadoutPets = {};
  local numNames;
  local numTeams = petTeamsFiltered[0]+1;
  local offset;
  local opponentName;
  local teamIdx;
  local teamInfo;
  local textColor;

  -- Initialise some variable
  offset = HybridScrollFrame_GetOffset(self);

  -- Update the buttons in the scroll frame
  for buttonIdx, button in ipairs(self.buttons) do
    -- Work out which team the button is for
    teamIdx = buttonIdx+offset;
    if (teamIdx <= numTeams) then
      if (teamIdx < numTeams) then
        -- Assign info to more convenient variables
        filterInfo      = petTeamsFiltered[teamIdx];
        teamInfo        = filterInfo.info;
        button.teamInfo = teamInfo;

        -- Get the name of the team's opponent
        if (teamInfo.opponentId > 0) then
          opponentName = L.petTeamOpponentById(teamInfo.opponentId) or "";
        else
          opponentName = "";
        end

        -- Set the button's text
        numNames  = (teamInfo.name ~= "" and 1 or 0)+
          (opponentName ~= "" and 1 or 0);
        textColor = (filterInfo.completeness == MASK_TEAM_COMPLETE and
          NORMAL_FONT_COLOR or RED_FONT_COLOR);
        button.name:SetText(
          (teamInfo.name ~= "" and teamInfo.name or opponentName));
        button.name:SetTextColor(textColor.r, textColor.g, textColor.b);
        textColor = (filterInfo.completeness == MASK_TEAM_COMPLETE and
          HIGHLIGHT_FONT_COLOR or RED_FONT_COLOR);
        button.subName:SetText(numNames == 2 and opponentName or "");
        button.subName:SetTextColor(textColor.r, textColor.g, textColor.b);

        -- Set the button's icon
        button.icon:SetTexture(L.petTeamIconGetTexture(teamInfo.iconPathId));

        -- Set the button's category
        if (teamInfo.category > 0) then
          coordX = ((teamInfo.category-1)%4)*0.25;
          coordY = math.floor((teamInfo.category-1)/4)*0.25;
          button.category:SetTexCoord(coordX, coordX+0.25, coordY, coordY+0.25);
          button.category:Show();
        else
          button.category:Hide();
        end

        -- Show/Hide the highlight texture
        button.highlight:SetShown(L.petTeamIsLoaded(teamInfo));
      else
        -- Set the button up as the 'New Team' button
        numNames = 1;
        button.name:SetText(L["NewTeam"]);
        button.icon:SetTexture(NEW_TEAM_ICON);
        button.category:Hide();
        button.highlight:Hide();
        button.teamInfo = nil;
      end
      button.name:SetHeight(numNames == 2 and 12 or 30);
      button.name:SetWordWrap(numNames < 2);
      button.subName:SetShown(numNames == 2);
      button:Show();
    else
      button:Hide();
    end
  end

  -- Update the scroll frame's range
  HybridScrollFrame_Update(self, numTeams*TEAM_BUTTON_HEIGHT,
    self:GetHeight());

  return;
end

-------------------------------------------------------------------------------
--                G  L  O  B  A  L    F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function called when the pet battle toggle is loaded. It initialises the
-- rest of the addon's software
--
function NigglesPetBattleButtonOnLoad(self)
  -- Set the portrait displayed by the button
  SetPortraitToTexture(self.portrait, "Interface\\Icons\\PetJournalPortrait");

  -- Position the button
  self:SetPoint("CENTER", PetBattleFrame.TopVersusText, -1, 6);

  -- Set script handlers and register for events
  self:SetScript("OnClick", petBattleButtonOnClick);
  self:SetScript("OnEvent", petBattleButtonOnEvent);
  self:SetScript("OnShow",  petBattleButtonOnShowHide);
  self:SetScript("OnHide",  petBattleButtonOnShowHide);
  self:RegisterEvent("ADDON_LOADED");
  self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

  -- Try to hook into the Pet Battle Teams addon to add export options
  L.petBattleTeamsHook();

  -- Adjust the frame strata of part of the Blizzard pet battle frame
  PetBattleFrame.BottomFrame.TurnTimer:SetFrameStrata("MEDIUM");

  return;
end

--
-- Function to process a click on a button in the Pet Teams list
--
function NigglesPetTeamButtonOnClick(self, button)
  -- Process the button click
  if (button == "LeftButton") then
    L.menu:Hide();
    if ((self.teamInfo == nil) or
        ((not IsShiftKeyDown()) and (IsControlKeyDown()))) then
      L.petTeamEdit(nil);
    elseif ((IsShiftKeyDown()) and (not IsControlKeyDown())) then
      L.petTeamEdit(self.teamInfo);
    end
  elseif ((button == "RightButton") and (self.teamInfo ~= nil)) then
    -- Show/hide the menu
    if (not L.menu:IsShown(self)) then
      L.menu:Show(L.menuPetTeamButton, self, self.teamInfo);
    else
      L.menu:Hide();
    end
  end

  return;
end

--
-- Function to process a double-click on a button in the Pet Teams list
--
function NigglesPetTeamButtonOnDblClick(self, button)
  -- Local Variables
  local petInfo;

  -- Play the appropriate sound
  PlaySound("igAbilityIconDrop");

  -- Load the pet team, if the button has one and not in a battle
  if ((button == "LeftButton") and
      (self.teamInfo ~= nil) and
      (not C_PetBattles.IsInBattle()) and
      (C_PetJournal.IsFindBattleEnabled()) and
      (C_PetJournal.IsJournalUnlocked())) then
    L.petTeamLoad(self.teamInfo);
  end

  return;
end

--
-- Function to show/hide the Pet Teams frame
--
function NigglesPetTeamsToggleOnClick(self, mouseButton)
  -- Hide the alert frame
  L.tutorialAlertHide(NigglesPetTeams);

  -- Show/Hide the Pet Teams frame
  L.petTeamsShow();
  PlaySound("igCharacterInfoTab");

  -- Hide some child frames
  L.menu:Hide();
  L.petTeamImportExportHide();

  -- Save the Pet Teams frame's new state
  NglPtDB.settings.generalIsVisible = petTeamsFrame.toggle:GetChecked();

  return;
end

-------------------------------------------------------------------------------
--                    S  T  A  T  I  C     P  O  P  U  P  S
-------------------------------------------------------------------------------

StaticPopupDialogs["NIGGLES_PETTEAMS_WARNING"] =
{
  text           = "%s",
  button1        = OKAY,
  button2        = nil,
  timeout        = 0,
  OnAccept       = function() end,
  OnCancel       = function() end,
  whileDead      = 1,
  hideOnEscape   = 1,
  showAlert      = 1,
  preferredIndex = STATICPOPUP_NUMDIALOGS,
};

StaticPopupDialogs["NIGGLES_PETTEAMS_INFO"] =
{
  text           = "%s",
  button1        = OKAY,
  button2        = nil,
  timeout        = 0,
  OnAccept       = function() end,
  OnCancel       = function() end,
  whileDead      = 1,
  hideOnEscape   = 1,
  preferredIndex = STATICPOPUP_NUMDIALOGS,
};

StaticPopupDialogs["NIGGLES_PETTEAMS_DELETE"] =
{
  text           = L["ConfirmPetTeamDelete"],
  button1        = YES,
  button2        = NO,
  whileDead      = 1,
  OnAccept       = function(self, data)
    petTeamDeleteConfirmed(data);
  end,
  showAlert      = 1,
  timeout        = 0,
  exclusive      = 1,
  hideOnEscape   = 1,
  preferredIndex = STATICPOPUP_NUMDIALOGS,
};

-------------------------------------------------------------------------------
--                              M  E  N  U  S
-------------------------------------------------------------------------------

L.menuPetTeamButton =
{
  style    = "menu",
  position = "cursor",
  offset   = {x = 2, y = 2},
  onEnable = petTeamButtonMenuOnEnable,
  onClick  = petTeamButtonMenuOnClick,
  items    =
  {
    {type = "button", label = EDIT       },
    {type = "button", label = L["Load"]  },
    {type = "button", label = DELETE,    },
    {type = "button", label = L["Export"]},
    {
      type      = "SubMenu",
      label     = CATEGORY,
      hideAll   = true,
      isEnabled = petTeamCategoryIsEnabled,
      onCheck   = petTeamCategoryIsChecked,
      onClick   = petTeamCategoryOnClick,
      items     = petTeamCategoryItems,
    },
    {type = "button", label = CANCEL     },
  }
};

L.menuPetTeamsFilter =
{
  style    = "menu",
  position = "right",
  offset   = {x = -18, y = -8},
  autoHide = false,
  onCheck  = filterCompleteDropDownIsChecked,
  onClick  = filterCompleteDropDownOnClick,
  items    =
  {
    {type = "CheckButton", label = COMPLETE,   value = MASK_TEAM_COMPLETE  };
    {type = "CheckButton", label = INCOMPLETE, value = MASK_TEAM_INCOMPLETE};
    {
      type     = "SubMenu",
      label    = L["Search"],
      autoHide = false,
      onCheck  = filterSearchDropDownIsChecked,
      onClick  = filterSearchDropDownOnClick,
      items    =
      {
        {type = "CheckButton", label = NAME,      value = MASK_SEARCH_TEAM},
        {type = "CheckButton", label = L["Opponent"],
          value = MASK_SEARCH_OPPONENT},
        {type = "CheckButton", label = L["Pets"], value = MASK_SEARCH_PETS},
      }
    },
    {
      type     = "SubMenu",
      label    = L["Continents"],
      autoHide = false,
      onCheck  = filterContinentsDropDownIsChecked,
      onClick  = filterContinentsDropDownOnClick,
      items    =
      {
        {type = "Button",      label = CHECK_ALL,   value = L.MASK_UNFILTERED },
        {type = "Button",      label = UNCHECK_ALL, value = 0x0000            },
        {type = "CheckButton", label = L["Any"],    value = MASK_CONTINENT_ANY},
      }
    },
    {
      type     = "SubMenu",
      label    = L["Opponents"],
      autoHide = false,
      onCheck  = filterOpponentsDropDownIsChecked,
      onClick  = filterOpponentsDropDownOnClick,
      items    =
      {
        {type = "Button",      label = CHECK_ALL,   value = L.MASK_UNFILTERED},
        {type = "Button",      label = UNCHECK_ALL, value = 0x0000           },
        {type = "CheckButton", label = L["Any"],    value = MASK_OPPONENT_ANY},
        {type = "CheckButton", label = PVP,         value = MASK_OPPONENT_PVP},
        {type = "CheckButton", label = L["Specific"],
          value = MASK_OPPONENT_SPECIFIC},
      }
    },
    {
      type      = "SubMenu",
      label     = L["Categories"],
      autoHide  = false,
      isEnabled = petTeamCategoryIsEnabled,
      onCheck   = filterCategoriesIsChecked,
      onClick   = filterCategoriesOnClick,
      items     = filterCategoriesItems,
    },
    {
      type     = "SubMenu",
      label    = L["LastEdited"],
      autoHide = false,
      onCheck  = filterLastEditedIsChecked,
      onClick  = filterLastEditedOnClick,
      items    = filterLastEditedItems,
    },
  },
};
