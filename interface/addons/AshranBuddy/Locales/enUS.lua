-- Localization file for English Language
local AddOnName, AddOn = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true)


-- Global
L.ADDON_NAME = "AshranBuddy"
L.ADDON_MODULE_REQUIRED = "Module '%s' requires AshranBuddy"
L.ADDON_OPTIONS = "Options"
L.ADDON_GENERAL_CHANNEL_NAME = "General - Ashran"
L.ADDON_MODULE_ENABLED = "Enabled"
L.ADDON_WELCOME = "Welcome to Ashran Buddy!"
L.ADDON_TIME_FORMAT = "%.2d:%.2d"

-- General
L.GENERAL_NAME = "General"
L.GENERAL_DESCRIPTION = "Filters Broken Bones chat messages."
L.GENERAL_ENABLE_TOOLTIP = "Enables the General module"
L.GENERAL_DEBUG = "Debug Mode"
L.GENERAL_DEBUG_TOOLTIP = "Enables debug mode."

-- Event Timer
L.TIMER_NAME = "Event Timer"
L.TIMER_CHAT_PREFIX = "AshranBuddy: %s"
L.TIMER_ON_COOLDOWN = "%s are on cooldown for %s."
L.TIMER_INTERMISSION = "%s will announce randomly within the next %s."
L.TIMER_ANNOUNCED = "%s will begin in %s."
L.TIMER_ACTIVE = "%s is currently active."
L.TIMER_HANDLE_TOOLTIP = "Ashran Buddy\n\nYou MUST Type /ab lock or\n/ashranbuddy lock to activate.\nBars won't show until event is announced"
L.TIMER_EMPOWERED_ORE = "Empowered Ore"
L.TIMER_COLLECT_EMPOWERED_ORE = "Collect Empowered Ore"
L.TIMER_OGRE_FIRES = "Ogre Fires"
L.TIMER_RISEN_SPIRITS = "Risen Spirits"
L.TIMER_STADIUM_RACING = "Stadium Racing"
L.TIMER_DESCRIPTION = "Tracks and synchronizes timers for all Ashran events."
L.TIMER_ENABLE_TOOLTIP = "Enables the Ashran Event Timer module."
L.TIMER_LOCK = "Lock Event Timer"
L.TIMER_LOCK_TOOLTIP = "Locks and unlocks the event timer frame."
L.TIMER_SHOW_TIME = "Show Numbered Timer"
L.TIMER_SHOW_TIME_TOOLTIP = "Displays numbered timer on the right of the countdown bar."
L.TIMER_STACK_TIMERS = "Stack Timers"
L.TIMER_STACK_TIMERS_TOOLTIP = "Neatly stack and sort the timers."
L.TIMER_GROW_UP = "Grow Timers Up"
L.TIMER_GROW_UP_TOOLTIP = "Reverses the direction in which timers are added to the frame."
L.TIMER_SYNCING = "Synchronizing..."
L.TIMER_ALL_EVENTS = "All Events"
L.TIMER_A_RANDOM_EVENT = "An Event"
L.TIMER_COOLDOWN = "Cooldown"
L.TIMER_BE_READY = "Be Ready!"
L.TIMER_COLLECT_APEXIS_MARKS = "Collect Apexis Marks"
L.TIMER_APEXIS_MARKS = "Apexis Marks"
L.TIMER_KORLOK_SENDER = "Kor'lok"
L.TIMER_KORLOK_MSG_AWAKE = "I have returned"
L.TIMER_KORLOK_MSG_DEATH = "The empire"
L.TIMER_KORLOK_MSG_ALLIANCE = "Little blue warriors"
L.TIMER_KORLOK_MSG_HORDE = "The red ones"
L.TIMER_GRAVEYARD_NEUTRAL = "Graveyard: Neutral"
L.TIMER_GRAVEYARD_ALLIANCE = "Graveyard: Alliance"
L.TIMER_GRAVEYARD_HORDE = "Graveyard: Horde"
L.TIMER_GRAVEYARD_SENDER = "Ashran Herald"
L.TIMER_GRAVEYARD_MSG_NEUTRAL = "The Market Graveyard"
L.TIMER_GRAVEYARD_MSG_ALLIANCE = "The Alliance"
L.TIMER_GRAVEYARD_MSG_HORDE = "The Horde"

-- Nemesis Finder
L.NEMESIS_NAME = "Nemesis Finder"
L.NEMESIS_DESCRIPTION = "Highlights all players in your current raid group that share the same Nemesis Quest as you. (Requires other players to have AshranBuddy)"
L.NEMESIS_ENABLE_TOOLTIP = "Enables the Nemesis Finder module."
L.NEMESIS_MARKING = "Nemesis Marking"
L.NEMESIS_MARKING_TOOLTIP = "Enables the marking of your selected nemesis race."
L.NEMESIS_TARGET = "Nemesis Target"
L.NEMESIS_TARGET_TOOLTIP = "Allows you to have your nemesis automatically selected based on your current quest or to manually specify a target race."

-- Battle Flow
L.BATTLEFLOW_NAME = "Battle Flow"
L.BATTLEFLOW_DESCRIPTION = "Battle Flow description"
L.BATTLEFLOW_ENABLE_TOOLTIP = "Enables the Battle Flow module."
L.BATTLEFLOW_HANDLE_TOOLTIP = "Ashran Buddy\n\nYou MUST Type /ab lock or\n/ashranbuddy lock to activate.\nPoints won't show until your are in Ashran."
L.BATTLEFLOW_LOCK = "Lock Battle Flow"
L.BATTLEFLOW_LOCK_TOOLTIP = "Locks and unlocks the Battle Flow frame."
L.BATTLEFLOW_RESET = "Reset Battle Flow Position"
-- These must all exactly match strings returned by the game client. See GetWorldStateUIInfo(i) and GetNumWorldStateUI(). Also see BattleFlow/Module.lua.
L.BATTLEFLOW_TREMBLADE = "Grand Marshal Tremblade" -- Road
L.BATTLEFLOW_OVERWATCH = "Archmage Overwatch" -- Road
L.BATTLEFLOW_VANGUARD = "Tremblade's Vanguard" -- Road
L.BATTLEFLOW_CROSSROADS = "The Crossroads" -- Road
L.BATTLEFLOW_ADVANCE = "Volrath's Advance" -- Road
L.BATTLEFLOW_EMBERFALL = "Emberfall Tower" -- Road
L.BATTLEFLOW_VOLRATH = "High Warlord Volrath" -- Road
L.BATTLEFLOW_ENEMIES_SLAIN = "Enemies Slain" -- Road
L.BATTLEFLOW_ORE_COLLECTED = "Ore Collected" -- Empowered Ore event
L.BATTLEFLOW_SPIRITS_CAPTURED = "Risen Spirits Captured" -- Risen Spirits event
L.BATTLEFLOW_FIRES_SCORE = "Score" -- Ogre Fires event
L.BATTLEFLOW_RACE_LAPS = "Laps" -- Stadium Racing event
L.BATTLEFLOW_MARKS_COLLECTED = "Marks Collected" -- Apexis Marks event