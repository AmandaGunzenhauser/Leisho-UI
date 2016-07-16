local Tasks = Tasks
local L = Tasks.L
local db, _
local editListTasksArgs
local displayOptions, characterOptions

Tasks:RegisterCallback("Tasks-Initialize", "ConfigInit")

function Tasks:ConfigInit()
  db = Tasks.db
  self:RegisterChatCommand("tasks", "ChatCommandReceived")
  local LBR = LibStub("LibBabble-Race-3.0"):GetLookupTable()
  local localizedRacesLookup = {
    Pandaren = LBR["Pandaren"],
    Worgen = LBR["Worgen"],
    Draenei = LBR["Draenei"],
    Dwarf = LBR["Dwarf"],
    Gnome = LBR["Gnome"],
    Human = LBR["Human"],
    NightElf = LBR["Night Elf"],
    Goblin = LBR["Goblin"],
    BloodElf = LBR["Blood Elf"],
    Orc = LBR["Orc"],
    Tauren = LBR["Tauren"],
    Troll = LBR["Troll"],
    Undead = LBR["Undead"]
  }
  
  if db.global.editListId then
    characterOptions = db.global.lists[db.global.editListId].characterOptions
  end
  
  differentFemaleNames = false
  for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
    differentFemaleNames = differentFemaleNames or LOCALIZED_CLASS_NAMES_FEMALE[k] ~= v
  end
  
  --sets up all the config dialogs and popups
  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(
    "Tasks", 
    {
      type = "group",
      name = "Options",
      inline=true,
      args = {
        addonEnabledGroup = {
          type = "group",
          name = "Addon Enabled",
          inline=true,
          order = 10,
          args = {
            addonEnabled = {
              name = "Enable Tasks",
              desc = "Enables / disables Tasks",
              type = "toggle",
              set = function(info,val) 
                db.global.addonEnabled = val 
                Tasks:Fire("Tasks-EnabledChanged", val)
              end,
              get = function(info) return db.global.addonEnabled  end,
            },
          },
        },
        displayOptionsGroup = {
          type = "group",
          name = L["DisplayOptions"],
          inline=true,
          order = 20,
          args = {
            lockDisplay = {
              name = L["LockDisplay"],
              desc = L["LockDisplayDesc"],
              type = "toggle",
              order = 10,
              set = function(info,val) 
                if not val then Tasks.TasksFrame:RegisterForDrag("LeftButton")
                else Tasks.TasksFrame:RegisterForDrag() end
                db.global.displayOptions.frameSettings.locked = val
              end,
              get = function(info) return db.global.displayOptions.frameSettings.locked end,
            },
            hideCompletedTasks = {
              name = L["HideCompletedTasks"],
              desc = L["HideCompletedTasksDesc"],
              type = "toggle",
              order = 20,
              set = function(info,val)
                db.global.displayOptions.hideCompletedTasks = val
                Tasks:Fire("Tasks-HideCompletedChanged", val)
              end,
              get = function(info) return db.global.displayOptions.hideCompletedTasks end,
            },
          },
        },
        resetOptionsGroup = {
          type = "group",
          name = "Reset Options",
          inline=true,
          order = 30,
          args = {
            weeklyResetDay = {
              name = L["weeklyResetDay"],
              desc = L["weeklyResetDesc"],
              type = "select",
              values = CALENDAR_WEEKDAY_NAMES,
              --{
              --  [Tasks.constants.SUNDAY] = L["sunday"], 
              --  [Tasks.constants.MONDAY] = L["monday"], 
              --  [Tasks.constants.TUESDAY] = L["tuesday"], 
              --  [Tasks.constants.WEDNESDAY] = L["wednesday"], 
              --  [Tasks.constants.THURSDAY] = L["thursday"], 
              --  [Tasks.constants.FRIDAY] = L["friday"], 
              --  [Tasks.constants.SATURDAY] = L["saturday"]
              --},
              order = 10,
              disabled = function(info) return not db.global.addonEnabled end,
              set = function(info,val) db.global.resetOptions.weeklyResetDay = tonumber(val) end,
              get = function(info) return db.global.resetOptions.weeklyResetDay end,
            },
            --dailyResetHour = {
            --  name = L["dailyResetHour"],
            --  desc = L["dailyResetDesc"],
            --  type = "select",
            --  values = {
            --    [Tasks.constants.SUNDAY] = L["sunday"], 
            --    [Tasks.constants.MONDAY] = L["monday"], 
            --    [Tasks.constants.TUESDAY] = L["tuesday"], 
            --    [Tasks.constants.WEDNESDAY] = L["wednesday"], 
            --    [Tasks.constants.THURSDAY] = L["thursday"], 
            --    [Tasks.constants.FRIDAY] = L["friday"], 
            --    [Tasks.constants.SATURDAY] = L["saturday"]
            --  },
            --  order = 10,
            --  disabled = function(info) return not db.global.addonEnabled end,
            --  set = function(info,val) db.global.resetOptions.weeklyResetDay = tonumber(val) end,
            --  get = function(info) return db.global.resetOptions.weeklyResetDay end,
            --},
          },
        },
      },
    }
  )
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tasks", L["tasks"])
  
  local taskListsOptionsTable = {
    type = "group",
    name = L["taskLists"],
    childGroups = "tab",
    disabled = function(info) return not db.global.addonEnabled end,
	handler = Tasks,
    args={
      listSelection = {
        type = "select",
        name = L["selectList"],
        order = 10,
        values = function()
                   local listNames = {} 
                   for k,v in Tasks:OrderedTaskLists(db.global.lists) do
                     listNames[k] = v.name
                   end
                   return listNames
                 end,
        set = function(info,val) db.global.editListId = val Tasks:updateDynamicConfigs() end,
        get = function(info) return db.global.editListId end,
      },
      newList = {
        type = "execute",
        name = L["createNewList"] ,
        order = 20,
        func = "popupNewList",
      },
      noListsGroup = {
        type = "group",
        name = "",
        order = 40,
        inline=true,
        hidden = function(info) return db.global.editListId ~= nil end,
        args = {
          noLists = {
            type = "description",
            name = L["noListSelected"],
            fontSize = "medium",
            order = 10,
            hidden = function(info) return db.global.editListId ~= nil end,
          },
        },
      },
      editListOptionsGroup = {
        type = "group",
        name = L["listOptions"],
        order = 40,
        hidden = function(info) return db.global.editListId == nil end,
        args = {
          editListName = {
            type = "input",
            name = L["name"],
            order = 10,
            set = function(info,val) db.global.lists[db.global.editListId].name = val end,
            get = function(info) return db.global.lists[db.global.editListId].name end,
          },
          editListResetFrequency = {
            type = "select",
            name = L["resetFrequency"],
            order = 20,
            values = {
              [Tasks.constants.DAILY_RESET] = L["daily"], 
              [Tasks.constants.WEEKLY_RESET] = L["weekly"], 
              [Tasks.constants.NEVER_RESET] = L["never"]
            },
            style = "radio",
            set = function(info, val) db.global.lists[db.global.editListId].resetFrequency = val end,
            get = function(info) return db.global.lists[db.global.editListId].resetFrequency end,
          },
          deleteList = {
            type = "execute",
            name = L["deleteList"],
            order = 100,
            func = "deleteEditList",
            confirm = function(info) return L["confirmListDelete"]:format(db.global.lists[db.global.editListId].name) end
          },
        },
      },
      editListTasksGroup = {
        type = "group",
        name = L["tasks"],
        order = 40,
        hidden = function(info) return db.global.editListId == nil end,
		childGroups = "tree",
        args = { },
      },
      displayOptionsGroup = {
        type = "group",
        name = L["displayOptions"],
        order = 50,
        hidden = function(info) return db.global.editListId == nil end,
        args = { 
          taskHeaderColor = {
            type = "color",
            name = L["taskHeaderColor"],
            order = 30,
            set = function(info, r, g, b, a) 
                    displayOptions.color = Tasks:RGBToHex(r, g, b, a)
                    Tasks:Fire("Tasks-TaskColorChanged", "list", db.global.lists[db.global.editListId])
                  end,
            get = function(info) 
                    return Tasks:HexToRGB(displayOptions.color)
                  end,
          },
          taskHeaderColorReset = {
            type = "execute",
            name = L["taskResetColor"],
            order = 35,
            func = function(info) 
                     displayOptions.color = Tasks:RGBToHex(118/255, 222/255, 175/255, 1)
                     Tasks:Fire("Tasks-TaskColorChanged", "list", db.global.lists[db.global.editListId])
                   end,
          },
          taskBreakOne = {
            type = "description",
            name = "",
            order = 39,
          },
          taskDefaultColor = {
            type = "color",
            name = L["taskDefaultColor"],
            order = 40,
            set = function(info, r, g, b, a) 
                    displayOptions.taskDefaultColor = Tasks:RGBToHex(r, g, b, a)
                    Tasks:Fire("Tasks-TaskColorChanged", "defaultTask", db.global.lists[db.global.editListId])
                  end,
            get = function(info) 
                    return Tasks:HexToRGB(displayOptions.taskDefaultColor)
                  end,
          },
          taskDefaultColorReset = {
            type = "execute",
            name = L["taskResetColor"],
            order = 45,
            func = function(info) 
                    displayOptions.taskDefaultColor = Tasks:RGBToHex(1,1,1,1)
                    Tasks:Fire("Tasks-TaskColorChanged", "defaultTask", db.global.lists[db.global.editListId])
                   end,
          },
          taskDefaultColorResetTasks = {
            type = "execute",
            name = L["taskResetColorTasks"],
            order = 50,
            func = function(info) 
                     for _,v in pairs(db.global.lists[db.global.editListId].tasks) do
                       v.displayOptions.color = nil
                     end
                     Tasks:Fire("Tasks-TaskColorChanged", "defaultTask", db.global.lists[db.global.editListId])
                   end,
          },
        },
      },
      charactersGroup = {
        type = "group",
        name = L["characters"],
        order = 60,
        hidden = function(info) return db.global.editListId == nil end,
        args = { 
          characterSelectionType = {
            type = "select",
            name = L["characterSelection"],
            desc = L["characterSelectionDesc"],
            order = 10,
            values = {
              [Tasks.constants.CHARACTERS_ALL] = L["allCharacters"], 
              [Tasks.constants.CHARACTERS_SPECIFIC] = L["specificCharacters"], 
              [Tasks.constants.CHARACTERS_CRITERIA] = L["criteriaCharacters"] 
            },
            style = "radio",
            set = function(info, val) characterOptions.selectionType = val end,
            get = function(info) return characterOptions.selectionType end,
          },
          specificCharactersGroup = {
            type = "group",
            name = function(info) return characterOptions.selectionType ~= Tasks.constants.CHARACTERS_SPECIFIC and L["selectAllCharacters"] or L["selectSpecificCharacters"] end,
            order = 20,
            inline=true,
            hidden = function(info) return characterOptions.selectionType == Tasks.constants.CHARACTERS_CRITERIA end,
            disabled = function(info) return characterOptions.selectionType ~= Tasks.constants.CHARACTERS_SPECIFIC end,
            args = {
              
            },
          },
          criteriaCharactersGroup = {
            type = "group",
            name = L["selectCriteriaCharacters"],
            order = 20,
            inline = true,
            hidden = function(info) return characterOptions.selectionType ~= Tasks.constants.CHARACTERS_CRITERIA end,
            args = {
              levelGroup = {
                type = "group",
                name = L["characterLevel"],
                order = 10,
                inline = true,
                args = {
                  levelEnabled = {
                    type = "toggle",
                    order = 10,
                    name = L["enable"],
                    get = function(info) return characterOptions.criteria.levelEnabled end,
                    set = function(info, val) characterOptions.criteria.levelEnabled = val end,
                  },
                  minLevel = {
                    type = "range",
                    name = L["minLevel"],
                    order = 20,
                    min = 1,
                    max = characterOptions and characterOptions.criteria.maxLevel or MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()],
                    step = 1,
                    disabled = function(info) return not characterOptions.criteria.levelEnabled or characterOptions.criteria.maxLevel == 1 end,
                    get = function(info) return characterOptions.criteria.minLevel end,
                    set = function(info, val)
                            characterOptions.criteria.minLevel = val
                            info.options.args.charactersGroup.args.criteriaCharactersGroup.args.levelGroup.args.maxLevel.min = val
                          end,
                  },
                  maxLevel = {
                    type = "range",
                    name = L["maxLevel"],
                    order = 30,
                    min = characterOptions and characterOptions.criteria.minLevel or 1,
                    max = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()],
                    step = 1,
                    disabled = function(info) return not characterOptions.criteria.levelEnabled or characterOptions.criteria.minLevel == MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] end,
                    get = function(info) return characterOptions.criteria.maxLevel end,
                    set = function(info, val)
                            characterOptions.criteria.maxLevel = val
                            info.options.args.charactersGroup.args.criteriaCharactersGroup.args.levelGroup.args.minLevel.max = val
                          end,
                  },
                },
              },
              classGroup = {
                type = "group",
                name = L["characterClass"],
                order = 20,
                inline = true,
                args = {
                  classEnabled = {
                    type = "toggle",
                    order = 10,
                    name = L["enable"],
                    get = function(info) return characterOptions.criteria.classEnabled end,
                    set = function(info, val) characterOptions.criteria.classEnabled = val end,
                  },
                  classShowFemale = {
                    type = "toggle",
                    order = 20,
                    name = L["showFemaleClassNames"],
                    width = "double",
                    disabled = function(info) return not characterOptions.criteria.classEnabled end,
                    hidden = not differentFemaleNames,
                    get = function(info) return characterOptions.criteria.classShowFemale end,
                    set = function(info, val) characterOptions.criteria.classShowFemale = val end,
                  },
                  classes = {
                    type = "multiselect",
                    order = 30,
                    name = L["classes"],
                    width = "normal",
                    disabled = function(info) return not characterOptions.criteria.classEnabled end,
                    values = function(info)
                               local classes = {}
                               FillLocalizedClassList(classes, characterOptions.criteria.classShowFemale)
                               for k,v in pairs(classes) do
                                 formatStr = characterOptions.criteria.classEnabled and "|c"..RAID_CLASS_COLORS[k].colorStr.."%s|r" or "%s"
                                 classes[k] = formatStr:format(v)
                               end
                               return classes
                             end,
                    get = function(info, key)
                            return characterOptions.criteria.classes[key]
                          end,
                    set = function(info, key, val)
                            characterOptions.criteria.classes[key] = val
                          end,
                  },
                },
              },
              raceGroup = {
                type = "group",
                name = L["characterRace"],
                order = 30,
                inline = true,
                args = {
                  raceEnabled = {
                    type = "toggle",
                    order = 10,
                    name = L["enable"],
                    get = function(info) return characterOptions.criteria.raceEnabled end,
                    set = function(info, val) characterOptions.criteria.raceEnabled = val end,
                  },
                  races = {
                    type = "multiselect",
                    order = 20,
                    name = L["races"],
                    width = "normal",
                    disabled = function(info) return not characterOptions.criteria.raceEnabled end,
                    values = localizedRacesLookup, 
                    get = function(info, key)
                            return characterOptions.criteria.races[key]
                          end,
                    set = function(info, key, val)
                            characterOptions.criteria.races[key] = val
                          end,
                  },
                },
              },
            },
          },
        },
      },
    },
  }
  
  editListTasksArgs = taskListsOptionsTable.args.editListTasksGroup.args
  Tasks:updateDynamicConfigs()
  
  --{ create character selection groups
  local tempArgs = taskListsOptionsTable.args.charactersGroup.args.specificCharactersGroup.args
  local count = 10
  for realm, chars in Tasks:OrderedRealms() do
    local option = {
      type = "multiselect",
      name = realm,
      order = count,
      values = function(info) 
                 local ret, color = {}, nil
                 for _,v in pairs(chars) do
                   formatStr = characterOptions.selectionType ~= Tasks.constants.CHARACTERS_SPECIFIC and "%s" or "|c"..RAID_CLASS_COLORS[db.global.characters[v].class].colorStr.."%s|r"
                   ret[v] = formatStr:format(db.global.characters[v].name)--"|c"..RAID_CLASS_COLORS[v.class].colorStr..k.."|r"
                 end
                 return ret
               end,
      get = function(info, key)
              if characterOptions.selectionType ~= Tasks.constants.CHARACTERS_SPECIFIC then return true end
              return characterOptions.characters[key]
            end,
      set = function(info, key, val)
              characterOptions.characters[key] = val
            end,
    }
    count = count + 1   
    tempArgs["characterSelection"..realm] = option    
  end
  --}
  
  
  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Tasks-TaskLists", taskListsOptionsTable)
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tasks-TaskLists", L["taskLists"], L["tasks"])
  
  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(
    "Tasks-TaskItems", 
    {type = "group",
      name = "Tasks",
      args={
      },
    }
  )
  --LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tasks-TaskItems", L["tasks"], L["tasks"])
 
  --{ Popups
  if not StaticPopupDialogs["TASKS_CREATENEWTASKLIST"] then
    StaticPopupDialogs["TASKS_CREATENEWTASKLIST"] = {
      text = L["promptNewTaskList"],
      button1 = ACCEPT,
      button2 = CANCEL,
      OnAccept = function(self)
        Tasks:addNewList(self.editBox:GetText())
      end,
      OnShow = function(self)
        self.button1:Disable()
      end,
      EditBoxOnTextChanged = function (self, data)
        if self:GetText():len() > 1 then
          self:GetParent().button1:Enable()
        else
          self:GetParent().button1:Disable()
        end
      end,
      EditBoxOnEnterPressed = function(self)
        if ( self:GetParent().button1:IsEnabled() ) then
          Tasks:addNewList(self:GetParent().editBox:GetText())
          self:GetParent():Hide()
        end
      end,
      EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
      hasEditBox = true,
      hideOnEscape = true,
    }
  end
  
  if not StaticPopupDialogs["TASKS_CREATENEWTASK"] then
    StaticPopupDialogs["TASKS_CREATENEWTASK"] = {
      text = L["promptNewTask"],
      button1 = ACCEPT,
      button2 = CANCEL,
      OnAccept = function(self)
        Tasks:addNewTask(self.editBox:GetText(), db.global.editListId)
      end,
      OnShow = function(self)
        self.button1:Disable()
      end,
      EditBoxOnTextChanged = function (self, data)
        if self:GetText():len() > 1 then
          self:GetParent().button1:Enable()
        else
          self:GetParent().button1:Disable()
        end
      end,
      EditBoxOnEnterPressed = function(self)
        if ( self:GetParent().button1:IsEnabled() ) then
          Tasks:addNewTask(self:GetParent().editBox:GetText(), db.global.editListId)
          self:GetParent():Hide()
        end
      end,
      EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
      hasEditBox = true,
      hideOnEscape = true,
    }
  end
  --}
  
  --first time open to category fails 
  --just opens interface options, doesn't route), 
  --so open and close interface options on 
  --load to make it work when /tasks is typed....
  InterfaceOptionsFrame_Show()
  InterfaceOptionsFrame_Show()
