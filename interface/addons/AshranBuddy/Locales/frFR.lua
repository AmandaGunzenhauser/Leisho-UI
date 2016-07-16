-- Localization file for French Language by Mordroba - Eitrigg EU
local AddOnName, AddOn = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "frFR")
if (not L) then return end

-- Global
L.ADDON_NAME = "AshranBuddy"
L.ADDON_MODULE_REQUIRED = "Le module '%s' nécessite AshranBuddy"
L.ADDON_OPTIONS = "Options"
L.ADDON_GENERAL_CHANNEL_NAME = "Général - A’shran"
L.ADDON_MODULE_ENABLED = "Activé"
L.ADDON_WELCOME = "Bienvenue dans A’shran Buddy !"
L.ADDON_TIME_FORMAT = "%.2d:%.2d"

-- General
L.GENERAL_NAME = "Général"
L.GENERAL_DESCRIPTION = "Description Général"
L.GENERAL_ENABLE_TOOLTIP = "Active le module Général"
L.GENERAL_DEBUG = "Mode Debug"
L.GENERAL_DEBUG_TOOLTIP = "Active le mode debug."

-- Event Timer
L.TIMER_NAME = "Décompte d'Evénements"
L.TIMER_CHAT_PREFIX = "AshranBuddy : %s"
L.TIMER_ON_COOLDOWN = "%s sont en attente pendant %s."
L.TIMER_INTERMISSION = "%s va être annoncé aléatoirement pendant les prochaines %s."
L.TIMER_ANNOUNCED = "%s va commencer dans %s."
L.TIMER_ACTIVE = "%s est actif en ce moment."
L.TIMER_HANDLE_TOOLTIP = "A’shran Buddy\n\nVous DEVEZ taper /ab lock ou\n/ashranbuddy lock pour activer l'addon.\nLes barres ne s'afficheront que lorsque\nl'événement sera annoncé."
L.TIMER_EMPOWERED_ORE = "Minerai surpuissant"
L.TIMER_COLLECT_EMPOWERED_ORE = "Collecter du minerai surpuissant"
L.TIMER_OGRE_FIRES = "Puits de feu des ogres"
L.TIMER_RISEN_SPIRITS = "Esprits ressuscités"
L.TIMER_STADIUM_RACING = "Course en stade"
L.TIMER_DESCRIPTION = "Surveille et synchronise les décomptes pour tous les événements d'A’shran."
L.TIMER_ENABLE_TOOLTIP = "Active le module Décompte d'Evénements d'A’shran."
L.TIMER_LOCK = "Verrouille le décompte d'événements"
L.TIMER_LOCK_TOOLTIP = "Verrouille et déverrouille la fenêtre du décompte d'événements."
L.TIMER_SHOW_TIME = "Affiche le décompte"
L.TIMER_SHOW_TIME_TOOLTIP = "Affiche le décompte en chiffres à droite de la barre."
L.TIMER_STACK_TIMERS = "Empile les décomptes"
L.TIMER_STACK_TIMERS_TOOLTIP = "Range et trie proprement les décomptes."
L.TIMER_GROW_UP = "Inverse le sens d'ajout des décomptes"
L.TIMER_GROW_UP_TOOLTIP = "Inverse le sens dans lequel les décomptes sont ajoutés à l'interface."
L.TIMER_SYNCING = "Synchronisation..."
L.TIMER_ALL_EVENTS = "Tous les événements"
L.TIMER_A_RANDOM_EVENT = "Un événement"
L.TIMER_COOLDOWN = "Recharge"
L.TIMER_BE_READY = "Soyez prêts !"
L.TIMER_COLLECT_APEXIS_MARKS = "Collecter des Marques apogides"
L.TIMER_APEXIS_MARKS = "Marques apogides"
L.TIMER_KORLOK_SENDER = "Kor’lok"
L.TIMER_KORLOK_MSG_AWAKE = "Je suis de retour"
L.TIMER_KORLOK_MSG_DEATH = "L’empire"
L.TIMER_KORLOK_MSG_ALLIANCE = "Petits guerriers bleus"
L.TIMER_KORLOK_MSG_HORDE = "Les rouges"
L.TIMER_GRAVEYARD_NEUTRAL = "Cimetière : Neutre"
L.TIMER_GRAVEYARD_ALLIANCE = "Cimetière : Alliance"
L.TIMER_GRAVEYARD_HORDE = "Cimetière : Horde"
L.TIMER_GRAVEYARD_SENDER = "Héraut d’A’shran"
L.TIMER_GRAVEYARD_MSG_NEUTRAL = "Le cimetière du Marché"
L.TIMER_GRAVEYARD_MSG_ALLIANCE = "L’Alliance"
L.TIMER_GRAVEYARD_MSG_HORDE = "La Horde"

