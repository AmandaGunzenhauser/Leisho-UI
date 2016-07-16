-- enUS and enGB Localization file

local L = LibStub("AceLocale-3.0"):NewLocale("Tasks", "enUS", true)

if L then

--Tasks
L["tasks"]      = "Tasks"
L["taskLists"] = "Task Lists"
                
--days of week  
L["sunday"]    = WEEKDAY_SUNDAY
L["monday"]    = WEEKDAY_MONDAY
L["tuesday"]   = WEEKDAY_TUESDAY
L["wednesday"] = WEEKDAY_WEDNESDAY
L["thursday"]  = WEEKDAY_THURSDAY
L["friday"]    = WEEKDAY_FRIDAY
L["saturday"]  = WEEKDAY_SATURDAY
                
--reset times   
L["never"]  = "Never"
L["hourly"] = "Hourly"
L["daily"]  = "Daily"
L["weekly"] = "Weekly"

--config options
L["name"]                     = "Name"
L["weeklyResetDay"]           = "Weekly Reset Day"
L["weeklyResetDesc"]          = "Day of the week events (raids, world bosses, etc.) reset"
L["dailyResetHour"]           = "Weekly Reset Day"
L["DisplayOptions"]           = "Display Options"
L["LockDisplay"]              = "Lock Display"
L["LockDisplayDesc"]          = "Enable / disable moving the Tasks list on screen"
L["HideCompletedTasks"]       = "Hide Completed Tasks"
L["HideCompletedTasksDesc"]   = "Hides tasks that are complete until they reset"
L["dailyResetDesc"]           = "Time of the daily reset on your server"
L["noListSelected"]           = "Nothing to show here! Select a list to edit or click 'Create new list' to get started!"
L["confirmListDelete"]        = "Really delete list '%s'?" 
L["confirmTaskDelete"]        = "Really delete task '%s'?"
L["resetFrequency"]           = "Reset Frequency"
L["displayOptions"]           = "Display Options"
L["characters"]               = "Characters"
L["characterSelection"]       = "Character Selection"
L["characterSelectionDesc"]   = "Selects which characters this list will be active on\n|cFFFFD100All Characters:|r Task list will be shown on all characters\n|cFFFFD100Specific Characters:|r Task list will be shown on the chosen characters\n|cFFFFD100Character Criteria:|r Task list will be shown on characters matching specified criteria"
L["allCharacters"]            = "All Characters"
L["selectAllCharacters"]      = "All Characters Chosen"
L["specificCharacters"]       = "Specific Characters"
L["selectSpecificCharacters"] = "Select Specific Characters"
L["criteriaCharacters"]       = "Character Criteria"
L["selectCriteriaCharacters"] = "Set Character Criteria"
L["enable"]                   = "Enable"
L["characterLevel"]           = "Character Level"
L["minLevel"]                 = "Min Level"
L["maxLevel"]                 = "Max Level"
L["characterClass"]           = "Character Class"
L["classes"]                  = "Classes"
L["showFemaleClassNames"]     = "Show Female Class Names"
L["characterRace"]            = "Character Race"
L["races"]                    = "Races"
L["taskHeaderColor"]          = "Task Header Color"
L["taskDefaultColor"]         = "Default Task Color"
L["taskColor"]                = "Task Color"
L["taskResetColor"]           = "Reset Color"
L["taskResetColorTasks"]      = "Reset Tasks to default"
L["listOptions"]              = "List Options"
L["selectList"]               = "Select List"
L["createNewList"]            = "Create new list"
L["createNewTask"]            = "Create new task"
L["deleteList"]               = "Delete list"
L["deleteTask"]               = "Delete task"
L["promptNewTask"]            = "Enter name for new task:"
L["promptNewTaskList"]        = "Enter name for new task list:"
L["reorderTasks"]             = "Reorder tasks"

end