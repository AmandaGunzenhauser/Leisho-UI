-------------------------------------------------------------------------------
-- Change Log
-------------------------------------------------------------------------------

local addon_help = "L/R: Tell/Invite | Shift: Who/Raid Invite | Ctrl: Edit note/onote | v6.0.4"

-- 6.0.4: [10/28/2014 4:51PM]
--   * Raid invite on RAIDS page (shift-right-click on any member of the raid team) will
--     send a whisper to an online alt of a raid team member letting them know that raid
--     invites are going out and that they should switch toons.  Holding down the ALT key
--     (shift-alt-right-click) will invite the online alt instead of sending the whisper.
-- 6.0.3: [10/26/2014 1:15PM]
--   * Sorting reverse by Character column (or Main column in the Mains page) no longer
--     sorts Z to A but instead groups the entries by class (DKs, then Druids, etc.).
-- 6.0.2: [10/14/2014 8:50PM]
--   * Updated TOC for patch 6.0.2
--   * Fixed LUA error when editing note/onote
-- 5.4.1: [12/10/2013 9:54AM]
--   * Updated TOC for patch 5.4.2
--   * Split server name from character name in guild enumeration
-- 5.4.0: [11/25/2013 10:26PM]
--   * Updated TOC for patch 5.4
--   * Added option to display guild name instead of 'Guild' in LDB bar
-- 5.2.0: [3/5/2013 8:32PM]
--   * Updated TOC for patch 5.2
-- 5.1.0: [11/27/2012 2:59PM]
--   * Updated TOC for patch 5.1
--   * Fixed LUA error when "Click to Show Tooltip" option is selected
--   * Fixed LUA error when GetGuildRosterLastOnline returns nil
-- 5.0.6: [10/11/2012 2:48PM]
--   * Added support for mobile flag, showing as "mbl" in place of "afk" or "dnd"
--   * Don't attempt to invite a player who is using a mobile device
-- 5.0.5: [9/23/2012 12:39PM]
--   * Delay setting up fonts to support addons that change the default tooltip font.
--   * Changed mouse-click actions and added reminder text to bottom right of each view.
--   * Allow multiple "Note" tokens by concatenating them together.
-- 5.0.4: [9/22/2012 5:25PM]
--   * Fixed afk and dnd flags
--   * Moved group/raid indicator to the level column
--   * Added Alt-right-click to invite to a raid.
-- 5.0.3: [9/20/2012 8:41PM]
--   * Forked from an earlier addon Broker_SparkleState.

-------------------------------------------------------------------------------
-- Upvalued Lua globals.
-------------------------------------------------------------------------------

local _G = getfenv(0)
local string = _G.string
local pairs = _G.pairs

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------

local LibQTip = LibStub('LibQTip-1.0')
local frame = CreateFrame("frame")

local tooltip
local LDB_ANCHOR

local guild_info_option_pnote
local guild_info_option_onote
local guild_info_option_raids

local guild_roster
local guild_roster_mains_count
local guild_roster_alts_count
local guild_roster_alts_built
local guild_online
local guild_bymain
local guild_byraid
local guild_byraid_raid_count
local guild_byraid_member_count
local guild_message
local guild_page = "ONLINE"
local guild_rank_cache = {}
local guild_table_line_beg = 1
local guild_table_line_end = 1
local guild_title_click_count = 0

local ctr_timeout = 0
local ctr_elapsed = 0

local function AutoConvertToRaid(initial)

    if IsInRaid() then
        -- We are in a raid.
        ctr_timeout = 0
        return
    end

    if IsInGroup() then
        -- We are in a group, try converting it to a raid.
        ConvertToRaid()
        ctr_timeout = 0
        return
    end

    if initial then
        -- Not in a raid or group.  Wait up to 15 seconds for a group to form.
        ctr_timeout = 15
        ctr_elapsed = 0
        return
    end

end

local function FormatGuildRank(rank)

    if (rank) then

        local rankWide = guild_rank_cache[rank]

        if (not rankWide) then
            rankWide = rank.." "
            guild_rank_cache[rank] = rankWide
        end
        
        rank = rankWide

    end

    return rank

end

local dataobj = LibStub("LibDataBroker-1.1"):NewDataObject("GuildRosterDeluxe",
{
    type    = "data source",
    icon    = "Interface\\Icons\\INV_Drink_08.png",
    label   = "GuildRosterDeluxe",
    text    = "Guild"
})

local update_Broker

local BuildGuildRosterAlts

local GROUP_CHECKMARK = "*"
local MAXIMIZE = "[+] "
local MINIMIZE = "[-] "
local DOWNARROW = "v "
local UPARROW = "^ "
local UPARROWTRANS = "  "

local STATUS_TABLE = {
    nil,
    nil,
    "|cff7f7f7fafk|r",
    "|cff7f7f7fafk|r",
    "|cff7f7f7fdnd|r",
    "|cff7f7f7fdnd|r",
    "|cff7f7f7fmob|r",
    "|cff7f7f7fmob|r"
}

local STATUS_TABLE_RAIDS = {
    nil,
    "RL",
    "|cff7f7f7fafk|r",
    "|cff7f7f7fafk|r RL",
    "|cff7f7f7fdnd|r",
    "|cff7f7f7fdnd|r RL",
    "|cff7f7f7fmob|r",
    "|cff7f7f7fmob|r RL"
}

-------------------------------------------------------------------------------
-- Font definitions.
-------------------------------------------------------------------------------

local ssTitleFont, ssHeaderFont, ssHeaderTransFont, ssRegFont, ssSmallFont

local function BuildFonts()
    if not ssTitleFont then
        -- Setup the Title Font. 20
        ssTitleFont = CreateFont("spsTitleFont")
        ssTitleFont:SetTextColor(1,0.823529,0)
        ssTitleFont:SetFont(GameTooltipText:GetFont(), 20)

        -- Setup the Header Font. 12
        ssHeaderFont = CreateFont("spsHeaderFont")
        ssHeaderFont:SetTextColor(1,0.823529,0)
        ssHeaderFont:SetFont(GameTooltipHeaderText:GetFont(), 12)

        -- Setup the Header Transparent Font. 12
        ssHeaderTransFont = CreateFont("spsHeaderTransFont")
        ssHeaderTransFont:SetTextColor(1,0.823529,0,0)
        ssHeaderTransFont:SetFont(GameTooltipHeaderText:GetFont(), 12)

        -- Setup the Regular Font. 12
        ssRegFont = CreateFont("spsRegFont")
        ssRegFont:SetTextColor(1,0.823529,0)
        ssRegFont:SetFont(GameTooltipText:GetFont(), 12)

        -- Setup the Small Font. 9
        ssSmallFont = CreateFont("spsSmallFont")
        ssSmallFont:SetTextColor(1,0.823529,0)
        ssSmallFont:SetFont(GameTooltipText:GetFont(), 9)
    end
end

local function CompareStrFwdStrFwd(a, b, key1, key2)
    local sa = a[key1]
    local sb = b[key1]
    if (sa < sb) then return true end
    if (sa > sb) then return false end
    return(a[key2] < b[key2])
end

local function CompareStrSpaStrFwd(a, b, key1, key2)
    local sa = a[key1]
    local sb = b[key1]
    if (sa == "") then sa = "~" end
    if (sb == "") then sb = "~" end
    if (sa < sb) then return true end
    if (sa > sb) then return false end
    return(a[key2] < b[key2])
end

local function CompareStrRevStrFwd(a, b, key1, key2)
    local sa = a[key1]
    local sb = b[key1]
    if (sa > sb) then return true end
    if (sa < sb) then return false end
    return(a[key2] < b[key2])
end

