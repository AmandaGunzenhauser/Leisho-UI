-- Localization file for Italian Language by Thorwald Odin (Goblinatrox of Pozzo dell'Eternità)
local AddOnName, AddOn = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "itIT")
if (not L) then return end

-- General
L.ADDON_NAME = "AshranBuddy"
L.ADDON_MODULE_REQUIRED = "Il Modulo '%s' richiede AshranBuddy"
L.ADDON_OPTIONS = "Opzioni"
L.ADDON_GENERAL_CHANNEL_NAME = "Generale - Ashran"
L.ADDON_MODULE_ENABLED = "Abilitato"
L.ADDON_WELCOME = "Benvenuto in Ashran Buddy!"
L.ADDON_TIME_FORMAT = "%.2d:%.2d"

-- General
--TODO: L.GENERAL_NAME = "General"
--TODO: L.GENERAL_DESCRIPTION = "General description"
--TODO: L.GENERAL_ENABLE_TOOLTIP = "Enables the General module"
--TODO: L.GENERAL_DEBUG = "Debug Mode"
--TODO: L.GENERAL_DEBUG_TOOLTIP = "Enables debug mode."

-- Event Timer
L.TIMER_NAME = "Cronografo Evento"
L.TIMER_CHAT_PREFIX = "AshranBuddy: %s"
--TODO: L.TIMER_ON_COOLDOWN = "%s are on cooldown for %s."
--TODO: L.TIMER_INTERMISSION = "%s will announce randomly within the next %s."
L.TIMER_ANNOUNCED = "%s avrà inizio in %s."
L.TIMER_ACTIVE = "%s \195\168 attualmente in via di svolgimento."
L.TIMER_HANDLE_TOOLTIP = "Ashran Buddy\n\nDEVI digitare /ab lock oppure\n/ashranbuddy lock per attivare.\nLe Barre non saranno mostrate finch\195\168 l'eveneto non sar\195\160 annunciato dal sistema"
L.TIMER_EMPOWERED_ORE = "Minerale Potenziato"
L.TIMER_COLLECT_EMPOWERED_ORE = "Raccolta Minerale Potenziato"
L.TIMER_OGRE_FIRES = "Fuochi degli Ogre"
L.TIMER_RISEN_SPIRITS = "Spiriti Risorti"
L.TIMER_STADIUM_RACING = "Corsa allo Stadio"
L.TIMER_DESCRIPTION = "Traccia e sincronizza i Temporizzatori per tutti gli Eventi di Ashran."
L.TIMER_ENABLE_TOOLTIP = "Abilita il modulo Cronografo Eventi di Ashran."
L.TIMER_LOCK = "Blocca il Cronografo Eventi"
L.TIMER_LOCK_TOOLTIP = "S/Blocca il Cronografo Eventi."
L.TIMER_SHOW_TIME = "Mostra Cronografo Numerico"
L.TIMER_SHOW_TIME_TOOLTIP = "Mostra il temporizzatore numerico sulla destra delle Barre Evento."
L.TIMER_STACK_TIMERS = "Impila Temporizzatori"
L.TIMER_STACK_TIMERS_TOOLTIP = "Semplicemente impila ed ordina i temporizzatori."
--TODO: L.TIMER_GROW_UP = "Grow Timers Up"
--TODO: L.TIMER_GROW_UP_TOOLTIP = "Reverses the direction in which timers are added to the frame."
--TODO: L.TIMER_SYNCING = "Synchronizing..."
--TODO: L.TIMER_ALL_EVENTS = "All Events"
--TODO: L.TIMER_A_RANDOM_EVENT = "An Event"
--TODO: L.TIMER_COOLDOWN = "Cooldown"
--TODO: L.TIMER_BE_READY = "Be Ready!"
--TODO: L.TIMER_COLLECT_APEXIS_MARKS = "Collect Apexis Marks"
--TODO: L.TIMER_APEXIS_MARKS = "Apexis Marks"

-- Nemesis Finder
L.NEMESIS_NAME = "Ricerca Nemesi"
L.NEMESIS_DESCRIPTION = "Evidenzia tutti i giocatori nel tuo gruppo raid che condividono la tua stessa Missione Nemesi. (\195\136 richiesto l'utilizzo di AshranBuddy perch\195\168 questa opzione funzioni)"
L.NEMESIS_ENABLE_TOOLTIP = "Abilita il modulo Ricerca Nemesi."
L.NEMESIS_MARKING = "Marcatura Nemesi"
L.NEMESIS_MARKING_TOOLTIP = "Abilita la marcatura per le razze delle tue missioni Nemesi."
--TODO: L.NEMESIS_TARGET = "Nemesis Target"
--TODO: L.NEMESIS_TARGET_TOOLTIP = "Allows you to have your nemesis automatically selected based on your current quest or to manually specify a target race."

-- Battle Flow
--TODO: L.BATTLEFLOW_NAME = "Battle Flow"
--TODO: L.BATTLEFLOW_DESCRIPTION = "Battle Flow description"
--TODO: L.BATTLEFLOW_ENABLE_TOOLTIP = "Enables the Battle Flow module."
--TODO: L.BATTLEFLOW_HANDLE_TOOLTIP = "Ashran Buddy\n\nYou MUST Type /ab lock or\n/ashranbuddy lock to activate.\nPoints won't show until your are in Ashran."
--TODO: L.BATTLEFLOW_LOCK = "Lock Battle Flow"
--TODO: L.BATTLEFLOW_LOCK_TOOLTIP = "Locks and unlocks the Battle Flow frame."
--TODO: L.BATTLEFLOW_RESET = "Reset Battle Flow Position"
-- These must all exactly match strings returned by the game client. See GetWorldStateUIInfo(i) and GetNumWorldStateUI(). Also see BattleFlow/Module.lua.
--TODO: L.BATTLEFLOW_TREMBLADE = "Grand Marshal Tremblade"
--TODO: L.BATTLEFLOW_OVERWATCH = "Archmage Overwatch"
--TODO: L.BATTLEFLOW_VANGUARD = "Tremblade's Vanguard"
--TODO: L.BATTLEFLOW_CROSSROADS = "The Crossroads"
--TODO: L.BATTLEFLOW_ADVANCE = "Volrath's Advance"
--TODO: L.BATTLEFLOW_EMBERFALL = "Emberfall Tower"
--TODO: L.BATTLEFLOW_VOLRATH = "High Warlord Volrath"
--TODO: L.BATTLEFLOW_ENEMIES_SLAIN = "Enemies Slain"
--TODO: L.BATTLEFLOW_ORE_COLLECTED = "Ore Collected" -- Empowered Ore event
--TODO: L.BATTLEFLOW_SPIRITS_CAPTURED = "Risen Spirits Captured" -- Risen Spirits event
--TODO: L.BATTLEFLOW_FIRES_SCORE = "Score" -- Ogre Fires event
--TODO: L.BATTLEFLOW_RACE_LAPS = "Laps" -- Stadium Racing event
--TODO: L.BATTLEFLOW_MARKS_COLLECTED = "Apexis Marks Collected" -- Apexis Marks event
