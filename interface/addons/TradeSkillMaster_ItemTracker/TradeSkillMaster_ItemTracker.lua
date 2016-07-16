-- ------------------------------------------------------------------------------ --
--                          TradeSkillMaster_ItemTracker                          --
--          http://www.curse.com/addons/wow/tradeskillmaster_itemtracker          --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- register this file with Ace Libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TSM_ItemTracker")

function TSM:OnInitialize()
	DisableAddOn("TradeSkillMaster_ItemTracker")
	StaticPopupDialogs["TSMItemTrackerRemoved"] = {
		text = "TradeSkillMaster_ItemTracker is no longer part of the TSM suite as its functionality has been merged into the core addon. It has been automatically disabled, but please uninstall it.",
		button1 = OKAY,
		timeout = 0,
	}
	TSMAPI.Util:ShowStaticPopupDialog("TSMItemTrackerRemoved")
end