local function CompareMainStrFwdStrFwdStrFwd(a, b, key1, key2, key3)
    local sa = (a["ENTRYMAIN"] or a)[key1]
    local sb = (b["ENTRYMAIN"] or b)[key1]
    if (sa < sb) then return true end
    if (sa > sb) then return false end
    sa = a[key2];
    sb = b[key2];
    if (sa < sb) then return true end
    if (sa > sb) then return false end
    return(a[key3] < b[key3])
end

local function CompareIntFwdStrFwd(a, b, key1, key2)
    local ia = a[key1]
    local ib = b[key1]
    if (ia < ib) then return true end
    if (ia > ib) then return false end
    return(a[key2] < b[key2])
end

local function CompareIntSpaStrFwd(a, b, key1, key2)
    local ia = a[key1]
    local ib = b[key1]
    if (ia == 0) then ia = 1e6 end
    if (ib == 0) then ib = 1e6 end
    if (ia < ib) then return true end
    if (ia > ib) then return false end
    return(a[key2] < b[key2])
end

local function CompareIntRevStrFwd(a, b, key1, key2)
    local ia = a[key1]
    local ib = b[key1]
    if (ia > ib) then return true end
    if (ia < ib) then return false end
    return(a[key2] < b[key2])
end

local sort_function = {
    TOONNAME        = function(a, b) return a["TOONNAME"] < b["TOONNAME"] end,
    revTOONNAME     = function(a, b) return CompareStrFwdStrFwd(a, b, "CLASS", "TOONNAME") end,
    TOONMAIN        = function(a, b) return CompareStrFwdStrFwd(a, b, "TOONMAIN", "TOONNAME") end,
    revTOONMAIN     = function(a, b) return CompareStrRevStrFwd(a, b, "TOONMAIN", "TOONNAME") end,
    TOONREFER       = function(a, b) return CompareStrSpaStrFwd(a, b, "TOONREFER", "TOONNAME") end,
    revTOONREFER    = function(a, b) return CompareStrRevStrFwd(a, b, "TOONREFER", "TOONNAME") end,
    REALNAME        = function(a, b) return CompareStrFwdStrFwd(a, b, "REALNAME", "TOONNAME") end,
    revREALNAME     = function(a, b) return CompareStrRevStrFwd(a, b, "REALNAME", "TOONNAME") end,
    ZONENAME        = function(a, b) return CompareStrFwdStrFwd(a, b, "ZONENAME", "TOONNAME") end,
    revZONENAME     = function(a, b) return CompareStrRevStrFwd(a, b, "ZONENAME", "TOONNAME") end,
    RAIDNAME        = function(a, b) return CompareStrSpaStrFwd(a, b, "RAIDNAME", "TOONNAME") end,
    revRAIDNAME     = function(a, b) return CompareStrRevStrFwd(a, b, "RAIDNAME", "TOONNAME") end,
    LEVEL           = function(a, b) return CompareIntFwdStrFwd(a, b, "LEVEL", "TOONNAME") end,
    revLEVEL        = function(a, b) return CompareIntRevStrFwd(a, b, "LEVEL", "TOONNAME") end,
    RANKINDEX       = function(a, b) return CompareIntFwdStrFwd(a, b, "RANKINDEX", "TOONNAME") end,
    revRANKINDEX    = function(a, b) return CompareIntRevStrFwd(a, b, "RANKINDEX", "TOONNAME") end,
    ALTSCOUNT       = function(a, b) return CompareIntSpaStrFwd(a, b, "ALTSCOUNT", "TOONNAME") end,
    revALTSCOUNT    = function(a, b) return CompareIntRevStrFwd(a, b, "ALTSCOUNT", "TOONNAME") end,
    LASTONLINE      = function(a, b) return CompareStrFwdStrFwd(a, b, "LASTONLINE", "TOONNAME") end,
    revLASTONLINE   = function(a, b) return CompareStrRevStrFwd(a, b, "LASTONLINE", "TOONNAME") end,
    JOINDATE        = function(a, b) return CompareIntFwdStrFwd(a, b, "JOINSORT", "TOONNAME") end,
    revJOINDATE     = function(a, b) return CompareIntRevStrFwd(a, b, "JOINSORT", "TOONNAME") end,
}

local sort_function_mains_raids = {
    LASTONLINE      =
        function(a, b)
            local sa = ((a["ENTRYMAIN"] or a)["ENTRYLASTONLINE"])["LASTONLINE"]
            local sb = ((b["ENTRYMAIN"] or b)["ENTRYLASTONLINE"])["LASTONLINE"]
            if (sa < sb) then return true end
            if (sa > sb) then return false end
            return(a["TOONNAME"] < b["TOONNAME"])
        end,
    revLASTONLINE   =
        function(a, b)
            local sa = ((a["ENTRYMAIN"] or a)["ENTRYLASTONLINE"])["LASTONLINE"]
            local sb = ((b["ENTRYMAIN"] or b)["ENTRYLASTONLINE"])["LASTONLINE"]
            if (sa > sb) then return true end
            if (sa < sb) then return false end
            return(a["TOONNAME"] < b["TOONNAME"])
        end,
}

local sort_function_mains = {
    revTOONMAIN     =
        function(a, b)
	    local sa = a["CLASS"];
	    local sb = b["CLASS"];
	    if (sa < sb) then return true end
	    if (sa > sb) then return false end
	    return(CompareStrRevStrFwd(a, b, "TOONMAIN", "TOONNAME"))
	end,
}

local function get_sort_function()
    local column = GuildRosterDeluxeDB[guild_page]
    if (guild_page == "MAINS") then
        return sort_function_mains_raids[column] or sort_function_mains[column] or sort_function[column]
    elseif (guild_page == "RAIDS") then
        return sort_function_mains_raids[column] or sort_function[column]
    else
        return sort_function[column]
    end
end

local sort_reverse = {
    TOONNAME    = "revTOONNAME",    revTOONNAME     = "TOONNAME",
    TOONMAIN    = "revTOONMAIN",    revTOONMAIN     = "TOONMAIN",
    TOONREFER   = "revTOONREFER",   revTOONREFER    = "TOONREFER",
    REALNAME    = "revREALNAME",    revREALNAME     = "REALNAME",
    ZONENAME    = "revZONENAME",    revZONENAME     = "ZONENAME",
    RAIDNAME    = "revRAIDNAME",    revRAIDNAME     = "RAIDNAME",
    LEVEL       = "revLEVEL",       revLEVEL        = "LEVEL",
    RANKINDEX   = "revRANKINDEX",   revRANKINDEX    = "RANKINDEX",
    ALTSCOUNT   = "revALTSCOUNT",   revALTSCOUNT    = "ALTSCOUNT",
    LASTONLINE  = "revLASTONLINE",  revLASTONLINE   = "LASTONLINE",
    JOINDATE    = "revJOINDATE",    revJOINDATE     = "JOINDATE",
}

-------------------------------------------------------------------------------
-- Ace config table
-------------------------------------------------------------------------------

