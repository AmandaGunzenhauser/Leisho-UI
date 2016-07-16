local Tasks = Tasks
local L = Tasks.L
local db, _, displayOptions
local itemFramePool, headerFramePool, frameLookup = {}, {}, {}
local taskFrameCount, headerFrameCount = 1,1
local suppressRedraw = false

Tasks:RegisterCallback("Tasks-Initialize", "DisplayInit", 1)

function Tasks:DisplayInit()
  db = Tasks.db
  displayOptions = db.global.displayOptions
  self:CreateTasksFrame()
  
  Tasks:RegisterCallback("Tasks-TaskCompleted", "DisplayTaskCompleted")
  Tasks:RegisterCallback("Tasks-TaskReset", "DisplayTaskReset")
  Tasks:RegisterCallback("Tasks-TaskListCompleted", "DisplayTaskListCompleted")
  Tasks:RegisterCallback("Tasks-TaskListReset", "DisplayTaskListReset")
  Tasks:RegisterCallback("Tasks-EnabledChanged", "DisplayEnabledChanged")
  Tasks:RegisterCallback("Tasks-HideCompletedChanged", "DisplayHideCompletedChanged")
  Tasks:RegisterCallback("Tasks-TaskResettingStart", "DisplayTaskResettingStart")
  Tasks:RegisterCallback("Tasks-TaskResettingEnd", "DisplayTaskResettingEnd")
  Tasks:RegisterCallback("Tasks-TaskColorChanged", "DisplayTaskColorChanged")
end

-- self.TasksFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
--                                           --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
--                                           tile = true, tileSize = 16, edgeSize = 16, 
--                                           insets = { left = 4, right = 4, top = 4, bottom = 4 }});

function Tasks:CreateTasksFrame()
  local frameSettings = displayOptions.frameSettings
  self.TasksFrame = CreateFrame("Button","TasksFrame",UIParent, "TasksTemplate")
  if not frameSettings.locked then Tasks.TasksFrame:RegisterForDrag("LeftButton")
  else Tasks.TasksFrame:RegisterForDrag() end
  self.TasksFrame:RegisterForDrag("LeftButton")
  self.TasksFrame:SetPushedTextOffset(0,0)

  self.TasksFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            });

  self.TasksFrame:SetBackdropColor(0,0,255,0);
  
  self.TasksFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            });

  self.TasksFrame:SetBackdropColor(255,0,255,0);
  --set a default location. if user moves it, blizzard will save to layout-local.txt and restore automatically
  self.TasksFrame:SetPoint("CENTER", UIParent, "CENTER", 300, 380)

  self:RedrawTaskListFrames()
end

function Tasks:NewItemFrame(taskId, task, listFrame)
  local tempFrame = frameLookup[taskId]
  if tempFrame then return tempFrame end
  if table.getn(itemFramePool) > 0 then
    tempFrame = itemFramePool[1]
    tempFrame:SetParent(listFrame.childrenFrame)
    table.remove(itemFramePool,1)
  else
    tempFrame = CreateFrame("Frame","TasksItemFrame"..taskFrameCount,listFrame.childrenFrame, "TasksItemTemplate")
    tempFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            })
    
    tempFrame:SetBackdropColor(255,255,0,0)
    tempFrame:SetAlpha(1.0)
    taskFrameCount = taskFrameCount+1
  end
  tempFrame.task = task
  frameLookup[taskId] = tempFrame
  return tempFrame
end

