local Engine, Api, Locale, Settings = unpack(AshranBuddy)

Engine.Core = {}

-- debug
Engine.Core.Debug = function (message, ...)
	if Settings:IsDebug() then
		print("|cffffbb00" .. Engine.AddOnName .. ": |cffffffff" .. message, ...)
	end
end

-- math.roundup
Engine.Core.MathRoundUp = function(a, precision)
	return tonumber(string.format("%." .. (precision or 0) .. "f", a))
end

-- string.lastindexof
Engine.Core.StringLastIndexOf = function(self, a)
	local i = self:match(".*"..a.."()")
    if i == nil then
		return nil
	else
		return i - 1
	end
end

-- table.contains
Engine.Core.TableContains = function(self, a)
	for _, value in pairs(self) do
		if (value == a) then
			return true
		end
	end
	return false
end

-- table.indexof
Engine.Core.TableIndexOf = function(self, item)
	for i = 1, #self do
		if (self[i] == item) then
			return i
		end
	end
	return -1
end