local options = {
    name = "GuildRosterDeluxe",
    type = "group",
    args = {
        confdesc = {
            order = 1,
            type = "description",
            name = "A LibDataBroker plugin that displays the guild roster in multiple views.\n",
            cmdHidden = true
        },
        displayheader = {
            order = 2,
            type = "header",
            name = "Tooltip Options",
        },
        tooltip_scale = {
            order = 3, 
            type = "range", width = "normal",
            min = 0.5, max = 1.5, step = 0.05,
            name = "Tooltip Scale:",
            desc = "Choose the size of the tooltip",
            get = function() return GuildRosterDeluxeDB.tooltip_scale end,
            set = function(_, v) GuildRosterDeluxeDB.tooltip_scale = v end,
        },
        tooltip_autohide = {
            order = 4,
            type = "range", width = "normal",
            min = 0.25, max = 5.0, step = 0.25,
            name = "Autohide Delay:",
            desc = "The tooltip will hide when not hovered over for this many seconds",
            get = function() return GuildRosterDeluxeDB.tooltip_autohide end,
            set = function(_, v) GuildRosterDeluxeDB.tooltip_autohide = v end,
        },
        tooltip_viewport_lines = {
            order = 6,
            type = "range", width = "normal",
            min = 10, max = 100, step = 1,
            name = "Table Lines:",
            desc = "The number of lines to display in a table before scrolling.",
            get = function() return GuildRosterDeluxeDB.tooltip_viewport_lines end,
            set = function(_, v) GuildRosterDeluxeDB.tooltip_viewport_lines = v end,
        },
        tooltip_viewport_scroll = {
            order = 7,
            type = "range", width = "normal",
            min = 1, max = 100, step = 1,
            name = "Scroll Lines:",
            desc = "The number of lines to scroll per mouse-wheel or click.",
            get = function() return GuildRosterDeluxeDB.tooltip_viewport_scroll end,
            set = function(_, v) GuildRosterDeluxeDB.tooltip_viewport_scroll = v end,
        },
        displayheader4 = {
            order = 8,
            type = "header",
            name = "LDB Display Options",
        },
        hide_ldb_label = {
            order = 9,
            type = "toggle", width = "double",
            name = "Hide Guild Label",
            desc = "Hide the Guild label from the LDB",
            get = function() return GuildRosterDeluxeDB.hide_LDB_label end,
            set = function(_, v) GuildRosterDeluxeDB.hide_LDB_label = v update_Broker() end
        },
        show_ldb_guild_name = {
            order = 10,
            type = "toggle", width = "double",
            name = "Show actual guild name instead of 'Guild' label",
            desc = "Show the actual guild name instead of the generic 'Guild' label in the LDB",
            get = function() return GuildRosterDeluxeDB.show_LDB_guild_name end,
            set = function(_, v) GuildRosterDeluxeDB.show_LDB_guild_name = v update_Broker() end
        },
        hide_ldb_total = {
            order = 11,
            type = "toggle", width = "double",
            name = "Hide Total",
            desc = "Hide the Total field from the LDB",
            get = function() return GuildRosterDeluxeDB.hide_LDB_total end,
            set = function(_, v) GuildRosterDeluxeDB.hide_LDB_total = v update_Broker() end
        },
        tooltip_click_to_show = {
            order = 12,
            type = "toggle", width = "double",
            name = "Click to Show Tooltip",
            desc = "Click to show tooltip instead of mouse hover",
            get = function() return GuildRosterDeluxeDB.tooltip_click_to_show end,
            set = function(_, v) GuildRosterDeluxeDB.tooltip_click_to_show = v end
        },
        displayheader5 = {
            order = 13,
            type = "header",
            name = "Advanced",
        },
        DEBUG = {
            order = 14,
            type = "toggle", width = "double",
            name = "Report Malformed Notes",
            desc = "Report malformed or incomplete note information to the chat window",
            get = function() return (not not GuildRosterDeluxeDB.DEBUG) end,
            set = function(_, v) GuildRosterDeluxeDB.DEBUG = v update_Broker() end
        },
    }
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("GuildRosterDeluxe", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("GuildRosterDeluxe")

-------------------------------------------------------------------------------
-- Helper Routines
-------------------------------------------------------------------------------

local function UnitInRaidOrParty(name)
    return (GetNumGroupMembers() > 0) and UnitInParty(name)
end

local function guild_name_to_index(name)
    local lookupname

    for i = 1, GetNumGuildMembers() do
        lookupname = GetGuildRosterInfo(i)

        local toonName,toonServer = strsplit("-",lookupname,2)

        if toonName == name then
            return i
        end
    end

    return 0
end

local function FormatLevel(entry, group)
    local level = entry["LEVEL"]
    local color = GetQuestDifficultyColor(level)
    local format = "|cff%02x%02x%02x%d|r"
    if (group and UnitInRaidOrParty(entry["TOONNAME"])) then
        format = "* |cff%02x%02x%02x%d|r"
    end
    return string.format(format, color.r * 255, color.g * 255, color.b * 255, level)
end

local CLASS_COLORS, color = {}
local CLASS_COLORS_DIM = {}
local classes_female, classes_male = {}, {}

FillLocalizedClassList(classes_female, true)
FillLocalizedClassList(classes_male, false)

for token, localizedName in pairs(classes_female) do
    color = RAID_CLASS_COLORS[token]
    CLASS_COLORS[localizedName] = string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255) 
    CLASS_COLORS_DIM[localizedName] = "7f7f7f"
end

for token, localizedName in pairs(classes_male) do
    color = RAID_CLASS_COLORS[token]
    CLASS_COLORS[localizedName] = string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255) 
    CLASS_COLORS_DIM[localizedName] = "7f7f7f"
end

---------------------
--  Update button  --
---------------------

function update_Broker()
    local s = ""
    if (IsInGuild()) then
        GuildRoster()
        local NumMembers, NumOnline = GetNumGuildMembers(true)
        s = s .. "|cff00ff00"
        if not GuildRosterDeluxeDB.hide_LDB_label then
            if GuildRosterDeluxeDB.show_LDB_guild_name then
                s = s .. (GetGuildInfo("player") or "Guild") .. " "
            else
                s = s .. "Guild "
            end
        end
        s = s .. NumOnline
        if not GuildRosterDeluxeDB.hide_LDB_total then
            s = s .. "/" .. NumMembers
        end
    end
    dataobj.text = "|cff82c5ff" .. s .. "|r"
end

local page_forward = {
    ONLINE  = "RAIDS",
    RAIDS   = "MAINS",
    MAINS   = "ROSTER",
    ROSTER  = "ONLINE",
}

local page_reverse = {
    ONLINE  = "ROSTER",
    ROSTER  = "MAINS",
    MAINS   = "RAIDS",
    RAIDS   = "ONLINE"
}

local page_title = {
    ONLINE  = " Online",
    RAIDS   = " Raids",
    MAINS   = " Mains",
    ROSTER  = " Roster",
}

local function OnMouseWheel_Scroll(self, delta)

    if (delta > 0 or guild_table_line_end <= guild_table_body_lines) then
        local viewport_lines = math.max(10,math.min(1000,math.floor(tonumber(GuildRosterDeluxeDB.tooltip_viewport_lines))))
        local viewport_scroll = math.max(1,math.min(viewport_lines,math.floor(tonumber(GuildRosterDeluxeDB.tooltip_viewport_scroll))))
        local line_beg = math.max(1,guild_table_line_beg + (-delta * viewport_scroll))
        if (guild_table_line_beg ~= line_beg) then
            guild_table_line_beg = line_beg
            dataobj.OnEnter(LDB_ANCHOR)
        end
    end

end

local function OnMouseUp_Title(frame, info, button)

    if (LDB_ANCHOR == nil) then
        return
    end

    -- Shift-Left/RightButton to scroll the contents of the current view

    if (IsShiftKeyDown()) then
       if (button == "LeftButton") then
          OnMouseWheel_Scroll(LDB_ANCHOR, -1)
       elseif (button == "RightButton") then
          OnMouseWheel_Scroll(LDB_ANCHOR, 1)
       end
       return
    end

    -- Left/RightButton to scroll to the next/previous view

    if (button == "LeftButton") then
        if (not GuildRosterDeluxeDB.tooltip_click_to_show or guild_title_click_count > 0) then
            guild_page = page_forward[guild_page]
        end
        guild_title_click_count = guild_title_click_count + 1
    elseif (button == "RightButton") then
        if (GuildRosterDeluxeDB.tooltip_click_to_show and guild_title_click_count == 0) then
            return
        end
        guild_page = page_reverse[guild_page]
    else
        return
    end

    guild_table_line_beg = 1
    dataobj.OnEnter(LDB_ANCHOR)

