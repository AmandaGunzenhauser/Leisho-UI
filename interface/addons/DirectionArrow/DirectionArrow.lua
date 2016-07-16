--[[

Copyright 2008-∞ Daniel Ceregatti (daniel@ceregatti.org)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.

Special thanks to:

Shefki
Adys
kagaro

And everyone else in #wowace on irc.freenode.org

]]--

-- Locale variable
local L = LibStub("AceLocale-3.0"):GetLocale("DirectionArrow", false)

-- LibMapData-1.0 for zone sizes
local mapfiles = LibStub("LibMapData-1.0")
local width = 100
local height = 100

local current_unit = "group0"
local current_guid = nil
local current_frame = nil
local frame = nil
local frame_name = nil
local DistanceMetric = L["yards"]

local s2 = sqrt(2)
local cos, sin, rad, atan2, sqrt = math.cos, math.sin, math.rad, math.atan2, math.sqrt
local strfind = string.find
local GetPlayerFacing, GetPlayerMapPosition, GetMouseFocus, SecureButton_GetModifiedUnit, UnitIsUnit =
  GetPlayerFacing, GetPlayerMapPosition, GetMouseFocus, SecureButton_GetModifiedUnit, UnitIsUnit

--[===[@debug@
local function pp (arg)
  if DirectionArrow.db.profile.debug then
    print (arg)
  end
end
--@end-debug@]===]

local function CalculateCorner (r)
  return 0.5 + cos(r) / s2, 0.5 + sin(r) / s2;
end

local function RotateTexture (texture, angle)
  local LRx, LRy = CalculateCorner (angle + 0.785398163);
  local LLx, LLy = CalculateCorner (angle + 2.35619449);
  local ULx, ULy = CalculateCorner (angle + 3.92699082);
  local URx, URy = CalculateCorner (angle - 0.785398163);
  texture:SetTexCoord (ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

local function GetBearing (unit)
  tx, ty = GetPlayerMapPosition (unit)
  if tx == 0 and ty == 0 then
    --[===[@debug@
    pp (format ("Unable to obtain the position for unit %s", unit))
    --@end-debug@]===]
    return 999
  end
  px, py = GetPlayerMapPosition ("player")
  return -GetPlayerFacing () - atan2 (tx - px, py - ty)
end

function DistanceCalculator ()
  return sqrt ((((tx - px) * width) ^ 2) + (((ty - py) * height) ^ 2))
end

local function CanShow (unit)
  local bearing = GetBearing (unit)
  if bearing == 999 then
    return false
  end
  return true
end

local function OnUpdate (self, elapsed)
  self.elapsed = self.elapsed + elapsed
  if (self.elapsed > DirectionArrow.db.profile.update_frequency) then
    self.elapsed = 0
    local bearing = GetBearing (current_unit)
    if bearing == 999 then
      DirectionArrow.f:Hide()
      return
    end
    RotateTexture (DirectionArrow.t, bearing)
    DirectionArrow.x:SetText(format ("%d ", DistanceCalculator()))
  end
end

-- Keybindings
BINDING_HEADER_DIRECTIONARROW = "DirectionArrow"
BINDING_NAME_DIRECTIONARROW_TOGGLE = L["Sticky Tracking"]

DirectionArrow = LibStub("AceAddon-3.0"):NewAddon("DirectionArrow", "AceConsole-3.0", "AceEvent-3.0")

function DirectionArrow:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("DirectionArrowDB", DirectionArrowDefaultConfigDB, "Default")
  self.sticky = false
  self.f = CreateFrame("Button", nil, UIParent)
  self.f:SetScale(self.db.profile.size)
  self.f:SetPoint("CENTER")
  self.f:SetFrameLevel(20)
  self.f:EnableMouse(false)
  self.f:SetAlpha(self.db.profile.opacity)
  self.f:SetWidth(32)
  self.f:SetHeight(32)
  self.f:Hide()
  self.f.elapsed = 0
  self.f:SetScript("OnUpdate", OnUpdate)

  self.t = self.f:CreateTexture("OVERLAY")
  self.t:SetTexture([[Interface\Minimap\MinimapArrow]])
  self.t:SetBlendMode("BLEND")
  self.t:SetAlpha(1)
  self.t:SetAllPoints(self.f)

  self.x = self.f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  if self.db.profile.show_distance then
    self.x:Show()
  else
    self.x:Hide()
  end
  self.x:SetWidth(32)
  self.x:SetHeight(32)
  self.x:SetPoint("CENTER", self.f, "CENTER", self.db.profile.text_location_x, self.db.profile.text_location_y)
  self.x:SetTextColor(unpack (self.db.profile.distance_color))
  self.x:SetShadowOffset(.5,-.5)
  self.x:SetShadowColor(unpack (self.db.profile.distance_ds_color))
  self.x:SetAlpha(1)
  self.x:SetFont(self.x:GetFont(), self.db.profile.distance_size)

  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("DirectionArrow", DirectionArrowConfig)

  self.optionsFrames = {}
  local ACD3 = LibStub("AceConfigDialog-3.0")
  self.optionsFrames.DirectionArrow = LibStub("LibAboutPanel").new (nil, "DirectionArrow")

  -- Thanks, Omen!
  self.optionsFrames.General = ACD3:AddToBlizOptions("DirectionArrow", L["General"], "DirectionArrow", "General")
  self:RegisterChatCommand("directionarrow", function()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.General)
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.DirectionArrow)
  end)
  self:RegisterChatCommand("da", function()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.General)
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.DirectionArrow)
  end)
  self.f:SetScript ("OnEvent", function (frame,event,...) self[event] (self,...) end)
  self.f:RegisterEvent ("UPDATE_MOUSEOVER_UNIT")
  self.f:RegisterEvent ("GROUP_ROSTER_UPDATE")
  mapfiles:RegisterCallback("MapChanged", function (event, map, floor, w, h)
    --[===[@debug@
    pp (format ("Map changed. Map: %s, floor: %s, w: %s, h: %s", map, floor, w, h))
    --@end-debug@]===]
    width = w
    height = h
  end)