-- Nemesis Finder
L.NEMESIS_NAME = "Traqueur d'Ennemi juré"
L.NEMESIS_DESCRIPTION = "Identifie les joueurs partageant la même quête Ennemi juré que vous dans le raid actuel. (Requiert que les autres joueurs disposent d'AshranBuddy)"
L.NEMESIS_ENABLE_TOOLTIP = "Active le module Traqueur d'Ennemi juré."
L.NEMESIS_MARKING = "Marquage Ennemi juré"
L.NEMESIS_MARKING_TOOLTIP = "Active le marquage de la race ciblée."
L.NEMESIS_TARGET = "Ennemi juré ciblé"
L.NEMESIS_TARGET_TOOLTIP = "Permet de sélectionner votre Ennemi juré automatiquement en fonction de votre quête actuelle ou bien de spécifier manuellement une race ciblée."

-- Battle Flow
L.BATTLEFLOW_NAME = "Flux de la bataille"
L.BATTLEFLOW_DESCRIPTION = "Description Flux de la bataille"
L.BATTLEFLOW_ENABLE_TOOLTIP = "Active le module Flux de la bataille."
L.BATTLEFLOW_HANDLE_TOOLTIP = "Ashran Buddy\n\nVous DEVEZ taper /ab lock ou\n/ashranbuddy lock pour activer l'addon.\nLes points ne s'afficheront que si vous vous trouvez dans A'shran."
L.BATTLEFLOW_LOCK = "Verrouiller Flux de la bataille"
L.BATTLEFLOW_LOCK_TOOLTIP = "Verrouille et déverrouille Flux de la bataille."
L.BATTLEFLOW_RESET = "Remise à zéro de la position du Flux de la bataille"
-- These must all exactly match strings returned by the game client. See GetWorldStateUIInfo(i) and GetNumWorldStateUI(). Also see BattleFlow/Module.lua.
L.BATTLEFLOW_TREMBLADE = "Connétable Tremblelame" -- Road
L.BATTLEFLOW_OVERWATCH = "Belvédère de l’Archimage" -- Road
L.BATTLEFLOW_VANGUARD = "Avant-garde de Tremblame" -- Road
L.BATTLEFLOW_CROSSROADS = "La Croisée" -- Road
L.BATTLEFLOW_ADVANCE = "Base avancée de Volrath" -- Road
L.BATTLEFLOW_EMBERFALL = "Tour de Pluie-de-Braise" -- Road
L.BATTLEFLOW_VOLRATH = "Grand seigneur de guerre Volrath" -- Road
L.BATTLEFLOW_ENEMIES_SLAIN = "Ennemis tués" -- Road
L.BATTLEFLOW_ORE_COLLECTED = "Minerai collecté" -- Empowered Ore event
L.BATTLEFLOW_SPIRITS_CAPTURED = "Esprits ressuscités capturés" -- Risen Spirits event
L.BATTLEFLOW_FIRES_SCORE = "Score" -- Ogre Fires event
L.BATTLEFLOW_RACE_LAPS = "Tours" -- Stadium Racing event
L.BATTLEFLOW_MARKS_COLLECTED = "Marques collectées" -- Apexis Marks event