end

function Tasks:updateDynamicConfigs()
  if (db.global.editListId) then
    
    characterOptions = db.global.lists[db.global.editListId].characterOptions
    displayOptions = db.global.lists[db.global.editListId].displayOptions
    
    local args = editListTasksArgs
    local taskList = db.global.lists[db.global.editListId].tasks
    
    for k in pairs(args) do
      args[k] = nil
    end
    
    args.newTask = {
      type = "execute",
      name = L["createNewTask"],
      order = 10,
      func = "popupNewTask",
    }
    args.reorderTasks = {
      type = "execute",
      name = L["reorderTasks"],
      order = 20,
      func = "reorderTasks",
    }
    if(db.global.lists[db.global.editListId].tasks) then 
      for k,v in Tasks:OrderedTasks(db.global.lists[db.global.editListId].tasks) do 
        args[k.."group"] = {}
        local t = args[k.."group"]
        t.type = "group"
        t.name = function(info) return taskList[k].name end
        t.order = v.order + 20
	    t.inline = false
        t.args = {
          editTaskName = {
            type = "input",
            name = L["name"],
            order = 10,
            set = function(info,val) taskList[k].name = val end,
            get = function(info) return taskList[k].name end,
          },
          taskBreak = {
            type = "description",
            name = "",
            order = 15,
          },
          taskDefaultColor = {
            type = "color",
            name = L["taskColor"] ,
            order = 20,
            set = function(info, r, g, b, a) 
                    v.displayOptions.color = Tasks:RGBToHex(r, g, b, a)
                    Tasks:Fire("Tasks-TaskColorChanged", "task", v)
                  end,
            get = function(info) 
                    return Tasks:HexToRGB(v.displayOptions.color or db.global.lists[v.listId].displayOptions.taskDefaultColor) 
                  end,
          },
          taskDefaultColorReset = {
            type = "execute",
            name = L["taskResetColor"] ,
            order = 30,
            disabled = function(info) return not v.displayOptions.color end,
            func = function(info) 
                    v.displayOptions.color = nil
                    Tasks:Fire("Tasks-TaskColorChanged", "task", v)
                   end,
          },
          deleteTask = {
            type = "execute",
            name = L["deleteTask"],
            order = 100,
            func = "deleteTask",
            confirm = function(info) return L["confirmTaskDelete"]:format(taskList[k].name) end,
            arg = k
          },
        }
      end
    end
  end
