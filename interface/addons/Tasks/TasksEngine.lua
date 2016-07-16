local Tasks = Tasks
local L = Tasks.L
local db, _

Tasks:RegisterCallback("Tasks-Initialize", "EngineInit")

--[[
GARRISON_RECRUITMENT_NPC_OPENED
GARRISON_RECRUITMENT_NPC_CLOSED
GARRISON_RECRUITMENT_FOLLOWERS_GENERATED
GARRISON_RECRUITMENT_FOLLOWER_RESULT
--]]

function Tasks:EngineInit()
  db = Tasks.db
  self:RegisterEvent("ENCOUNTER_START")
  self:RegisterEvent("ENCOUNTER_END")
  self:RegisterEvent("PLAYER_LEVEL_UP")
  self:CheckFirstTimeResets()
  self.resetTimer = self:ScheduleRepeatingTimer("CheckReset", 60)
  
  Tasks:RegisterCallback("Tasks-TaskCompleted", "EngineTaskCompleted", 1)
  Tasks:RegisterCallback("Tasks-TaskReset", "EngineTaskReset")
end

function Tasks:ENCOUNTER_START(eventName, encounterId, encounterName, difficulty, raidSize)
  --db.global.encounters[tostring(encounterId)] = encounterName
end
function Tasks:ENCOUNTER_END(eventName, encounterId, encounterName, difficulty, raidSize, endStatus)
  
end

function Tasks:PLAYER_LEVEL_UP(eventName, newLevel)
  db.global.characters[Tasks.currentCharacter].level = newLevel
end

local function GetNextDailyReset()
  return time() + GetQuestResetTime()
end

local function GetNextWeeklyReset()
  local nextDailyReset = GetNextDailyReset()
  local daysToReset = db.global.resetOptions.weeklyResetDay - date("*t", nextDailyReset).wday
  if daysToReset < 0 then daysToReset = daysToReset + 7 end
  return nextDailyReset + daysToReset * 24 * 60 * 60
end

function Tasks:CheckReset()
  Tasks:Fire("Tasks-TaskResettingStart")
  if time() > db.global.nextDailyReset then 
    self:ResetTasks(Tasks.constants.DAILY_RESET)
    db.global.nextDailyReset = GetNextDailyReset()
    print ("Daily Tasks Reset!")
  end
  if time() > db.global.nextWeeklyReset then 
    self:ResetTasks(Tasks.constants.WEEKLY_RESET)
    db.global.nextWeeklyReset = GetNextWeeklyReset()
    print ("Weekly Tasks Reset!")
  end
  Tasks:Fire("Tasks-TaskResettingEnd")
end

function Tasks:ResetEverything()
  Tasks:Fire("Tasks-TaskResettingStart")
  self:ResetTasks(Tasks.constants.DAILY_RESET)
  self:ResetTasks(Tasks.constants.WEEKLY_RESET)
  Tasks:Fire("Tasks-TaskResettingEnd")
end

function Tasks:ResetTasks(frequency)
  for _,list in pairs(db.global.lists) do
    if(list.resetFrequency == frequency) then
      for _,task in pairs(list.tasks) do
        Tasks:Fire("Tasks-TaskReset", task)
      end
    end
  end
end

function Tasks:CheckFirstTimeResets()
  if not db.global.nextWeeklyReset then
    db.global.nextWeeklyReset = GetNextWeeklyReset()
  end
  if not db.global.nextDailyReset then
    db.global.nextDailyReset = GetNextDailyReset()
  end
end

function Tasks:EngineTaskCompleted(task)
  task.completedChars[self.currentChar].completed = true
  task.completedChars[self.currentChar].timestamp = time()
end

function Tasks:EngineTaskReset(task)
  for k in pairs(task.completedChars) do
    task.completedChars[k].completed = false
    task.completedChars[k].timestamp = nil
  end
end

function Tasks:IsTaskListComplete(list, char)
  if not char then char = Tasks.currentChar end
  for _,v in pairs(list.tasks) do
    if not v.completedChars[char].completed then
      return false
    end
  end
  return true
end