function Tasks:NewHeaderFrame(listId,list)
  local tempFrame = frameLookup[listId]
  if tempFrame then return tempFrame end
  if table.getn(headerFramePool) > 0 then
    tempFrame = headerFramePool[1]
    table.remove(headerFramePool,1)
  else
    tempFrame = CreateFrame("Frame","TasksHeaderFrame"..headerFrameCount, self.TasksFrame, "TasksHeaderTemplate")
    tempFrame.childrenFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            })
    
    tempFrame.childrenFrame:SetBackdropColor(255,0,0,0)
    tempFrame:SetAlpha(1.0)
    headerFrameCount = headerFrameCount+1

    tempFrame.childrenFrame.origSetHeight = tempFrame.childrenFrame.SetHeight
    function tempFrame.childrenFrame:SetHeight(newHeight)
      self:origSetHeight(newHeight)
      self:GetParent():SetHeight(newHeight+15)
    end
  end
  tempFrame.children = {}
  tempFrame.list = list
  frameLookup[listId] = tempFrame
  return tempFrame
end

function Tasks:RedrawTaskListFrames()
  if not suppressRedraw then 
    local anchorFrame = Tasks.TasksFrame
    for _,v in pairs(frameLookup) do
      if v.list then
        Tasks:ReleaseHeaderFrame(v)
      else
        Tasks:ReleaseTaskFrame(v)
      end
    end
    local headerTemp
    for listId, list in Tasks:OrderedTaskLists(db.global.lists) do
      if (not displayOptions.hideCompletedTasks or not Tasks:IsTaskListComplete(list)) then 
        local listHeaderFrame = Tasks:NewHeaderFrame(listId, list)
        listHeaderFrame:SetPoint("TOPLEFT", headerTemp or anchorFrame, "BOTTOMLEFT", 0, 0)
        listHeaderFrame:Show()
        
        if headerTemp then headerTemp.nextHeaderFrame = listHeaderFrame end
        listHeaderFrame.prevHeaderFrame = headerTemp
        
        anchorFrame = listHeaderFrame.childrenFrame
        headerTemp = listHeaderFrame
        
        --create tasks
        local taskTemp
        for taskId, task in Tasks:OrderedTasks(list.tasks) do
          if (not displayOptions.hideCompletedTasks or not task.completedChars[Tasks.currentChar].completed) then
            local taskFrame = Tasks:NewItemFrame(taskId, task, listHeaderFrame)
            taskFrame:SetPoint("TOPLEFT", anchorFrame, listHeaderFrame.firstTask and "BOTTOMLEFT" or "TOPLEFT", 0, 0)
            taskFrame:Show()
            listHeaderFrame.firstTask = listHeaderFrame.firstTask or taskFrame
            listHeaderFrame.lastTask = taskFrame
            table.insert(listHeaderFrame.children,taskFrame)
            if taskTemp then taskTemp.nextTaskFrame = taskFrame end
            taskFrame.prevTaskFrame = taskTemp
            
            taskFrame.listFrame = listHeaderFrame
            anchorFrame = taskFrame
            taskTemp = taskFrame
            listHeaderFrame.childrenFrame:SetHeight(listHeaderFrame.childrenFrame:GetHeight()+15)
          end
        end
        
        if not list.displayOptions.expanded then
          listHeaderFrame.childrenFrame:SetHeight(0)
          listHeaderFrame.childrenFrame:Hide()
        end
      end
    end
  end
end


function Tasks:DisplayTaskCompleted(task)
  frameLookup[task.id].checkbox:SetChecked(true)
    
  --check other tasks complete also to mark off list
  local list = db.global.lists[task.listId]
  local allDone = Tasks:IsTaskListComplete(db.global.lists[task.listId])
  if allDone then
    frameLookup[task.listId].checkbox:SetChecked(true)
  end
  
  --hide tasks if option enabled
  if(displayOptions.hideCompletedTasks) then
    Tasks:HideTask(task)
    if allDone then
      Tasks:HideTaskList(list)
    end
    --listHeaderFrame.childrenFrame:SetHeight(listHeaderFrame.childrenFrame:GetHeight()+15)
  end
end

function Tasks:DisplayTaskListCompleted(list)
  for k,v in pairs(list.tasks) do
    if not v.completedChars[self.currentChar].completed then
      Tasks:Fire("Tasks-TaskCompleted", v)
    end
  end
end