end

function DirectionArrow:GROUP_ROSTER_UPDATE ()
  --[===[@debug@
  pp ("GROUP_ROSTER_UPDATE fired")
  --@end-debug@]===]
--[[
  current_unit = "group0"
  local prefix = IsInRaid() and "raid" or "party"
  for i = 1, GetNumGroupMembers() do
    --[===[@debug@
    pp (format ("current_guid: %s, GUID for %d: %s", current_guid or "not set", i, UnitGUID (prefix .. i) or "not found"))
    --@end-debug@]===]
    if current_guid == UnitGUID (prefix .. i) then
      current_unit = "group" .. i
      break
    end
  end
  --[===[@debug@
  pp (format ("current_unit: %s", current_unit))
  --@end-debug@]===]
  if current_unit == "group0" or current_frame == nil then
    current_unit = "group0"
    current_guid = nil
  else


    if frame_name then
    local frame = EnumerateFrames()
    while frame do
      if frame:IsVisible () then
        local unit = SecureButton_GetModifiedUnit (frame)
        if DirectionArrow:CheckUnit (unit) then
          --[===[@debug@
          local local_frame = frame:GetName() or string.format("[Unnamed Frame: %s]", tostring(frame))
          pp (format ("Found 'unit' frame %s for unit %s", name or "none", unit or "none"))
          --@end-debug@]===]
          -- Set current_frame here when the frame we want is found
          local match1 = string.match (frame_name, "^(.+)%d+$")
          local match2 = string.match (local_frame, "^(.+)%d+$")
          --[===[@debug@
          pp (format ("match1: %s, match2: %s", match1 or "none", match2 or "none"))
          --@end-debug@]===]
          if match1 and match2 and match1 == match2 and current_guid == UnitGUID (unit) then
            current_frame = frame
            current_unit = unit
            DirectionArrow:SetArrow ()
            return
          end
        end
      end
      frame = EnumerateFrames(frame);
    end
    end
  --end


]]--
  if frame_name then
    local p = current_frame:GetParent()
    for i = 1, 40 do
      --[===[@debug@
      pp (format ("i: %d", i))
      --@end-debug@]===]
      local frame = p:GetAttribute ("child" .. i)
      if frame then
        local unit = frame:GetAttribute ("unit")
        if unit then
          local guid = UnitGUID (unit)
          if guid then
            --[===[@debug@
            pp (format ("current_guid: %s", current_guid or "none"))
            pp (format ("frame: %s, unit: %s, guid: %s", frame:GetName() or "Unnamed frame", unit or "none", guid or "none"))
            --@end-debug@]===]
            if current_guid == guid then
              current_frame = frame
              current_unit = unit
              DirectionArrow:SetArrow ()
              return
            end
          end
        end
      end
    end
    -- Default UI party and raid frames are...different
    for i = 1, 4 do
      local frame = getglobal("PartyMemberFrame" .. i)
      if frame:IsVisible () then
        local unit = SecureButton_GetModifiedUnit (frame)
        local guid = UnitGUID (unit)
        --[===[@debug@
        pp (format ("current_guid: %s", current_guid or "none"))
        pp (format ("frame: %s, unit: %s, guid: %s", frame:GetName() or "Unnamed frame", unit or "none", guid or "none"))
        --@end-debug@]===]
        if current_guid == guid then
          current_frame = frame
          current_unit = unit
          DirectionArrow:SetArrow ()
          return
        end
      end
    end
    local frame = EnumerateFrames()
    while frame do
      if frame:IsVisible () then
        local unit = SecureButton_GetModifiedUnit (frame)
        if DirectionArrow:CheckUnit (unit) then
          --[===[@debug@
          local local_frame = frame:GetName() or string.format("[Unnamed Frame: %s]", tostring(frame))
          pp (format ("Found 'unit' frame %s for unit %s", name or "none", unit or "none"))
          --@end-debug@]===]
          -- Set current_frame here when the frame we want is found
          local match1 = string.match (frame_name, "^(.+)%d+$")
          local match2 = string.match (local_frame, "^(.+)%d+$")
          --[===[@debug@
          pp (format ("match1: %s, match2: %s", match1 or "none", match2 or "none"))
          --@end-debug@]===]
          if match1 and match2 and match1 == match2 and current_guid == UnitGUID (unit) then
            current_frame = frame
            current_unit = unit
            DirectionArrow:SetArrow ()
            return
          end
        end
      end
      frame = EnumerateFrames(frame);
    end

  end
