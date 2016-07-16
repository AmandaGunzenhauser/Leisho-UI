﻿local E, L, V, P, G = unpack(ElvUI);
local LT = E:GetModule('SLE_Loot')

local function configTable()
	E.Options.args.sle.args.options.args.loot = {
		order = 9,
		type = "group",
		name = L['Loot'],
		args = {
			enable = {
				order = 1,
				type = "toggle",
				name = ENABLE,
				get = function(info) return E.db.sle.loot.enable end,
				set = function(info, value) E.db.sle.loot.enable = value; E:StaticPopup_Show("CONFIG_RL") end
			},
			space1 = {
				order = 2,
				type = 'description',
				name = "",
			},
			autoroll = {
				order = 1,
				type = "group",
				name = L["Loot Auto Roll"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Loot Auto Roll"],
					},
					info = {
						order = 2,
						type = "description",
						name = L["LOOT_AUTO_DESC"],
					},
					space1 = {
						order = 3,
						type = 'description',
						name = "",
					},
					enable = {
						order = 4,
						type = "toggle",
						name = ENABLE,
						disabled = function() return not E.db.sle.loot.enable end,
						get = function(info) return E.db.sle.loot.autoroll.enable end,
						set = function(info, value) E.db.sle.loot.autoroll.enable = value; LT:Update() end,
					},
					space2 = {
						order = 5,
						type = 'description',
						name = "",
					},
					autoconfirm = {
						order = 6,
						type = "toggle",
						name = L["Auto Confirm"],
						desc = L["Automatically click OK on BOP items"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						get = function(info) return E.db.sle.loot.autoroll.autoconfirm end,
						set = function(info, value) E.db.sle.loot.autoroll.autoconfirm = value end,
					},
					autogreed = {
						order = 7,
						type = "toggle",
						name = L["Auto Greed"],
						desc = L["Automatically greed uncommon (green) quality items at max level"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						get = function(info) return E.db.sle.loot.autoroll.autogreed end,
						set = function(info, value) E.db.sle.loot.autoroll.autogreed = value end,
					},
					autode = {
						order = 8,
						type = "toggle",
						name = L["Auto Disenchant"],
						desc = L["Automatically disenchant uncommon (green) quality items at max level"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						get = function(info) return E.db.sle.loot.autoroll.autode end,
						set = function(info, value) E.db.sle.loot.autoroll.autode = value; end,
					},
					autoqlty = {
						order = 9,
						type = "select",
						name = L["Loot Quality"],
						desc = L["Sets the auto greed/disenchant quality\n\nUncommon: Rolls on Uncommon only\nRare: Rolls on Rares & Uncommon"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						get = function(info) return E.db.sle.loot.autoroll.autoqlty end,
						set = function(info, value) E.db.sle.loot.autoroll.autoqlty = value; end,
						values = {
							[4] = "|cffA335EE"..ITEM_QUALITY4_DESC.."|r",
							[3] = "|cff0070DD"..ITEM_QUALITY3_DESC.."|r",
							[2] = "|cff1EFF00"..ITEM_QUALITY2_DESC.."|r",
						},
					},
					space3 = {
						order = 10,
						type = 'description',
						name = "",
					},
					bylevel = {
						order = 11,
						type = "toggle",
						name = L["Roll based on level."],
						desc = L["This will auto-roll if you are above the given level if: You cannot equip the item being rolled on, or the ilevel of your equipped item is higher than the item being rolled on or you have an heirloom equipped in that slot"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						get = function(info) return E.db.sle.loot.autoroll.bylevel end,
						set = function(info, value) E.db.sle.loot.autoroll.bylevel = value; end,
					},
					level = {
						order = 12,
						type = "range",
						name = L["Level to start auto-rolling from"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.autoroll.enable end,
						min = 1, max = GetMaxPlayerLevel(), step = 1,
						get = function(info) return E.db.sle.loot.autoroll.level end,
						set = function(info, value) E.db.sle.loot.autoroll.level = value; end,
					},
				},
			},
			announcer = {
				order = 2,
				type = "group",
				name = L["Loot Announcer"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L['Loot Announcer'],
					},
					info = {
						order = 2,
						type = "description",
						name = L["AUTOANNOUNCE_DESC"],
					},
					space1 = {
						order = 3,
						type = 'description',
						name = "",
					},
					enable = {
						order = 4,
						type = "toggle",
						name = ENABLE,
						disabled = function() return not E.db.sle.loot.enable end,
						get = function(info) return E.db.sle.loot.announcer.enable end,
						set = function(info, value) E.db.sle.loot.announcer.enable = value; E:StaticPopup_Show("CONFIG_RL") end,
					},
					space2 = {
						order = 5,
						type = "description",
						name = "",
					},
					auto = {
						order = 6,
						type = "toggle",
						name = L["Auto Announce"],
						desc = L["AUTOANNOUNCE_DESC"],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.announcer.enable end,
						get = function(info) return E.db.sle.loot.announcer.auto end,
						set = function(info, value) E.db.sle.loot.announcer.auto = value; end,
					},
					override = {
						order = 7,
						type = "select",
						name = L["Manual Override"],
						desc = L["Sets the button for manual override."],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.announcer.enable end,
						get = function(info) return E.db.sle.loot.announcer.override end,
						set = function(info, value) E.db.sle.loot.announcer.override = value; end,
						values = {
							['1'] = "No Override",
							['2'] = "Automatic Override",
							['3'] = "SHIFT",
							['4'] = "ALT",
							['5'] = "CTRL",
						},
					},
					space3 = {
						order = 8,
						type = "description",
						name = "",
					},
					quality = {
						order = 9,
						type = "select",
						name = L["Loot Quality"],
						desc = L["Sets the minimum loot threshold to announce."],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.announcer.enable end,
						get = function(info) return E.db.sle.loot.announcer.quality end,
						set = function(info, value) E.db.sle.loot.announcer.quality = value; end,
						values = {
							['EPIC'] = "|cffA335EE"..ITEM_QUALITY4_DESC.."|r",
							['RARE'] = "|cff0070DD"..ITEM_QUALITY3_DESC.."|r",
							['UNCOMMON'] = "|cff1EFF00"..ITEM_QUALITY2_DESC.."|r",
						},
					},
					channel = {
						order = 10,
						type = "select",
						name = L["Chat"],
						desc = L["Select chat channel to announce loot to."],
						disabled = function() return not E.db.sle.loot.enable or not E.db.sle.loot.announcer.enable end,
						get = function(info) return E.db.sle.loot.announcer.channel end,
						set = function(info, value) E.db.sle.loot.announcer.channel = value; end,
						values = {
							['RAID'] = "|cffFF7F00"..RAID.."|r",
							['PARTY'] = "|cffAAAAFF"..PARTY.."|r",
							['SAY'] = "|cffFFFFFF"..SAY.."|r",
						},
					},
				},
			},
			history = {
				order = 3,
				type = "group",
				name = L["Loot Roll History"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Loot Roll History"],
					},
					info = {
						order = 2,
						type = "description",
						name = L["LOOTH_DESC"],
					},
					window = {
						order = 3,
						type = "toggle",
						name = L["Auto hide"],
						desc = L["Automaticaly hides Loot Roll Histroy frame when leaving the instance."],
						disabled = function() return not E.db.sle.loot.enable end,
						get = function(info) return E.db.sle.loot.history.autohide end,
						set = function(info, value) E.db.sle.loot.history.autohide = value; LT:LootShow() end,
					},
					alpha = {
						order = 4,
						type = "range",
						name = L['Alpha'],
						desc = L["Sets the alpha of Loot Roll Histroy frame."],
						min = 0.2, max = 1, step = 0.1,
						disabled = function() return not E.db.sle.loot.enable end,
						get = function(info) return E.db.sle.loot.history.alpha end,
						set = function(info, value) E.db.sle.loot.history.alpha = value; LT:Update() end,
					},
				},
			},
		},
	}
end

table.insert(E.SLEConfigs, configTable)