end

function Tasks:ChatCommandReceived(msg)
  InterfaceOptionsFrame_OpenToCategory(L["taskLists"])
end

function Tasks:popupNewList()
  StaticPopup_Show("TASKS_CREATENEWTASKLIST")
end

function Tasks:popupNewTask()
  StaticPopup_Show("TASKS_CREATENEWTASK")
end

function Tasks:deleteEditList()
  local order = db.global.lists[db.global.editListId].order
  for _,v in pairs(db.global.lists) do
    if v.order > order then
      v.order = v.order - 1
    end
  end
  db.global.lists[db.global.editListId] = nil
  db.global.listCount = db.global.listCount - 1
  db.global.editListId = nil
end

function Tasks:deleteTask(info)
  local order = db.global.lists[db.global.editListId].tasks[info.arg].order
  for _,v in pairs(db.global.lists[db.global.editListId].tasks) do
    if v.order > order then
      v.order = v.order - 1
    end
  end
  db.global.lists[db.global.editListId].tasks[info.arg] = nil
  db.global.lists[db.global.editListId].taskCount = db.global.lists[db.global.editListId].taskCount - 1
  self:updateDynamicConfigs()
end

function Tasks:addNewList(newName)
  local newId = "list"..self:NextId()
  db.global.lists[newId].name = newName;
  db.global.lists[newId].id = newId;
  db.global.lists[newId].order = db.global.listCount;
  db.global.listCount = db.global.listCount + 1
  db.global.editListId = newId
  self:updateDynamicConfigs()
  LibStub("AceConfigRegistry-3.0"):NotifyChange("Tasks-TaskLists")
end

function Tasks:addNewTask(newName)
  local newId = "task"..self:NextId()
  local list = db.global.lists[db.global.editListId]
  list.tasks[newId].name = newName;
  list.tasks[newId].id = newId;
  list.tasks[newId].listId = db.global.editListId;
  list.tasks[newId].order = list.taskCount
  list.taskCount = list.taskCount + 1
  self:updateDynamicConfigs()
  LibStub("AceConfigRegistry-3.0"):NotifyChange("Tasks-TaskLists")
end

--next two functions taken from http://www.wowwiki.com/User_defined_functions and modified to support alpha
function Tasks:HexToRGB(hex)
	local ahex, rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6), string.sub(hex, 7, 8)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, tonumber(ahex, 16)/255
end

function Tasks:RGBToHex(r, g, b, a)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	a = a <= 1 and a >= 0 and a or 1
	return string.format("%02x%02x%02x%02x", a*255, r*255, g*255, b*255)
end