end

local function IsOnline(entry)
    return (not entry["LASTONLINESTR"])
end

local function IsPlayer(entry)
    return (entry["TOONNAME"] == UnitName("player"))
end

local function IsInRaidOrParty(entry)
    return UnitInRaidOrParty(entry["TOONNAME"])
end

local function FindOnlineAlt(entry)
    if (not guild_roster_alts_built) then
        BuildGuildRosterAlts()
    end
    local entryMain = entry["ENTRYMAIN"] or entry
    local entryLastOnline = entryMain["ENTRYLASTONLINE"]
    if (IsOnline(entryLastOnline)) then
        return entryLastOnline
    end
    return nil
end

local function CanInvite(entry)
    return (IsOnline(entry) and (entry["STATUS"] < 7))
end

local function InviteEntry(entry)
    if (not IsInRaidOrParty(entry)) and (not IsPlayer(entry)) then
        InviteUnit(entry["TOONNAME"])
        --print("InviteUnit(\"" .. entry["TOONNAME"] .. "\")")
    end
end

local function OnMouseUp_Entry(frame, toon_name, button)

    local leftbutton = (button == "LeftButton")

    if (not leftbutton) and (button ~= "RightButton") then
        return
    end

    if IsControlKeyDown() then
        if leftbutton then
            -- Edit Player Note
            if CanEditPublicNote() then
                SetGuildRosterSelection(guild_name_to_index(toon_name))
                StaticPopup_Show("SET_GUILDPLAYERNOTE")
            end
        else
            -- Edit Officer Note
            if CanEditOfficerNote() then
                SetGuildRosterSelection(guild_name_to_index(toon_name))
                StaticPopup_Show("SET_GUILDOFFICERNOTE")
            end
        end
        return
    end

    if (not guild_roster) then
        return
    end

    local entry = guild_roster[toon_name]
    if not entry then
        return
    end

    if leftbutton then
        if IsAltKeyDown() then return end
        -- Tell/Who to player
        if entry["LASTONLINESTR"] then
            -- Player is offline; try to find an online main/alt
            local entryAlt = FindOnlineAlt(entry)
            if (not entryAlt) then return end
            toon_name = entryAlt["TOONNAME"]
        end
        SetItemRef("player:"..toon_name, "|Hplayer:"..toon_name.."|h["..toon_name.."|h", "LeftButton")
    elseif (not IsShiftKeyDown()) then
        -- Invite single player.
        if (CanInvite(entry)) then
            InviteEntry(entry)
        end
    elseif (guild_page ~= "RAIDS") then
        -- Invite single player to a raid.
        if (CanInvite(entry)) then
            AutoConvertToRaid(true)
            InviteEntry(entry)
        end
    else
        -- Invite raid team to a raid.
        if (not guild_byraid) then
            return
        end

        local raidArray = guild_byraid[entry["RAIDNAME"]]
        if (not raidArray) then
            return
        end

        AutoConvertToRaid(true)

        for _,entryRaid in ipairs(raidArray) do
            if (CanInvite(entryRaid)) then
                InviteEntry(entryRaid)
            else
                local entryAlt = FindOnlineAlt(entryRaid)
                if (entryAlt and CanInvite(entryAlt)) then
                    if IsAltKeyDown() then
                        InviteEntry(entryAlt)
                    elseif (not IsInRaidOrParty(entryAlt)) and (not IsPlayer(entryAlt)) then
                        local msg = entry["RAIDNAME"] .. " raid invites going out.  Switch to " .. entryRaid["TOONNAME"] .. "."
                        SendChatMessage(msg, "WHISPER", nil, entryAlt["TOONNAME"])
                        --print("SendChatMessage(\"" .. msg .. "\", \"WHISPER\", nil, \"" .. entryAlt["TOONNAME"] .. "\")")
                    end
                end
            end
        end
    end
end

local function OnMouseUp_Toggle(cell, section)
    GuildRosterDeluxeDB[section] = not GuildRosterDeluxeDB[section]
    dataobj.OnEnter(LDB_ANCHOR)
end

local function OnMouseUp_Sort(cell, newSort)

    local curSort = GuildRosterDeluxeDB[guild_page]

    if (curSort == newSort) then
        GuildRosterDeluxeDB[guild_page] = sort_reverse[newSort]
    else
        GuildRosterDeluxeDB[guild_page] = newSort
    end

    guild_table_line_beg = 1
    dataobj.OnEnter(LDB_ANCHOR)

end

function dataobj:OnClick(button)
    if (IsControlKeyDown()) then
        InterfaceOptionsFrame_OpenToCategory("GuildRosterDeluxe")
    else
        OnMouseUp_Title(nil, nil, button)
    end
end

---------------------
--  Event Section  --
---------------------

function dataobj.OnLeave()
end

--------------------------
--  Parse Note Section  --
--------------------------

local function ParseError(...)
    if (GuildRosterDeluxeDB.DEBUG) then
        print(...)
    end
end

local function ParseToken(s,n,i,iErr,Token,p,Merge)
   if (i < n and not iErr) then
      local b,e,c = string.find(s,p,i)
      if (e) then
         if (Token) then
            if (Merge) then
                Token = Token.." "..c
                i = e + 1
            else
                iErr = b
            end
         else
            Token = c
            i = e + 1
         end
      end
   end
   return i,iErr,Token
end

local function ParseNote(s,Note)
   local Name,Main,Refer,Join,RaidName,iErr,i,n
   -- Parse until the string is empty or syntax error
   i = 1
   n = strlen(s)
   while (i < n and not iErr) do
      local iPrev = i
      -- Parse (Name) token
      i,iErr,Name = ParseToken(s,n,i,iErr,Name,"^%s*%(([^%)]+)%)%s*",false)
      -- Parse >Main token
      i,iErr,Main = ParseToken(s,n,i,iErr,Main,"^%s*>(%S+)%s*",false)
      -- Parse ^Refer token
      i,iErr,Refer = ParseToken(s,n,i,iErr,Refer,"^%s*^(%S+)%s*",false)
      -- Parse "Note" token
      i,iErr,Note = ParseToken(s,n,i,iErr,Note,"^%s*\"([^\"]+)\"%s*",true)
      -- Parse MMDDYY token
      i,iErr,Join = ParseToken(s,n,i,iErr,Join,"^%s*(%d%d%d%d%d%d)%s*",false)
      -- Skip [...] token
      i,iErr = ParseToken(s,n,i,iErr,nil,"^%s*%[[^%]]+%]%s*",false)
      -- Parse {RaidName} token
      i,iErr,RaidName = ParseToken(s,n,i,iErr,RaidName,"^%s*{([^}]+)}%s*",false)
      -- Skip any leftover whitespace
      i,iErr = ParseToken(s,n,i,iErr,nil,"^%s+",false)
      -- No forward progress means syntax error
      if (i == iPrev) then
         iErr = i
      end
   end
   return Name,Main,Refer,Note,Join,RaidName,iErr
end

local function ParseGuildInfo()
    guild_info_option_pnote = false
    guild_info_option_onote = true
    guild_info_option_raids = nil
    local info = (GetGuildInfoText() or "")
    if (info ~= "") then
        s = string.match(info, "<GRD>(.*)</GRD>")
        if (not s) then s = string.match(info, "<SparkleState>(.*)</SparkleState>") end
        if (s) then
            local i = 1
            local n = strlen(s)
            while (i < n) do
                local b,e,l,r = string.find(s,"{([%w@]+)=%s*([^}]-)%s*}",i)
                --print("i=" .. i .. ", b=" .. (b or "nil") .. ", e=" .. (e or "nil"), "/" .. (l or "") .. "/=/" .. (r or "") .. "/")
                if (e) then
                    if (l == "@@") then
                        if (r == "pnote") then
                            guild_info_option_pnote = true
                            guild_info_option_onote = false
                        elseif (r == "onote") then
                            guild_info_option_pnote = false
                            guild_info_option_onote = true
                        elseif (r == "both") then
                            guild_info_option_pnote = true
                            guild_info_option_onote = true
                        end
                    else
                        if (guild_info_option_raids == nil) then
                            guild_info_option_raids = {}
                        end
                        guild_info_option_raids[l] = r
                    end
                    i = e + 1
                else
                    i = n
                end
            end
        end
    end