function Tasks:ReleaseTaskFrame(frame)
  frame:ClearAllPoints()
  frame.listFrame = nil
  frame.nextTaskFrame = nil
  frame.prevTaskFrame = nil
  frameLookup[frame.task.id] = nil
  frame.task = nil
  frame:Hide()
  table.insert(itemFramePool, frame)  
end

function Tasks:ReleaseHeaderFrame(frame)
  frame:ClearAllPoints()
  frame.children = nil
  frame.lastTask = nil
  frame.firstTask = nil
  frame.nextHeaderFrame = nil
  frame.prevHeaderFrame = nil
  frame.nextHeaderFrame = nil
  frameLookup[frame.list.id] = nil
  frame.list = nil
  frame.childrenFrame:SetHeight(0)
  frame:Hide()
  table.insert(headerFramePool, frame) 
end

--{ Hide/Show functionality

function Tasks:HideTask(task)
  local taskFrame = frameLookup[task.id]
  
  --update frame pointers and reanchor
  if (taskFrame.listFrame.firstTask == taskFrame) then
    taskFrame.listFrame.firstTask = taskFrame.nextTaskFrame
  end
  if taskFrame.prevTaskFrame then 
    taskFrame.prevTaskFrame.nextTaskFrame = taskFrame.nextTaskFrame
  end
  if taskFrame.nextTaskFrame then
    taskFrame.nextTaskFrame.prevTaskFrame = taskFrame.prevTaskFrame
    taskFrame.nextTaskFrame:ClearAllPoints()
    taskFrame.nextTaskFrame:SetPoint("TOPLEFT", taskFrame.prevTaskFrame or taskFrame.listFrame.childrenFrame, taskFrame.prevTaskFrame and "BOTTOMLEFT" or "TOPLEFT", 0, 0)
  end
  if (taskFrame.listFrame.lastTask == taskFrame) then
    taskFrame.listFrame.lastTask = taskFrame.prevTaskFrame
  end
  
  for i=1,table.getn(taskFrame.listFrame.children) do
    if(taskFrame.listFrame.children[i] == taskFrame) then
      table.remove(taskFrame.listFrame.children, i)
      break
    end
  end

  taskFrame.listFrame.childrenFrame:SetHeight(taskFrame.listFrame.childrenFrame:GetHeight()-15)
  self:ReleaseTaskFrame(taskFrame)
end

function Tasks:HideTaskList(list)
  local listFrame = frameLookup[list.id]
  
  --update frame pointers and reanchor
  if listFrame.prevHeaderFrame then
    listFrame.prevHeaderFrame.nextHeaderFrame = listFrame.nextHeaderFrame
  end
  if listFrame.nextHeaderFrame then
    listFrame.nextHeaderFrame.prevHeaderFrame = listFrame.prevHeaderFrame
    listFrame.nextHeaderFrame:ClearAllPoints()
    listFrame.nextHeaderFrame:SetPoint("TOPLEFT", listFrame.prevHeaderFrame or self.TasksFrame, "BOTTOMLEFT", 0, 0)
  end
  self:ReleaseHeaderFrame(listFrame)
end



function Tasks:ShowTask(task)

end

function Tasks:ShowTaskList(task)

end

--}

--{ Events
function Tasks:DisplayTaskReset(task)
  Tasks:RedrawTaskListFrames()
end

function Tasks:DisplayTaskListReset(list)
  suppressRedraw = true
  for _,v in pairs(list.tasks) do
    Tasks:Fire("Tasks-TaskReset", v)
  end
  suppressRedraw = false
  Tasks:RedrawTaskListFrames()
end

function Tasks:DisplayEnabledChanged(enabled)
  if enabled then
    Tasks.TasksFrame:Show()
  else
    Tasks.TasksFrame:Hide()
  end
end

function Tasks:DisplayHideCompletedChanged(enabled)
  Tasks:RedrawTaskListFrames()
end

function Tasks:DisplayTaskResettingStart()
  suppressRedraw = true
end

function Tasks:DisplayTaskResettingEnd()
  suppressRedraw = false
  Tasks:RedrawTaskListFrames()
end

function Tasks:DisplayTaskColorChanged(mode, object)
  if mode == "list" then
    Tasks:UpdateHeaderText(object)
  elseif mode == "task" then
    Tasks:UpdateTaskText(object)
  elseif mode == "defaultTask" then
    for _,v in pairs(object.tasks) do
      Tasks:UpdateTaskText(v)
    end
  end
end
--}

