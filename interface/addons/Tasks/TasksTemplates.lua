local Tasks = Tasks
local L = Tasks.L
local db, _

Tasks:RegisterCallback("Tasks-Initialize", "TemplatesInit")

function Tasks:TemplatesInit()
  db = Tasks.db
end

Tasks.constants = {}
Tasks.constants.DAILY_RESET = 1
Tasks.constants.WEEKLY_RESET = 2
Tasks.constants.NEVER_RESET = 3

Tasks.constants.CHARACTERS_ALL = 1
Tasks.constants.CHARACTERS_SPECIFIC = 2
Tasks.constants.CHARACTERS_CRITERIA = 3

Tasks.constants.SUNDAY = 1
Tasks.constants.MONDAY = 2
Tasks.constants.TUESDAY = 3
Tasks.constants.WEDNESDAY = 4
Tasks.constants.THURSDAY = 5
Tasks.constants.FRIDAY = 6
Tasks.constants.SATURDAY = 7
Tasks.constants.CURRENT_DB_VERSION = 7

Tasks.defaults = {}

Tasks.defaults["db"] = {
  global = {
    addonEnabled = true,
    id = 0,
    editListId = nil,
    displayOptions = {
      frameSettings = {
        position = {
          x = 0,
          y = 0,
        },
        anchor = "CENTER",
        hidden = false,
        locked = false,
      },
      hideCompletedTasks = false,
    },
    resetOptions = {
      weeklyResetDay = Tasks.constants.TUESDAY,
    },
    listCount = 0,
    lists = {
      ['**'] = {
        resetFrequency = Tasks.constants.DAILY_RESET,
        taskCount = 0,
        displayOptions = {
          expanded = true,
          color = "FF76DEAF",
          taskDefaultColor = "FFFFFFFF",
        },
        tasks = {
          ["**"] = {
            completedChars = {
              ["**"] = {
                completed = false,
                timestamp = nil,
              },
            },
            displayOptions = {
            },
            characterOptions = {
            },
          },
        },
        characterOptions = {
          selectionType = Tasks.constants.CHARACTERS_ALL,
          characters = {
            ["**"] = true,
          },
          criteria = {
            levelEnabled = false,
            minLevel = 1,
            maxLevel = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()],
            classEnabled = false,
            classShowFemale = false,
            classes = {
              ["**"] = true,
            },
            raceEnabled = false,
            races = {
              ["**"] = true,
            },
          },
        },
      },
    },
    characters = {
      ["**"] = {
        disabled = false,
      },
    },
    realms = { },
  },
}