end

local function BuildGuildRoster()

    GuildRoster()

    -- Parse the guild info text for per-guild options

    ParseGuildInfo()

    -- Parse the guild roster

    guild_roster = {}
    guild_roster_alts_built = false

    for i = 1, GetNumGuildMembers(true) do
        local toonNameServer, rank, rankindex, level, class, zoneName, pnote, onote, connected, status,_,_,_,mobile= GetGuildRosterInfo(i)
        local realName, toonMain, toonRefer, extraNote, joinDate, joinSort, raidName, raidLead, iErr
        local cnote

        -- Split toonNameServer into toonName and toonServer

        local toonName,toonServer = strsplit("-",toonNameServer,2)

        if not toonName then toonName = toonNameServer end
        if not toonServer then toonServer = "" end

        -- Default to empty strings instead of nil for pnote and onote

        if not pnote then pnote = "" end
        if not onote then onote = "" end

        if guild_info_option_pnote then
            if guild_info_option_onote then
                cnote = pnote.." "..onote
            else
                cnote = pnote
            end
        else
            extraNote = pnote
            if guild_info_option_onote then
                cnote = onote
            else
                cnote = ""
            end
        end

        -- Parse the note

        realName, toonMain, toonRefer, extraNote, joinDate, raidName, iErr = ParseNote(cnote,extraNote)

        if (toonMain == toonName) then
            -- Ignore self-referential >toonName and treat it as a main
            toonMain = nil
        end

        if iErr then
            ParseError(toonName .. ": bad note (@" .. iErr .. "): |cff00ff00" .. string.sub(cnote,1,iErr-1) .. "|r|cffff0000" .. string.sub(cnote,iErr) .. "|r")
        end

        -- Parse joinDate and compute joinSort

        joinSort = 0

        if joinDate then
            local m,d,y = string.match(joinDate,"(%d%d)(%d%d)(%d%d)")

            if ((not m) or (not d) or (not y) or (tonumber(m) < 1) or (tonumber(m) > 12) or (tonumber(d) < 1) or (tonumber(d) > 31)) then
                ParseError(toonName..": bad note: invalid join date ("..joinDate.."): |cff00ff00"..cnote.."|r")
            else
                joinSort = (tonumber(y) * 10000) + (tonumber(m) * 100) + tonumber(d)
                joinDate = string.format("%d-%d-%02d", m, d, y)
            end
        else
            joinDate = ""
        end

        -- Parse raidName and compute raidLead

        if raidName then
            if string.byte(raidName, 1) == 42 then
                raidLead = true
                raidName = string.sub(raidName, 2)
            end
            if (guild_info_option_raids) then
               raidName = (guild_info_option_raids[raidName] or raidName)
            end
        else
            raidName = ""
        end

        -- Compute the status

        if (not connected) then
            status = 0
        elseif (mobile) then
            status = 3
        end

        status = 1 + (status * 2)

        if (raidLead) then
            status = status + 1
        end

        -- Create the entry

        local entry = {
            TOONNAME = toonName,
            CONNECTED = connected,
            RANK = FormatGuildRank(rank),
            RANKINDEX = rankindex,
            LEVEL = level,
            CLASS = class,
            ZONENAME = (zoneName or ""),
            NOTE = pnote,
            ONOTE = onote,
            CNOTE = cnote,
            STATUS = status,
            REALNAME = realName,
            TOONMAIN = toonMain,
            TOONREFER = toonRefer,
            EXTRANOTE = extraNote,
            RAIDNAME = raidName,
            LASTONLINE = "",
            JOINDATE = joinDate,
            JOINSORT = joinSort
            }

        if (not connected) then
            local y,m,d,h = GetGuildRosterLastOnline(i)
            y,m,d,h = y and y or 0, m and m or 0, d and d or 0, h and h or 0
            entry["LASTONLINE"] = string.format("%02d:%02d:%02d:%02d", y, m, d, h);
           
            local s

            if (y > 0) then
                s = string.format("%d year%s", y, (y == 1) and "" or "s")
            elseif (m > 0) then
                s = string.format("%d month%s", m, (m == 1) and "" or "s")
            elseif (d > 0) then
                s = string.format("%d day%s", d, (d == 1) and "" or "s")
            elseif (h > 0) then
                s = string.format("%d hour%s", h, (h == 1) and "" or "s")
            else
                s = "< an hour"
            end

            entry["LASTONLINESTR"] = s
        end

        guild_roster[toonName] = entry
        table.insert(guild_roster, entry)

    end

    -- Verify that the TOONMAIN field actually references a toon in the guild

    for _,entry in ipairs(guild_roster) do
        -- An entry is for an ALT if it has a toonMain field
        local toonName = entry["TOONNAME"]
        local toonMain = entry["TOONMAIN"]
        if (toonMain) then
            -- Look up the entry for the main
            local entryMain = guild_roster[toonMain]
            if (not entryMain) then
                ParseError(toonName..": >"..toonMain.." is not in guild: |cff00ff00" .. entry["CNOTE"] or "" .. "|r")
                -- Promote this malformed ALT to a standalone MAIN
                entry["REALNAME"] = "???"
                entry["TOONREFER"] = nil
            else
                entry["ENTRYMAIN"] = entryMain
            end
        end
    end

    -- Verify that the ENTRYMAIN field actually references a MAIN in the guild

    local promote_array = {}

    for _,entry in ipairs(guild_roster) do
        -- An entry is for an ALT if it has an ENTRYMAIN field
        local toonName = entry["TOONNAME"]
        local entryMain = entry["ENTRYMAIN"]
        local toonMain = entry["TOONMAIN"]
        local realName = entry["REALNAME"]
        local toonRefer = entry["TOONREFER"]
        local joinDate = entry["JOINDATE"]
        if (entryMain) then
            if (entryMain["ENTRYMAIN"]) then
                -- An ALT entry should not reference another ALT entry
                ParseError(toonName..": >"..toonMain.." must point to a MAIN and not an ALT ("..toonMain..": >"..entryMain["TOONMAIN"]..")")
                -- Mark this malformed ALT for promotion to a standalone MAIN in the next pass
                table.insert(promote_array, entry)
            else
                -- An ALT entry must not also specify a realName
                if (realName) then
                    ParseError(toonName..": >"..toonMain.." and ("..realName..") are mutually exclusive: |cff00ff00" .. entry["CNOTE"] .. "|r")
                    entry["REALNAME"] = nil
                end
                -- An ALT entry must not also specify a toonRefer
                if (toonRefer) then
                    ParseError(toonName..": >"..toonMain.." and ^"..toonRefer.." are mutually exclusive: |cff00ff00" .. entry["CNOTE"] .. "|r")
                    entry["TOONREFER"] = nil
                end
                -- An ALT entry must not also specify a joinDate
                if (joinDate and joinDate ~= "") then
                    ParseError(toonName..": >"..toonMain.." and MMDDYY are mutually exclusive: |cff00ff00" .. entry["CNOTE"] .. "|r")
                end
            end
        else
            -- A MAIN entry without a realName defaults to the name of the main
            if ((not realName) or realName == "") then
                entry["REALNAME"] = toonName
            end
            -- Verify that the TOONREFER field actually references a toon in the guild
            if (toonRefer) then
                local entryRefer = guild_roster[toonRefer]
                if (not entryRefer) then
                    ParseError(toonName..": ^"..toonRefer.." is not in guild: |cff00ff00" .. entry["CNOTE"] .. "|r")
                elseif (entryRefer["TOONMAIN"]) then
                    -- A reference should not be made to an ALT
                    ParseError(toonName..": ^"..toonRefer.." must point to a MAIN and not an ALT ("..toonRefer..": >"..entryRefer["TOONMAIN"]..")")
                else
                    entry["ENTRYREFER"] = entryRefer
                end
            end
        end
    end

    -- Now promote the malformed ALTs to standalone MAINs

    for _,entry in ipairs(promote_array) do
        entry["ENTRYMAIN"] = nil
        entry["REALNAME"] = "???"
        entry["TOONREFER"] = nil
    end

    -- Now inherit realName and toonMain into the ALT entry from the MAIN entry

    for _,entry in ipairs(guild_roster) do
        local entryMain = entry["ENTRYMAIN"]
        if (entryMain) then
            entry["REALNAME"] = entryMain["REALNAME"]
            entry["TOONMAIN"] = entryMain["TOONNAME"]
        else
            entry["TOONMAIN"] = entry["TOONNAME"]
            if (not entry["TOONREFER"]) then
                entry["TOONREFER"] = ""
            end
        end
    end
