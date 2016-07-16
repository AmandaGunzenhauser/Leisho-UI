Tasks = LibStub("AceAddon-3.0"):NewAddon("Tasks", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
Tasks.L = LibStub("AceLocale-3.0"):GetLocale("Tasks", false)
Tasks.callbacks = setmetatable({}, {__index = function(tbl, key) tbl[key] = {} return tbl[key] end})


function Tasks:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("TasksDB", self.defaults["db"], true)
  self:UpgradeDBVersion()
  
  --retrieve and store character info
  local realm = GetRealmName()
  local char = UnitName("player") .. " - " .. realm
  -- local char =  GetUnitName("player", true")
  self.currentChar = char
  self.db.global.characters[char].name = UnitName("player")
  self.db.global.characters[char].realm = realm
  self.db.global.characters[char].class = select(2,UnitClass("player"))
  self.db.global.characters[char].level = UnitLevel("player")
  self.db.global.characters[char].race = select(2, UnitRace("player"))
  self.db.global.characters[char].faction = UnitFactionGroup("player")
  
  self.db.global.realms[realm] = self.db.global.realms[realm] or { }
  local found = false
  for _,v in pairs(self.db.global.realms[realm]) do
    if v == char then found = true break end
  end
  if not found then 
    table.insert(self.db.global.realms[realm], char) 
    table.sort(self.db.global.realms[realm]) 
  end
  
  --initialize various modules
  self:Fire("Tasks-Initialize")
end

function Tasks:OnEnable()
  --self:CheckReset()
end

function Tasks:OnDisable()

end

function Tasks:UpgradeDBVersion()
  if not(self.db.global.dbVersion) then
    self.db.global.dbVersion = self.constants.CURRENT_DB_VERSION
    return
  end
  
  if(self.db.global.dbVersion == self.constants.CURRENT_DB_VERSION) then return end
  
  if(self.db.global.dbVersion == 1) then
    self.db.global.encounters = nil
    self.db.global.dbVersion = 2
  end
  
  if(self.db.global.dbVersion == 2) then
    for k,v in pairs(self.db.global.lists) do
      v.id = k
      for k2,v2 in pairs(v.tasks) do
        v2.id = k2
        v2.listId = k
      end
    end
    self.db.global.editTask = nil
    self.db.global.dbVersion = 3
  end
  
  if(self.db.global.dbVersion == 3) then
    local listCount = 0
    for k,v in pairs(self.db.global.lists) do
      v.order = listCount
      listCount = listCount + 1
    end
    self.db.global.listCount = listCount
    self.db.global.dbVersion = 5
  end
  
  if(self.db.global.dbVersion == 4) then
    for k,v in pairs(self.db.global.lists) do
      v.order = v.order -1
    end
    self.db.global.dbVersion = 5
  end
  
  if(self.db.global.dbVersion == 5) then
    for k,v in pairs(self.db.global.characters) do
      self.db.global.realms[v.realm] = self.db.global.realms[v.realm] or { }
      table.insert(self.db.global.realms[v.realm], k)
    end
    self.db.global.dbVersion = 6
  end
  
  if(self.db.global.dbVersion == 6) then
    self.db.global.editListId = self.db.global.editList
    self.db.global.editList = nil
    self.db.global.dbVersion = 7
  end
end