end

function DirectionArrow:ToggleSticky ()
  DirectionArrow.sticky = not DirectionArrow.sticky
  --[===[@debug@
  pp ("Sticky toggled. Set to: " .. (DirectionArrow.sticky and "true" or "false"))
  --@end-debug@]===]
end

function DirectionArrow:CheckUnit (unit)
  if
    unit
    and (
      strfind (unit, "^raid%d+$")
      or strfind (unit, "^raidpet%d+$")
      or strfind (unit, "^party%d+$")
      or strfind (unit, "^partypet%d+$")
      or strfind (unit, "^target.*$")
      or strfind (unit, "^focus.*$")
    )
  then
    return true
  end
  return false
end

function DirectionArrow:UPDATE_MOUSEOVER_UNIT()
  if DirectionArrow.sticky then
    return
  end
  frame = GetMouseFocus()
  if frame then
    local unit = SecureButton_GetModifiedUnit (frame)
    if DirectionArrow:CheckUnit (unit) then
      if UnitIsUnit (unit, "player") then
        --[===[@debug@
        pp ("The unit is the player")
        --@end-debug@]===]
        return
      end
      --[===[@debug@
      pp ("Setting unit: " .. unit)
      --@end-debug@]===]
      current_unit = unit
      current_guid = UnitGUID (unit)
      current_frame = frame
      frame_name = frame:GetName()
      --[===[@debug@
      pp ("Frame name: " .. frame_name)
      --@end-debug@]===]
      DirectionArrow:SetArrow ()
    --[===[@debug@
    elseif unit then
      pp ("Not a unit frame in the list: " .. unit)
    --@end-debug@]===]
    end
  end
end

function DirectionArrow:SetArrow ()
  --[===[@debug@
  pp (format ("SetArrow on unit %s: ", current_unit))
  --@end-debug@]===]
  if CanShow (current_unit) then
    DirectionArrow.f:ClearAllPoints ()
    DirectionArrow.f:SetPoint (
      "CENTER",
      current_frame,
      DirectionArrow.db.profile.relative_point,
      DirectionArrow.db.profile.relative_location_x,
      DirectionArrow.db.profile.relative_location_y
    )
    DirectionArrow.f:SetFrameLevel(frame:GetFrameLevel() + 50)
    DirectionArrow.f:Show()
  end
end