end

function BuildGuildRosterAlts()
    guild_roster_mains_count = 0
    guild_roster_alts_count = 0

    for _,entry in ipairs(guild_roster) do
        local entryMain = entry["ENTRYMAIN"]
        if (entryMain) then
            local altsArray = entryMain["ALTSARRAY"]
            if (not altsArray) then 
                altsArray = {}
                entryMain["ALTSARRAY"] = altsArray
            end
            table.insert(altsArray, entry)
        end
    end

    for _,entry in ipairs(guild_roster) do
        local entryMain = entry["ENTRYMAIN"]
        if (not entryMain) then
            local altsArray = entry["ALTSARRAY"]
            local altsCount = 0
            if (altsArray) then
                table.sort(altsArray, function(a, b) return a["TOONNAME"] < b["TOONNAME"] end)
                altsCount = #altsArray
            end
            entry["ALTSCOUNT"] = altsCount
            guild_roster_mains_count = guild_roster_mains_count + 1
            guild_roster_alts_count = guild_roster_alts_count + altsCount
            local entryLastOnline = entry
            if (altsArray) then
                for _,entryAlt in ipairs(altsArray) do
                    if (entryLastOnline["LASTONLINE"] > entryAlt["LASTONLINE"]) then
                        entryLastOnline = entryAlt
                    end
                end
            end
            entry["ENTRYLASTONLINE"] = entryLastOnline
        end
    end

    guild_roster_alts_built = true
end

local function FormatNotePair(pnote, onote)
    if (pnote and pnote == "") then pnote = nil end
    if (onote and onote == "") then onote = nil end
    if (pnote and onote) then
        return "|cff00ff00"..pnote.."|r |cff00ffff"..onote.."|r"
    elseif (pnote) then
        return "|cff00ff00"..pnote.."|r"
    elseif (onote) then
        return "|cff00ffff"..onote.."|r"
    end
    return nil
end

local function FormatStatus(entry, raids)
    local status = entry["STATUS"]

    if (raids) then
        return STATUS_TABLE_RAIDS[status]
    else
        return STATUS_TABLE[status]
    end
end

local function FormatToonName(entry, class_colors_dim)
    local toonName = entry["TOONNAME"]
    local class_colors = CLASS_COLORS
    if (class_colors_dim) then class_colors = CLASS_COLORS_DIM end
    return string.format("|cff%s%s", class_colors[entry["CLASS"]] or "ffffff", toonName .. "|r")
end

local function FormatRealName(entry)
    local entryMain = entry["ENTRYMAIN"] or entry
    local realName = entry["REALNAME"]
    if (realName ~= entryMain["TOONNAME"]) then
        return realName
    else
        return string.format("|cff7f7f7f%s|r", realName)
    end
end

local function FormatLastOnline(entry)
    return entry["LASTONLINESTR"] or "|cffffffffOnline|r"
end

local function FormatAltsArray(altsArray)
    local s = nil
    if (altsArray) then
        for i,entry in ipairs(altsArray) do
            if (i == 1) then
               s = FormatToonName(entry, false)
            elseif (i > 5) then
               s = s..", ..."
               break
            else
               s = s..", "..FormatToonName(entry, false)
           end
        end
    end
    return s
end

local function SetHeaderCell(tooltip, line, cell, label, sort, right)
    if (sort) then
        local curSort = GuildRosterDeluxeDB[guild_page]
        if (sort == curSort) then
            label = UPARROW..label
        elseif (sort == sort_reverse[curSort]) then
            label = DOWNARROW..label
        elseif (right) then
            label = UPARROWTRANS..label
        else
            label = label..UPARROWTRANS
        end
        line = tooltip:SetCell(line, cell, label)
        tooltip:SetCellScript(line, cell, "OnMouseUp", OnMouseUp_Sort, sort)
    else
        line = tooltip:SetCell(line, cell, label)
    end
    return line
end

local function SetHeaderCellNote(tooltip, line, colnum)
    line = tooltip:SetCell(line, colnum, (GuildRosterDeluxeDB.raw_notes and MINIMIZE or MAXIMIZE).." Note")
    tooltip:SetCellScript(line, colnum, "OnMouseUp", OnMouseUp_Toggle, "raw_notes")
    return line
end

local function SetCellNote(tooltip, line, colnum, entry)
    if (GuildRosterDeluxeDB.raw_notes) then
        line = tooltip:SetCell(line, colnum, FormatNotePair(entry["NOTE"], entry["ONOTE"]))
    elseif (entry["EXTRANOTE"]) then
        line = tooltip:SetCell(line, colnum, "|cff00ff00"..entry["EXTRANOTE"].."|r")
    end
    return line
end

local function OnMyTooltipRelease()
    tooltip = nil
    guild_roster = nil
    guild_roster_mains_count = 0
    guild_roster_alts_count = 0
    guild_roster_alts_built = false
    guild_online = nil
    guild_bymain = nil
    guild_byraid = nil
    guild_byraid_raid_count = 0
    guild_byraid_member_count = 0
    guild_message = nil
    guild_table_line_beg = 1
    guild_table_line_end = 1
    guild_table_body_lines = 0
    guild_title_click_count = 0
end

local function TableBegin(tooltip, body_lines)
    local viewport_lines = math.max(10,math.min(1000,math.floor(tonumber(GuildRosterDeluxeDB.tooltip_viewport_lines))))
    local line_beg = math.max(1,math.min(body_lines - viewport_lines + 1, guild_table_line_beg))
    local line_end = math.max(1,math.min(line_beg + viewport_lines, body_lines + 1))

    guild_table_line_beg = line_beg
    guild_table_line_end = line_end
    guild_table_body_lines = body_lines

    if (guild_table_body_lines <= viewport_lines) then
        tooltip:SetCell(tooltip:AddLine(), 10, " ", ssSmallFont, "RIGHT")
    else
        tooltip:SetCell(tooltip:AddLine(), 10, string.format("%d-%d of %d", guild_table_line_beg, 
            guild_table_line_end - 1, guild_table_body_lines), ssSmallFont, "RIGHT")
    end

    tooltip:AddSeparator()

    return line_beg, line_end
end

local function TableFinish(tooltip)
    local viewport_lines = math.max(10,math.min(1000,math.floor(tonumber(GuildRosterDeluxeDB.tooltip_viewport_lines))))
    tooltip:AddSeparator()
    tooltip:SetCell(tooltip:AddLine(), 1, addon_help, ssSmallFont, "RIGHT", 10)
