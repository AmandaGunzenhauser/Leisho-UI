-------------------------------------------------------------------------------
--                L  O  C  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

local addonName, L = ...;

--
-- English is the default and fall-back locale and therefore the current
-- locale is not tested in this file. This file should appear before any
-- other locale files in the toc file.
--
L["AddonName"]            = "Niggles: Pet Teams";
L["DeleteTooltip"]        = "Delete Pet Team";
L["EditTooltip"]          = "Edit Pet Team";
L["Load"]                 = "Load";
L["NewTeam"]              = GREEN_FONT_COLOR_CODE.."New Team|r";
L["ConfirmPetTeamDelete"] =
  "Are you sure you want to delete the pet team '%s'?";
L["ConfirmPetTeamSave"] =
  "You already have an identical pet team.\nAre you sure you want to save "..
  "this pet team?";
L["PetTeamCreate"]        = "Create Pet Team";
L["PetTeamEdit"]          = "Edit Pet Team";
L["PetTeamStrategy"]      = "Pet Team Strategy";
L["PetTeamStrategyEdit"]  = "Edit Pet Team Strategy";
L["Any Opponent"]         = "Any Opponent";
L["Unnamed Team"]         = "Unnamed Team";
L["FilteredShownHidden"]  = "Filtered: %d shown, %d hidden";
L["PetMissing"]           =
  "|cFFFFFFFFMissing Pet|r\nClick to attempt to find a\nreplacement.";
L["Any"]                  = "Any";
L["Team"]                 = "Team";
L["Opponent"]             = "Opponent";
L["Opponents"]            = "Opponents";
L["Specific"]             = "Specific";
L["Select"]               = "Select...";
L["EditStrategy"]         = "Edit Strategy";
L["PetReplacements"]      = "Replacement Pets";
L["PetInfoUnavailable"]   = "The pet's information can't be obtained.";
L["PetGenusUnknown"]      = "The pet's genus can't be obtained.";
L["PetNoReplacment"]      =
  "No suitable replacement can be found for the battle pet.";

L["PetTeamEditTutorial1"] =
  "Click here to select an icon for the team.\n\nPets, items and spells can "..
  "be dropped here and their icon will be used.\n\nThe default icon is a "..
  "portrait of the selected opponent.";
L["PetTeamEditTutorial2"] =
  "If a name isn't entered, an opponent must be selected.\n\nIf a name is "..
  "entered, the team will be listed using that name, otherwise the team "..
  "will be listed under the opponent's name";
L["PetTeamEditTutorial3"] =
  "Enter the strategy here for defeating the opponent using the current "..
  "team.\n\nThe strategy can either be in plain text or HTML, using a "..
  "limited subset of standard tags.";
L["PetTeamEditTutorial4"] =
  "Drag pets to the battle slots to build the pet team.\n\n"..
  "Battle pet slots can be left empty for levelling pets. The pets in those "..
  "slots will be marked as placeholders when the pet team is loaded.";
L["PetTeamsTutorial1"] = "Click here to display the list of pet teams.";
L["PetTeamsTutorial2"] =
  "Click 'New Team' or Ctrl-click any existing team to add a team.\n\n"..
  "Double-click a team to load it into the battle pet slots.\n\n"..
  "Shift-click a team to edit it.\n\n"..
  "Right-click a team to display other options.";
L["PetBattleTutorial"] =
  "Click here to toggle the Pet Team Strategy frame.";
L["HtmlErrFormat"]          = "Error at line %d, column %d: %s";
L["HtmlErrMissingEnd"]      = "Missing end tag.";
L["HtmlErrUnknownTag"]      = "Unknown tag.";
L["HtmlErrUnexpectedText"]  = "Unexpected text.";
L["HtmlErrMalformedTag"]    = "Malformed tag.";
L["HtmlErrWrongEndTag"]     = "Wrong end tag.";
L["HtmlErrAttrsInEndTag"]   = "Attributes are not permitted in end tags.";
L["HtmlErrInvalidVoidTag"]  = "Invalid void tag.";
L["HtmlErrTagNotPermitted"] = "Tag not permitted here.";
L["HtmlErrVoidTag"]         = "Tag is a void tag";
L["Line:"]                  = "Line:";
L["Col:"]                   = "Col:";
L["HTML"]                   = "HTML";
L["Import"]                 = "Import";
L["PetTeamImport"]          = "Import Pet Team";
L["PetTeamExport"]          = "Export Pet Team";
L["EncodedPetTeam"]         = "Encoded Pet Team:";
L["LastEdited"]             = "Last Edited";
L["LastEditedFormat"]       =
  "<p style='color: #575757; font-family: SystemFont_Tiny'>"..
  "Last edited: %s (Patch %s)</p>";
L["PetTeamImportTutorial"]  =
  "Paste text here for an encoded pet team, and click on Import.\n\n"..
  "The text can be from an exported pet team you saved or from "..
  "another player.";
L["PetTeamExportTutorial"]  =
  "Copy the text here and paste is where you want to save your pet "..
  "team.\n\nThe text can be given to other players to share the pets, "..
  "abilities and strategy of your pet team.";
L["PetTeamErrorHeader"]     = "The pet team's header is corrupted.";
L["PetTeamErrorEnd"]        = "The end of the pet team is missing.";
L["PetTeamErrorLength"]     =
  "The length of the data for the pet team is invalid.";
L["PetTeamErrorChecksum"]   =
  "The data for the pet team doesn't match its checksum.";
L["PetTeamErrorVersion"]    =
  "The version of the data for the pet team is unsupported.";
L["PetTeamErrorCorrupt"]    = "The pet team's data is corrupted.";
L["PetTeamErrorExport"]     =
  "The pet team's data can't be encoded for some unknown reason."
L["PetTeamErrorMissingPet"] =
  "The pet team can't be exported because at least one of its pets is missing.";
L["PetTeamWarningExported"] =
  "%d pet |4team:teams; successfully exported.\n"..
  "%d pet |4team:teams; can't be exported\ndue to missing pets.";
L["PetTeamInfoExported"]    = "%d pet |4team:teams; successfully exported.";
L["Erris the Collector"]    = "Erris the Collector";
L["Kura Thunderhoof"]       = "Kura Thunderhoof";
L["Categories"]             = "Categories";

-- Settings
L["generalSubText"]              =
  "These options control general features."
L["generalAutoShowStrat"]        = "Auto-Show Strategy";
L["generalAutoShowStratTooltip"] = 
  "If enabled, the strategy for a pet team will be shown when a "..
  "pet battle starts.";
L["generalDismissPet"]           = "Dismiss Pet";
L["generalDismissPetTooltip"]    = 
  "If enabled, any pet automatically summoned when a pet team is loaded "..
  "will be dismissed.";
L["generalShowTutorials"]        = "Show Tutorials";
L["generalShowTutorialsTooltip"] = 
  "If enabled, tutorials will be displayed which introduce "..
  "you to "..L["AddonName"];
L["generalPetBreeds"]            = "Pet Breeds";
L["generalPetBreedsTooltip"]     =
  "|CFFFFFFFFExperimental|r\n"..
  "If enabled, the breed of pets in a pet team will be displayed.";
L["categoriesSubText"]           =
  "These options control the names of the pet team categories.";

NIGGLES_PETTEAMS_NAME     = "Name";
NIGGLES_PETTEAMS_DETAILS  = "Details";
NIGGLES_PETTEAMS_STRATEGY = "Strategy";
NIGGLES_PETTEAMS_PHOLDER  = "Placeholder";
