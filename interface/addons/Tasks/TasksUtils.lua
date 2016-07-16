local Tasks = Tasks
local L = Tasks.L
local db

function Tasks:UtilsInit()
  db = Tasks.db
end

--deepcopy function from http://lua-users.org/wiki/CopyTable
function Tasks:deepCopy(orig, level)
level = level or 0
if level == 5 then return end
  local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[orig_key] = self:deepCopy(orig_value, level +1)
        end
        --setmetatable(copy, self:deepCopy(getmetatable(orig), level +1))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Tasks:keyCount(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Tasks:printKeys(T)
  for k in pairs(T) do print(tostring(k)) end
end

function Tasks:NextId()
  db.global.id = db.global.id + 1
  return db.global.id - 1
end

--{ Callback management
function Tasks:Fire(event, ...)
  for k in Tasks:OrderedTaskCallbacks(Tasks.callbacks[event]) do
    loadstring('Tasks:'..k..'(...)')(...)
  end
end

function Tasks:RegisterCallback(event, method, priority)
  if not priority then priority = 0 end
  Tasks.callbacks[event][method] = priority
end

function Tasks:UnregisterCallback(event, method)
  Tasks.callbacks[event][method]= nil
end
Tasks:RegisterCallback("Tasks-Initialize", "UtilsInit", 1)
--}

--{ Iterators
  --{ Prioritized Callbacks
    local function __genOrderedIndexTaskCallback( t )
        local orderedIndex = {}
        for key in pairs(t) do
            table.insert( orderedIndex, key )
        end
        table.sort( orderedIndex, function(a,b)
                                    return t[a] > t[b]
                                  end)
        return orderedIndex
    end
    
    local function orderedNextTaskCallback(t, state)
      local key = nil
      if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndexTaskCallback( t )
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
    
    function Tasks:OrderedTaskCallbacks(t)
        return orderedNextTaskCallback, t, nil
    end
  --}

  --{ Ordered Task Lists
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
  --}

  --{ Ordered Strings (alpha)
    local function __genOrderedIndexRealm( t )
      local orderedIndex = {}
      for key in pairs(t) do
        table.insert( orderedIndex, key )
      end
      table.sort( orderedIndex, function(a,b)
                                  return a < b
                                end)
      return orderedIndex
    end
    
    local function orderedNextRealm(t, state)
      local key = nil
      if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndexRealm( t )
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
    
    function Tasks:OrderedRealms()
        return orderedNextRealm, db.global.realms, nil
    end
  --}
--}