end

function dataobj.OnEnter(self)

    if (not IsInGuild()) then
        return
    end

    LDB_ANCHOR = self

    if (GuildRosterDeluxeDB.tooltip_click_to_show and guild_title_click_count == 0) then
        return
    end

    BuildFonts()

    if (LibQTip:IsAcquired("GuildRosterDeluxe")) then
        tooltip:Clear()
    else
        tooltip = LibQTip:Acquire("GuildRosterDeluxe", 10)
    end

    if (guild_page == "ONLINE" or guild_page == "ROSTER") then
        tooltip:SetColumnLayout(10, "RIGHT", "RIGHT", "LEFT", "LEFT", "LEFT", "LEFT", "LEFT", "LEFT", "RIGHT", "LEFT")
    elseif (guild_page == "MAINS") then
        tooltip:SetColumnLayout(9, "RIGHT", "LEFT", "LEFT", "LEFT", "RIGHT", "RIGHT", "RIGHT", "LEFT", "LEFT")
    elseif (guild_page == "RAIDS") then
        tooltip:SetColumnLayout(10, "LEFT", "RIGHT", "LEFT", "LEFT", "LEFT", "LEFT", "LEFT", "LEFT", "RIGHT", "LEFT")
    end

    tooltip.OnRelease = OnMyTooltipRelease

    tooltip:SetScale(tonumber(GuildRosterDeluxeDB.tooltip_scale))
    tooltip:SetBackdropColor(0,0,0,1)
    tooltip:SetHeaderFont(ssHeaderFont)
    tooltip:SetFont(ssRegFont)
    tooltip:SmartAnchorTo(self)
    tooltip:SetAutoHideDelay(GuildRosterDeluxeDB.tooltip_autohide, self)

    local line = tooltip:AddLine()
    line = tooltip:SetCell(line, 1, (GetGuildInfo("player") or "Guild")..page_title[guild_page], ssTitleFont, "LEFT", tooltip:GetColumnCount())
    tooltip:SetCellScript(line, 1, "OnMouseUp", OnMouseUp_Title)

    if (not guild_roster) then
        BuildGuildRoster()
    end

    if (guild_page == "ONLINE" or guild_page == "ROSTER") then

        local guild_array = guild_roster

        if (guild_page == "ONLINE") then

            if (not guild_online) then
                guild_online = {}
                for _,entry in ipairs(guild_roster) do
                    if (entry["CONNECTED"]) then
                        table.insert(guild_online, entry)
                    end
                end
             end

            guild_array = guild_online

        end

        table.sort(guild_array, get_sort_function())

        local line_beg,line_end = TableBegin(tooltip, #guild_array)

        line = tooltip:AddHeader()
        line = SetHeaderCell(tooltip, line, 1, "", "LEVEL")
        line = SetHeaderCell(tooltip, line, 2, "")
        line = SetHeaderCell(tooltip, line, 3, "Character", "TOONNAME")
        line = SetHeaderCell(tooltip, line, 4, "Player", "REALNAME")
        line = SetHeaderCell(tooltip, line, 5, "Main", "TOONMAIN")
        line = SetHeaderCell(tooltip, line, 6, _G.RANK, "RANKINDEX")
        line = SetHeaderCell(tooltip, line, 7, "Raid Team", "RAIDNAME")
        line = SetHeaderCell(tooltip, line, 8, _G.ZONE, "ZONENAME")

        if (guild_page == "ROSTER") then
            line = SetHeaderCell(tooltip, line, 9, "Last Online", "LASTONLINE", true)
        else
            line = SetHeaderCell(tooltip, line, 9, " ")
        end

        line = SetHeaderCellNote(tooltip, line, 10)

        tooltip:AddSeparator()

        for i,entry in ipairs(guild_array) do
            if (i >= line_end) then 
                break
            elseif (i >= line_beg) then
                local entryMain = entry["ENTRYMAIN"] or entry

                line = tooltip:AddLine()
                line = tooltip:SetCell(line, 1, FormatLevel(entry, true))
                line = tooltip:SetCell(line, 2, FormatStatus(entry))
                line = tooltip:SetCell(line, 3, FormatToonName(entry, false))
                line = tooltip:SetCell(line, 4, FormatRealName(entry))
                line = tooltip:SetCell(line, 5, FormatToonName(entryMain, entry == entryMain))
                line = tooltip:SetCell(line, 6, entry["RANK"])

                if (entry["RAIDNAME"] ~= "") then
                    line = tooltip:SetCell(line, 7, "|cff00ffff"..entry["RAIDNAME"].."|r")
                end

                line = tooltip:SetCell(line, 8, entry["ZONENAME"])

                if (guild_page == "ROSTER") then
                    line = tooltip:SetCell(line, 9, FormatLastOnline(entry))
                end

                line = SetCellNote(tooltip, line, 10, entry)

                tooltip:SetLineScript(line, "OnMouseUp", OnMouseUp_Entry, entry["TOONNAME"])
            end
        end

        TableFinish(tooltip)

        if (guild_page == "ONLINE") then

            if (guild_message == nil) then
                guild_message = GetGuildRosterMOTD() or ""
            end

            if (guild_message ~= "") then
                line = tooltip:AddLine()
                tooltip:SetCell(line, 1, "|cffffffffGuild Message:|r |cff00ff00"..guild_message.."|r", 
                    ssRegFont, "LEFT", 10)
            end

        else

            line = tooltip:AddLine()
            tooltip:SetCell(line, 1, string.format("|cffffffffRoster Statistics:|r|cff00ff00 %d characters.|r", #guild_roster), 
                ssRegFont, "LEFT", 10)

        end

    elseif (guild_page == "MAINS") then

        if (not guild_roster_alts_built) then
            BuildGuildRosterAlts()
        end

        if (not guild_bymain) then
            guild_bymain = {}
            for _,entry in ipairs(guild_roster) do
                if (not entry["ENTRYMAIN"]) then
                    table.insert(guild_bymain, entry)
                end
            end
        end

        table.sort(guild_bymain, get_sort_function())

        local line_beg,line_end = TableBegin(tooltip, #guild_bymain)

        line = tooltip:AddHeader()
        line = SetHeaderCell(tooltip, line, 1, "", "LEVEL")
        line = SetHeaderCell(tooltip, line, 2, "Main", "TOONNAME")
        line = SetHeaderCell(tooltip, line, 3, "Player", "REALNAME")
        line = SetHeaderCell(tooltip, line, 4, "Sponsor", "TOONREFER")
        line = SetHeaderCell(tooltip, line, 5, "Joined", "JOINDATE", true)
        line = SetHeaderCell(tooltip, line, 6, "Last Online", "LASTONLINE", true)
        line = SetHeaderCell(tooltip, line, 7, "Count", "ALTSCOUNT", true)
        line = SetHeaderCell(tooltip, line, 8, "Alts                                                             ")
        line = SetHeaderCellNote(tooltip, line, 9)

        tooltip:AddSeparator()

        for i,entry in ipairs(guild_bymain) do
            if (i >= line_end) then 
                break
            elseif (i >= line_beg) then
                line = tooltip:AddLine()
                line = tooltip:SetCell(line, 1, FormatLevel(entry, false))
                line = tooltip:SetCell(line, 2, FormatToonName(entry, false))
                line = tooltip:SetCell(line, 3, FormatRealName(entry))

                if (entry["ENTRYREFER"]) then
                    line = tooltip:SetCell(line, 4, FormatToonName(entry["ENTRYREFER"], false))
                end

                line = tooltip:SetCell(line, 5, entry["JOINDATE"])

                local entryLastOnline = entry["ENTRYLASTONLINE"]
                if (entry == entryLastOnline) then
                    line = tooltip:SetCell(line, 6, FormatLastOnline(entry))
                else
                    line = tooltip:SetCell(line, 6, "("..FormatToonName(entryLastOnline)..") "..FormatLastOnline(entryLastOnline))
                end

                local altsCount = entry["ALTSCOUNT"]
                if (altsCount > 0) then
                    line = tooltip:SetCell(line, 7, entry["ALTSCOUNT"])
                    line = tooltip:SetCell(line, 8, FormatAltsArray(entry["ALTSARRAY"]))
                end

                line = SetCellNote(tooltip, line, 9, entry)

                tooltip:SetLineScript(line, "OnMouseUp", OnMouseUp_Entry, entry["TOONNAME"])
            end
        end

        TableFinish(tooltip)

        line = tooltip:AddLine()
        tooltip:SetCell(line, 1, string.format("|cffffffffGuild Statistics:|r|cff00ff00 %d mains, %d alts, %.1f alts/main.|r", 
            guild_roster_mains_count, guild_roster_alts_count, guild_roster_alts_count / math.max(1,guild_roster_mains_count)), 
            ssRegFond, "LEFT", 10)

    elseif (guild_page == "RAIDS") then

        if (not guild_roster_alts_built) then
            BuildGuildRosterAlts()
        end

        if (not guild_byraid) then
            guild_byraid = {}
            guild_byraid_raid_count = 0
            guild_byraid_member_count = 0
            guild_byraid_longest_raid_name = ""

            for _,entry in ipairs(guild_roster) do
                local raidName = entry["RAIDNAME"]
                if (raidName and raidName ~= "") then
                    local raidArray = guild_byraid[raidName]
                    if (not raidArray) then
                        raidArray = {}
                        raidArray["RAIDNAME"] = raidName
                        guild_byraid[raidName] = raidArray
                        table.insert(guild_byraid, raidArray)
                        guild_byraid_raid_count = guild_byraid_raid_count + 1
                        if (#guild_byraid_longest_raid_name < #raidName) then
                            guild_byraid_longest_raid_name = raidName
                        end
                    end
                    table.insert(raidArray, entry)
                    guild_byraid_member_count = guild_byraid_member_count + 1
                end
            end

            table.sort(guild_byraid, function(a, b) return a["RAIDNAME"] < b["RAIDNAME"] end)
        end

        local line_beg,line_end = TableBegin(tooltip, guild_byraid_member_count)

        line = tooltip:AddHeader()
        line = tooltip:SetCell(line, 1, "|cffffffff"..guild_byraid_longest_raid_name.."|r", ssHeaderTransFont, "LEFT")
        line = SetHeaderCell(tooltip, line, 2, "", "LEVEL")
        line = tooltip:SetCell(line, 3, "|cffffffffRL|r", ssHeaderTransFont, "LEFT")
        line = SetHeaderCell(tooltip, line, 4, "Character", "TOONNAME")
        line = SetHeaderCell(tooltip, line, 5, "Player", "REALNAME")
        line = SetHeaderCell(tooltip, line, 6, "Main", "TOONMAIN")
        line = SetHeaderCell(tooltip, line, 7, _G.RANK, "RANKINDEX")
        line = SetHeaderCell(tooltip, line, 8, _G.ZONE, "ZONENAME")
        line = SetHeaderCell(tooltip, line, 9, "Last Online", "LASTONLINE", true)
        line = SetHeaderCellNote(tooltip, line, 10)

        tooltip:AddSeparator()

        local k = 1

        for i,raidArray in ipairs(guild_byraid) do
            if (k >= line_end) then break end
            table.sort(raidArray, get_sort_function())
            for j,entry in ipairs(raidArray) do
                if (k >= line_end) then break end
                k = k + 1
                if (k > line_beg) then
                    if (j == 1 and i > 1 and k > line_beg + 1) then tooltip:AddSeparator() end
                    local entryMain = entry["ENTRYMAIN"] or entry
                    line = tooltip:AddLine()
                    if (j == 1) then
                        line = tooltip:SetCell(line, 1, "|cff00ffff"..raidArray["RAIDNAME"].."|r")
                    elseif (j == 2) then
                        line = tooltip:SetCell(line, 1, string.format("(%d members)", #raidArray))
                    end
                    line = tooltip:SetCell(line, 2, FormatLevel(entry, true))
                    line = tooltip:SetCell(line, 3, FormatStatus(entry, true))
                    line = tooltip:SetCell(line, 4, FormatToonName(entry, false))
                    line = tooltip:SetCell(line, 5, FormatRealName(entry))
                    line = tooltip:SetCell(line, 6, FormatToonName(entryMain, entry == entryMain))
                    line = tooltip:SetCell(line, 7, entry["RANK"])
                    line = tooltip:SetCell(line, 8, entry["ZONENAME"])
                    local entryLastOnline = entryMain["ENTRYLASTONLINE"]
                    if (entry == entryLastOnline) then
                        line = tooltip:SetCell(line, 9, FormatLastOnline(entry))
                    else
                        line = tooltip:SetCell(line, 9, "("..FormatToonName(entryLastOnline)..") "..FormatLastOnline(entryLastOnline))
                    end
                    line = SetCellNote(tooltip, line, 10, entry)
                    tooltip:SetLineScript(line, "OnMouseUp", OnMouseUp_Entry, entry["TOONNAME"])
                end
            end
        end

        TableFinish(tooltip)

        line = tooltip:AddLine()
        tooltip:SetCell(line, 1, string.format("|cffffffffRaid Statistics:|r|cff00ff00 %d members in %d raids.|r",
            guild_byraid_member_count, guild_byraid_raid_count), ssRegFont, "LEFT", 10)
    end

--    tooltip:UpdateScrolling()
    tooltip:SetScript("OnMouseWheel", OnMouseWheel_Scroll)
    tooltip:Show()
end

frame:SetScript("OnEvent", 
    function(self, event, ...) 
        if self[event] then 
            return self[event](self, event, ...) 
        end
    end
)

local DELAY = 15            -- Update every 15 seconds
local elapsed = DELAY - 5   --   ... but first update in 5 seconds

frame:SetScript("OnUpdate",
    function (self, el)
        elapsed = elapsed + el
        if elapsed >= DELAY then
            elapsed = 0
            update_Broker()
        end
        if (ctr_timeout > 0) then
            ctr_elapsed = ctr_elapsed + el
            if (ctr_elapsed >= ctr_timeout) then
                ctr_timeout = 0
                ctr_elapsed = 0
            end
        end
    end
)

function frame:PLAYER_LOGIN()
    if (not GuildRosterDeluxeDB) then
        GuildRosterDeluxeDB = {
            ONLINE = "TOONNAME",
            RAIDS = "TOONNAME",
            MAINS = "TOONNAME",
            ROSTER = "TOONNAME",
            tooltip_autohide = 0.25,
            tooltip_scale = 0.8,
            tooltip_viewport_lines = 30,
            tooltip_viewport_scroll = 15,
            DEBUG = false,
            tooltip_click_to_show = false,
        }
    end
    if (not GuildRosterDeluxeDB.tooltip_click_to_show) then
        GuildRosterDeluxeDB.tooltip_click_to_show = false
    end
    if (not GuildRosterDeluxeDB.show_LDB_guild_name) then
        GuildRosterDeluxeDB.show_LDB_guild_name = false
    end
end

frame:RegisterEvent("PLAYER_LOGIN")

function frame:GUILD_ROSTER_UPDATE()
    update_Broker()
end

frame:RegisterEvent("GUILD_ROSTER_UPDATE")

frame:RegisterEvent("GROUP_ROSTER_UPDATE")

function frame:GROUP_ROSTER_UPDATE()
    if (ctr_timeout > 0) then
        AutoConvertToRaid(false)
    end
end

GuildRoster()