function Tasks:TaskHeaderClicked(button)
  local list = button:GetParent().list
  if list.displayOptions.expanded then
    --hide the list
    list.displayOptions.expanded = false
    Tasks:UpdateHeaderText(list)
    --_G[button:GetParent():GetName() .. "_CheckButtonText"]:SetText("|cFF76DEAF + "..list.name.."|r")
    button:GetParent().childrenFrame:SetHeight(0)
    button:GetParent().childrenFrame:Hide()
  else
    --show the list
    list.displayOptions.expanded = true
    Tasks:UpdateHeaderText(list)
    --_G[button:GetParent():GetName() .. "_CheckButtonText"]:SetText("|cFF76DEAF - "..list.name.."|r")
    button:GetParent().childrenFrame:SetHeight(table.getn(button:GetParent().children)*15)
    button:GetParent().childrenFrame:Show()
  end
end

function Tasks:UpdateHeaderText(list)
  if frameLookup[list.id] then 
    local expandedText = (list.displayOptions.expanded and "-" or "+")
    frameLookup[list.id].checkbox.expanderText:SetText("|c"..list.displayOptions.color..expandedText.."|r")
    frameLookup[list.id].checkbox.text:SetText("|c"..list.displayOptions.color..list.name.."|r")
  end 
end

function Tasks:UpdateTaskText(task)
  if frameLookup[task.id] then
    local color = task.displayOptions and task.displayOptions.color or db.global.lists[task.listId].displayOptions.taskDefaultColor
    frameLookup[task.id].checkbox.text:SetText("|c"..color..task.name.."|r")
  end
end

--{ Task Iterators

local function __genOrderedIndexTaskList( t )
  local orderedIndex = {}
  for key in pairs(t) do
    table.insert( orderedIndex, key )
  end
  table.sort( orderedIndex, function(a,b)
                              return t[a].order < t[b].order
                            end)
  return orderedIndex
end

local function orderedNextTaskList(t, state)
  local key = nil
  if state == nil then
    -- the first time, generate the index
    t.__orderedIndex = __genOrderedIndexTaskList( t )
    key = t.__orderedIndex[1]
  else
    -- fetch the next value
    for i = 1,table.getn(t.__orderedIndex) do
      if t.__orderedIndex[i] == state then
        key = t.__orderedIndex[i+1]
      end
    end
  end
  
  if key then
    return key, t[key]
  end
  
  t.__orderedIndex = nil
  return
end

function Tasks:OrderedTaskLists(t)
    return orderedNextTaskList, t, nil
end

local function __genOrderedIndexTask( t )
  local orderedIndex = {}
  for key in pairs(t) do
    table.insert( orderedIndex, key )
  end
  table.sort( orderedIndex, function(a,b)
                              return t[a].order < t[b].order
                            end)
  return orderedIndex
end

local function orderedNextTask(t, state)
  local key = nil
  if state == nil then
    -- the first time, generate the index
    t.__orderedIndex = __genOrderedIndexTask( t )
    key = t.__orderedIndex[1]
  else
    -- fetch the next value
    for i = 1,table.getn(t.__orderedIndex) do
      if t.__orderedIndex[i] == state then
        key = t.__orderedIndex[i+1]
      end
    end
  end
  
  if key then
    return key, t[key]
  end
  
  t.__orderedIndex = nil
  return
end

function Tasks:OrderedTasks(t)
    return orderedNextTask, t, nil
end
--}