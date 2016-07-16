-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster Locale - esMX
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkill-Master/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster", "esMX")
if not L then return end

-- L["Account Syncing"] = ""
-- L["Active Contributors:"] = ""
-- L["Acts as a link between the other TradeSkillMaster modules and the TSM Desktop Application."] = ""
-- L["A custom price of %s for %s evaluates to %s."] = ""
-- L["Add >>>"] = ""
-- L["Add Additional Operation"] = ""
L["Additional error suppressed"] = "Error Adicional Suprimido"
-- L["A group is a collection of items which will be treated in a similar way by TSM's modules."] = ""
-- L["AH"] = ""
-- L["Alarm Clock"] = ""
-- L["All items in this group and its subgroups will be moved to the parent group and this group and all of its subgroups will be deleted."] = ""
-- L["All items in this group and its subgroups will be removed and this group and all of its subgroups will be deleted."] = ""
-- L["Allows for testing of custom prices."] = ""
L["Allows you to build a queue of crafts that will produce a profitable, see what materials you need to obtain, and actually craft the items."] = "Le permite construir una cola de artesanías que producirá un rentable, ver los materiales que necesita obtener, y actualmente los artículos necesarios."
-- L["Allows you to quickly and easily empty your mailbox as well as automatically send items to other characters with the single click of a button."] = ""
-- L["A maximum of 1 convert() function is allowed."] = ""
-- L["A(n) %s operation named '%s' already exists! Would you like to replace the existing operation, skip importing this operation, or cancel the entire import?"] = ""
-- L["Any guilds which are selected will be ignored for inventory tracking purposes."] = ""
-- L["Appearance"] = ""
-- L["Appearance Data"] = ""
-- L["Appearance Settings"] = ""
-- L["Applied %s to %s."] = ""
-- L["Apply Operation to Group"] = ""
-- L["Are you sure you want to delete the selected profile?"] = ""
-- L["Are you sure you want to delete this group?"] = ""
-- L["Are you sure you want to delete this operation?"] = ""
-- L["Are you sure you want to overwrite the current profile with the selected profile?"] = ""
-- L["A simple, fixed gold amount."] = ""
-- L["Auctionator - Auction Value"] = ""
-- L["Auction Buys"] = ""
-- L["Auctioneer - Appraiser"] = ""
-- L["Auctioneer - Market Value"] = ""
-- L["Auctioneer - Minimum Buyout"] = ""
-- L["Auction Frame Scale"] = ""
L["Auction House Tab Settings"] = "Pestaña de configuración de la Casa de subastas"
-- L["Auction Rows (Requires Reload)"] = ""
-- L["Auctions"] = ""
-- L["Auction Sales"] = ""
-- L["Auction Window Close"] = ""
-- L["Auction Window Open"] = ""
-- L["Auto Quest Complete"] = ""
-- L["Bags"] = ""
-- L["Bank"] = ""
-- L["BankUI"] = ""
-- L["BankUI Move Delay"] = ""
-- L["BankUI Settings"] = ""
-- L["Below are various ways you can set the value of the current editbox. Any combination of these methods is also supported."] = ""
-- L["Below are your currently available price sources organized by module. The %skey|r is what you would type into a custom price box."] = ""
-- L["Below is a list of groups which this operation is currently applied to. Clicking on the 'Remove' button next to the group name will remove the operation from that group."] = ""
-- L["Below, set the custom price that will be evaluated for this custom price source."] = ""
-- L["Border Thickness (Requires Reload)"] = ""
-- L["Buy from Vendor"] = ""
-- L["Cancelled - Bags and Bank / Guild Vault are full"] = ""
-- L["Cancelled - Bags are full"] = ""
-- L["Cancelled - Bank / Guild Vault is full"] = ""
-- L["Cancelled - You must be at a bank or GuildVault"] = ""
-- L["Can't load TSM tooltip while in combat"] = ""
-- L["Cash Register"] = ""
-- L["Category Text 2 (Requires Reload)"] = ""
-- L["Category Text (Requires Reload)"] = ""
-- L["|cff99ffffValue:|r "] = ""
-- L["|cffff0000IMPORTANT:|r Your TSM profile has been reset to the 'Default' profile as part of a recent update. None of your settings have been lost, but on characters where you wish to use another profile, you'll need to manually change it back."] = ""
-- L["|cffff0000Your TSM addons are out of date!|r Please DO NOT report this error, but instead update your TSM addons from here:"] = ""
-- L["|cffffff00DO NOT report this as an error to the developers.|r If you require assistance with this, join our IRC channel or make a post on the TSM forums instead."] = ""
-- L["|cffffff00Important Note:|r An update is available for %s. You should update as soon as possible to ensure TSM continues to function properly."] = ""
--[==[ L[ [=[|cffffff00Important Note:|r You do not currently have any modules installed / enabled for TradeSkillMaster! |cff77ccffYou must download modules for TradeSkillMaster to have some useful functionality!|r

Please visit http://www.curse.com/addons/wow/tradeskill-master and check the project description for links to download modules.]=] ] = "" ]==]
--[==[ L[ [=[|cffffff00TSM Scan Blocked|r

Another module is currently scanning. Stop the other module's scan before retrying this scan.]=] ] = "" ]==]
-- L["Changes how many rows are shown in the auction results tables."] = ""
L["Changes the size of the auction frame. The size of the detached TSM auction frame will always be the same as the main auction frame."] = "Cambia el tamaño del marco de la subasta. El tamaño de la trama de subasta TSM individual siempre será el mismo que el marco principal de la subasta."
-- L["Changes to the specified profile (i.e. '/tsm profile Default' changes to the 'Default' profile)"] = ""
-- L["Character Name on Other Account"] = ""
-- L["Characters"] = ""
-- L["Chat Tab"] = ""
-- L["Check out our completely free, desktop application which has tons of features including deal notification emails, automatic updating of AuctionDB prices, automatic TSM setting backup, and more! You can find this app by going to %s."] = ""
-- L["Check this box to override this group's operation(s) for this module."] = ""
-- L["Clean Bags Automatically"] = ""
-- L["Clean Bank Automatically"] = ""
-- L["Clean Reagent Bank Automatically"] = ""
-- L["Clear"] = ""
-- L["Clear Selection"] = ""
-- L["Click the button below to open the export frame for this group."] = ""
-- L["Click this button to completely remove this operation from the specified group."] = ""
-- L["Click this button to configure the currently selected operation."] = ""
-- L["Click this button to create a new operation for this module."] = ""
-- L["Click this button to send this group to the selected character. TSM will print out the operation in chat."] = ""
-- L["Click this button to show a frame for easily exporting the list of items which are in this group."] = ""
-- L["Click to change what is shown in this column."] = ""
-- L["Coins (%s)"] = ""
-- L["Connected to %s"] = ""
-- L["Connecting to %s..."] = ""
-- L["Connection established!"] = ""
-- L["Content - Backdrop"] = ""
-- L["Content - Border"] = ""
-- L["Content Text - Disabled"] = ""
-- L["Content Text - Enabled"] = ""
-- L["Copy From"] = ""
-- L["Copy the settings from one existing profile into the currently active profile."] = ""
-- L["CostBasis"] = ""
-- L["Could not find profile '%s'. Possible profiles: '%s'"] = ""
-- L["Create Macro and Bind Scroll Wheel"] = ""
-- L["Create New Operation"] = ""
-- L["Create New Subgroup"] = ""
-- L["Creating a relationship for this setting will cause the setting for this operation to be equal to the equivalent setting of another operation."] = ""
-- L["Crystals"] = ""
-- L["Current Auctions Value"] = ""
-- L["Current Profile:"] = ""
-- L["Custom Price for this Source"] = ""
-- L["Custom Price Source"] = ""
-- L["Custom Price Source Name"] = ""
-- L["Custom Price Sources"] = ""
-- L["Custom price sources allow you to create more advanced custom prices throughout all of the TSM modules. Just as you can use the built-in price sources such as 'vendorsell' and 'vendorbuy' in your custom prices, you can use ones you make here (which themselves are custom prices)."] = ""
-- L["Custom price sources to display in item tooltips:"] = ""
-- L["Default BankUI Tab"] = ""
-- L["Default Group Tab"] = ""
-- L["Default %s Operation Tab"] = ""
-- L["Default Tab"] = ""
-- L["Default Tab (Open Auction House to Enable)"] = ""
-- L["Delete a Profile"] = ""
-- L["Delete Custom Price Source"] = ""
-- L["Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file."] = ""
-- L["Delete Group"] = ""
-- L["Delete Operation"] = ""
-- L["Deselect All Groups"] = ""
-- L["Deselects all items in both columns."] = ""
-- L["Destroy Value"] = ""
-- L["Destroy Values"] = ""
-- L["Destroy Value Source:"] = ""
-- L[" Details: "] = ""
-- L["Disenchant Value:"] = ""
-- L["Disenchant Value x%s:"] = ""
-- L["Display Detailed Destroy Tooltips"] = ""
-- L["Display disenchant value in tooltip."] = ""
-- L["Display group name in tooltip"] = ""
-- L["Display mill value in tooltip."] = ""
-- L["Display Operation Names in Tooltip for Modules:"] = ""
-- L["Display prospect value in tooltip."] = ""
-- L["Display transform value in tooltip."] = ""
-- L["Display vendor buy price in tooltip."] = ""
-- L["Display vendor sell price in tooltip."] = ""
-- L["Done"] = ""
-- L["Double-click to collapse this item and show only the cheapest auction."] = ""
-- L["Double-click to expand this item and show all the auctions."] = ""
-- L["Down"] = ""
-- L["Duplicate Operation"] = ""
L["Dust"] = "Polvo"
-- L["Embed TSM Tooltips"] = ""
-- L["Empty parentheses are not allowed"] = ""
-- L["Empty price string."] = ""
-- L["Enable Auction Buys Feature"] = ""
-- L["Enable Auction Sales Feature"] = ""
-- L["Enable Sound"] = ""
-- L["Enable Tweet Enhancement (Only Works if WoW Twitter Integration is Setup)"] = ""
-- L["Enhances the vendor frame by allowing you to easily buy and sell items."] = ""
-- L["Error creating custom price source. Custom price source with name '%s' already exists."] = ""
-- L["Error creating group. Group with name '%s' already exists."] = ""
-- L["Error creating operation. Operation with name '%s' already exists."] = ""
-- L["Error creating subgroup. Subgroup with name '%s' already exists."] = ""
-- L["Error duplicating operation. Operation with name '%s' already exists."] = ""
L["Error Info:"] = "Información del error:   "
-- L["Error moving group. Group '%s' already exists."] = ""
-- L["Error moving group. You cannot move this group to one of its subgroups."] = ""
-- L["Error renaming custom price source. Custom price source with name '%s' already exists."] = ""
-- L["Error renaming group. Group with name '%s' already exists."] = ""
-- L["Error renaming operation. Operation with name '%s' already exists."] = ""
L["Essences"] = "Esencias"
-- L["Establishing connection to %s. Make sure that you've entered this character's name on the other account."] = ""
-- L["Examples"] = ""
-- L["Existing Profiles"] = ""
-- L["Exploration"] = ""
-- L["Export Appearance Settings"] = ""
-- L["Export Group Items"] = ""
-- L["Export Items in Group"] = ""
-- L["Export Operation"] = ""
-- L["Failed to send group to %s."] = ""
-- L["Filter:"] = ""
-- L["First, log into a character on the same realm (and faction) on both accounts. Type the name of the OTHER character you are logged into in the box below. Once you have done this on both accounts, TSM will do the rest automatically. Once setup, syncing will automatically happen between the two accounts while on any character on the account (not only the one you entered during this setup)."] = ""
-- L["Fishing Reel In"] = ""
-- L["Fixed Gold Value"] = ""
-- L["Forget Characters"] = ""
-- L["Frame Background - Backdrop"] = ""
-- L["Frame Background - Border"] = ""
-- L["Full"] = ""
-- L["General"] = ""
-- L["General Options"] = ""
L["General Settings"] = "Configuración General"
-- L["Give the group a new name. A descriptive name will help you find this group later."] = ""
-- L["Give the new group a name. A descriptive name will help you find this group later."] = ""
-- L["Give the new operation a name. A descriptive name will help you find this operation later."] = ""
-- L["Give this operation a new name. A descriptive name will help you find this operation later."] = ""
-- L["Give your new custom price source a name. This is what you will type in to custom prices and is case insensitive (everything will be saved as lower case)."] = ""
-- L["Goblineer (by Sterling - The Consortium)"] = ""
-- L["Gold Info:"] = ""
-- L["Group"] = ""
-- L["Group:"] = ""
-- L["Group(Base Item):"] = ""
-- L["Group Item Data"] = ""
-- L["Group Item Filter Value"] = ""
-- L["Group Items:"] = ""
-- L["Group Management"] = ""
-- L["Group Name"] = ""
-- L["Group names cannot contain %s characters."] = ""
-- L["Groups"] = ""
-- L["Guilds"] = ""
-- L["GVault"] = ""
-- L["Help"] = ""
-- L["Here you can filter the item lists below. You can enter a simple string to filter by, or a more complex filter which includes item level, rarity, price, etc. Ex: '/weapon/i600/epic/100g/500g'"] = ""
-- L["Here you can setup relationships between the settings of this operation and other operations for this module. For example, if you have a relationship set to OperationA for the stack size setting below, this operation's stack size setting will always be equal to OperationA's stack size setting."] = ""
L["Hide Minimap Icon"] = "Ocultar el ícono del Minimapa"
-- L["Icon Region"] = ""
-- L["If checked, a detailed list of items which an item destroys into will be displayed below the destroy value in the tooltip."] = ""
-- L["If checked, after moving items using BankUI at the bank your bank bags will be automatically sorted / re-stacked."] = ""
-- L["If checked, after moving items using BankUI at the bank your reagent bank bags will be automatically sorted / re-stacked."] = ""
-- L["If checked, after moving items using BankUI your bags will be automatically sorted / re-stacked."] = ""
-- L["If checked, all operations will be exported, including all of their settings."] = ""
-- L["If checked, any items you import that are already in a group will be moved out of their current group and into this group. Otherwise, they will simply be ignored."] = ""
-- L["If checked, only items which are in the parent group of this group will be imported."] = ""
-- L["If checked, operations will be stored globally rather than by profile. TSM groups are always stored by profile. Note that if you have multiple profiles setup already with separate operation information, changing this will cause all but the current profile's operations to be lost."] = ""
-- L["If checked, the disenchant value of the item will be shown. This value is calculated using the average market value of materials the item will disenchant into."] = ""
-- L["If checked, the mill value of the item will be shown. This value is calculated using the average market value of materials the item will mill into."] = ""
-- L["If checked, the price of buying the item from a vendor is displayed."] = ""
-- L["If checked, the price of selling the item to a vendor displayed."] = ""
-- L["If checked, the prospect value of the item will be shown. This value is calculated using the average market value of materials the item will prospect into."] = ""
-- L["If checked, the structure of the subgroups will be included in the export. Otherwise, the items in this group (and all subgroups) will be exported as a flat list."] = ""
-- L["If checked, the transform value of the item will be shown. This value is calculated using the average market value of materials the item will disenchant into."] = ""
-- L["If checked, this custom price will be displayed in item tooltips."] = ""
-- L["If checked, TSM's tooltip lines will be embedded in the item tooltip. Otherwise, it will show as a separate box below the item's tooltip."] = ""
-- L["If checked, TSM will provent WoW from closing the auction house frame when other UI frames are opened."] = ""
-- L["If checked, your bags will be automatically opened when you open the auction house."] = ""
-- L["If you delete, rename, or transfer a character off the current faction/realm, you should remove it from TSM's list of characters using this dropdown."] = ""
-- L["If you have multiple profile set up with operations, enabling this will cause all but the current profile's operations to be irreversibly lost. Are you sure you want to continue?"] = ""
-- L["If you have WoW's Twitter integration setup, TSM will add a share link to its enhanced auction sale / purchase messages (enabled above) as well as replace the URL in item tweets with a TSM link."] = ""
-- L["Ignore Guilds"] = ""
-- L["Ignore Operation on Characters:"] = ""
-- L["Ignore Operation on Faction-Realms:"] = ""
-- L["Ignore Random Enchants on Ungrouped Items"] = ""
-- L["Ignores"] = ""
-- L["I just bought [%s]x%d for %s! %s #TSM3 #warcraft"] = ""
-- L["I just sold [%s] for %s! %s #TSM3 #warcraft"] = ""
L["I'll Go There Now!"] = "Iré allí ahora!"
-- L["I'll Go Update!"] = ""
-- L["ilvl"] = ""
-- L["Import Appearance Settings"] = ""
-- L["Import / Export"] = ""
-- L["Import/Export"] = ""
-- L["Import Items"] = ""
-- L["Import Operation Settings"] = ""
-- L["Import Preset TSM Theme"] = ""
-- L["Import String"] = ""
-- L["Include Operations"] = ""
-- L["Include Subgroup Structure"] = ""
-- L["Incoming Auction Sales"] = ""
-- L["Info"] = ""
-- L["Invalid appearance data."] = ""
-- L["Invalid custom price."] = ""
-- L["Invalid function."] = ""
-- L["Invalid import string."] = ""
-- L["Invalid item link."] = ""
-- L["Invalid operator at end of custom price."] = ""
-- L["Invalid parameter to price source."] = ""
-- L["Invalid parent argument type. Expected table, got %s."] = ""
-- L["Invalid price source in convert."] = ""
-- L["Invalid word: '%s'"] = ""
-- L["Inventory:"] = ""
-- L["Inventory Tooltip Format:"] = ""
-- L["Inventory Viewer"] = ""
-- L["It appears that you've manually copied your saved variables between accounts which will cause TSM's automatic sync'ing to not work. You'll need to undo this, and/or delete the TradeSkillMaster and TSM_Crafting saved variables files on both accounts (with WoW closed) in order to fix this."] = ""
-- L["Item"] = ""
-- L["Item links may only be used as parameters to price sources."] = ""
-- L["Item Name"] = ""
-- L["Items"] = ""
-- L["Item Search"] = ""
-- L["Item Tooltip Text"] = ""
-- L["Jaded (by Ravanys - The Consortium)"] = ""
L["Just incase you didn't read this the first time:"] = "En caso de que no leyó la primera vez:"
-- L["Keep Items in Parent Group"] = ""
-- L["Keeps track of all your sales and purchases from the auction house allowing you to easily track your income and expenditures and make sure you're turning a profit."] = ""
-- L["Known Characters: "] = ""
-- L["Label Text - Disabled"] = ""
-- L["Label Text - Enabled"] = ""
-- L["Level Up"] = ""
-- L["Light (by Ravanys - The Consortium)"] = ""
-- L["Link Text 2 (Requires Reload)"] = ""
-- L["Link Text (Requires Reload)"] = ""
-- L["Load Saved Theme"] = ""
-- L["Looks like an |cffff0000unofficial|r TSM module has encountered an error. Please do not report this to the TSM team, but instead report it to the author of the addon. If it's affecting the operation of TSM, you may want to disable it."] = ""
-- L["Looks like TradeSkillMaster has detected an error with your configuration. Please address this in order to ensure TSM remains functional."] = ""
-- L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by copying the entire error below and following the instructions for reporting lua errors listed at the following URL:"] = ""
L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by following the instructions shown."] = "Parece que TradeSkillMaster ha encontrado un error. Por favor, ayuda el autor solucionar este error, siguiendo las instrucciones que se muestran."
-- L["Loop detected in the following custom price:"] = ""
-- L["Macro created and scroll wheel bound!"] = ""
-- L["Macro Setup"] = ""
-- L["Mail"] = ""
L["Make Auction Frame Movable"] = "Hace movible el Marco de la Subasta"
-- L["Management"] = ""
L["Manages your inventory by allowing you to easily move stuff between your bags, bank, and guild bank."] = "Gestiona el inventario por lo que le permite moverse con facilidad las cosas entre su bolsas, banco, y el banco de la hermandad."
-- L["Many commonly-used buttons in TSM can be macro'd and bound to your scroll wheel. Below, select the buttons you would like to include in this macro and the modifier(s) you would like to use with the scroll wheel."] = ""
-- L["Map Ping"] = ""
-- L["Medium Text Size (Requires Reload)"] = ""
L["Mills, prospects, and disenchants items at super speed!"] = "Farmea, prospecta y desencanta Items a velocidad super!"
-- L["Mill Value:"] = ""
-- L["Mill Value x%s:"] = ""
-- L["Misc. Features"] = ""
-- L["Misplaced comma"] = ""
-- L["Modifiers:"] = ""
-- L["Module Features"] = ""
-- L["Module Information:"] = ""
-- L["Module Options"] = ""
-- L["Money Frame Open"] = ""
-- L["More Advanced Methods"] = ""
-- L["Move Already Grouped Items"] = ""
-- L["Move Already Grouped Items on Other Account"] = ""
-- L["Moved %s to %s."] = ""
-- L["Move Group"] = ""
-- L["Move to Top Level"] = ""
-- L["New"] = ""
-- L["New Custom Price Source"] = ""
-- L["New Group"] = ""
-- L["New Operation"] = ""
-- L["New Parent Group"] = ""
-- L["New Subgroup Name"] = ""
-- L["None"] = ""
-- L["None (Always Show)"] = ""
-- L["None of your groups have %s operations assigned. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to assign operations to your TSM groups."] = ""
-- L["<No Operation>"] = ""
-- L["No profile specified. Possible profiles: '%s'"] = ""
-- L["<No Relationship>"] = ""
-- L["Normal Text Size (Requires Reload)"] = ""
-- L["No Sound"] = ""
-- L["Offline"] = ""
-- L["Only Import Items from Parent Group"] = ""
-- L["Only show TSM's tooltip when the selected modifier is pressed."] = ""
-- L["Open All Bags with Auction House"] = ""
-- L["Opens the TSM window to the '%s' page"] = ""
-- L["Operation #%d"] = ""
-- L["Operation Data"] = ""
-- L["Operation Management"] = ""
-- L["Operation Name"] = ""
-- L["Operations"] = ""
-- L["Operations: %s"] = ""
L["Options"] = "Opciones"
-- L["Options / Core Features"] = ""
-- L["Override Module Operations"] = ""
-- L["Parent Group Items:"] = ""
-- L["Parent/Ungrouped Items:"] = ""
-- L["Past Contributers (Special Thanks):"] = ""
-- L["Paste the exported items into this box and hit enter or press the 'Okay' button. The recommended format for the list of items is a comma separated list of itemIDs for general items. For battle pets, the entire battlepet string should be used. For randomly enchanted items, the format is <itemID>:<randomEnchant> (ex: 38472:-29)."] = ""
-- L["Paste the exported operation settings into this box and hit enter or press the 'Okay' button. Imported settings will irreversibly replace existing settings for this operation."] = ""
--[==[ L[ [=[Paste the list of items into the box below and hit enter or click on the 'Okay' button.

You can also paste an itemLink into the box below to add a specific item to this group.]=] ] = "" ]==]
-- L["Percent of Price Source"] = ""
L["Performs scans of the auction house and calculates the market value of items as well as the minimum buyout. This information can be shown in items' tooltips as well as used by other modules."] = "Realiza exploraciones de la casa de subastas y calcula el valor de mercado de los artículos, así como la compra mínima. Esta información se puede mostrar en la los tooltips de los artículos, así como el usado por otros módulos."
-- L["Player Gold"] = ""
-- L["Player Invite Accept"] = ""
-- L["Play the selected sound when one of your auctions sells."] = ""
-- L["Posts and cancels your auctions to / from the auction house according to pre-set rules. Also, this module can show you markets which are ripe for being reset for a profit."] = ""
-- L["Prints out the available price sources for use in custom price boxes."] = ""
-- L["Prints out the version numbers of all installed modules"] = ""
-- L["Profile changed to '%s'."] = ""
-- L["Profiles"] = ""
-- L["Prospect Value:"] = ""
-- L["Prospect Value x%s:"] = ""
-- L["Protect AH Frame (Requires Reload)"] = ""
L["Provides interfaces for efficiently searching for items on the auction house. When an item is found, it can easily be bought, canceled (if it's yours), or even posted from your bags."] = "Proporciona interfaces para la búsqueda eficaz de los Items de la casa de subastas. Cuando se encuentra un Item, que puede ser fácilmente comprado, cancelado (si es suyo), o incluso publicado desde sus bolsas."
-- L["Quest Added"] = ""
-- L["Quest Completed"] = ""
-- L["Quest Objectives Complete"] = ""
-- L["Raid Warning"] = ""
-- L["Ready Check"] = ""
-- L["Refresh Sync Status"] = ""
-- L["Region - Backdrop"] = ""
-- L["Region - Border"] = ""
-- L["Relationships"] = ""
-- L["Remove"] = ""
-- L["<<< Remove"] = ""
-- L["Remove Account"] = ""
-- L["Removed '%s' as a custom price source. Be sure to update any custom prices that were using this source."] = ""
-- L["<Remove Operation>"] = ""
-- L["Rename Custom Price Source"] = ""
-- L["Rename Group"] = ""
-- L["Rename Operation"] = ""
-- L["Replace"] = ""
-- L["Reset Profile"] = ""
-- L["Resets the position, scale, and size of all applicable TSM and module frames."] = ""
-- L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = ""
-- L["Resources:"] = ""
-- L["Restore Default Colors"] = ""
-- L["Restores all the color settings below to their default values."] = ""
-- L["Saved theme: %s."] = ""
-- L["Save Theme"] = ""
-- L["Scroll Wheel Direction:"] = ""
L["%sDrag%s to move this button"] = "%sArrastrar%s"
-- L["See instructions above this editbox."] = ""
-- L["See the following URL for more info."] = ""
-- L["Select a group from the list below and click 'OK' at the bottom."] = ""
-- L["Select All Groups"] = ""
-- L["Select an online character on one of your other accounts to send this group to using the dropdown below and then click on the button."] = ""
-- L["Select an operation to apply to this group."] = ""
-- L["Select a %s operation using the dropdown above."] = ""
-- L["Select a theme from this dropdown to import one of the preset TSM themes."] = ""
-- L["Select a theme from this dropdown to import one of your saved TSM themes."] = ""
-- L["Select how much detail should be shown in item tooltips with respect to inventory information."] = ""
-- L["Select how TSM will format prices in item tooltips."] = ""
-- L["Select the default tab for this module's operations."] = ""
-- L["Select the price source for calculating destroy values."] = ""
-- L["Sell to Vendor"] = ""
-- L["Send Group"] = ""
-- L["Send to Other Account"] = ""
-- L["Sent Group - Result is in Chat"] = ""
-- L["Set All Relationships to Target"] = ""
-- L["Sets all relationship dropdowns below to the operation selected."] = ""
-- L["Settings"] = ""
-- L["Shards"] = ""
-- L["Show on Modifier:"] = ""
-- L["Simple"] = ""
-- L["%s in guild vault"] = ""
-- L["%s is a valid custom price but did not give a value for %s."] = ""
-- L["%s is a valid custom price but %s is an invalid item."] = ""
-- L["%s is not a valid custom price and gave the following error: %s"] = ""
-- L["Skip"] = ""
-- L["Skipping %s operations as the module is not loaded."] = ""
-- L["Slash Commands:"] = ""
-- L["%sLeft-Click|r to select / deselect this group."] = ""
L["%sLeft-Click%s to open the main window"] = "%sClick Izquierdo%s"
-- L["Small Text Size (Requires Reload)"] = ""
-- L["Some debug commands for TSM."] = ""
-- L["%s operation(s):"] = ""
-- L["Sources"] = ""
-- L["%s removed."] = ""
-- L["%sRight-Click|r to collapse / expand this group."] = ""
-- L["%s (%s bags, %s bank, %s AH, %s mail)"] = ""
-- L["%s (%s player, %s alts, %s guild, %s AH)"] = ""
-- L["Stack Size"] = ""
-- L["Status: "] = ""
-- L["Store Operations Globally"] = ""
-- L["%s total"] = ""
-- L["Subgroup Items:"] = ""
-- L["Subgroups can contain a subset of the items in their parent group and can be useful in further refining how modules handle the items in this group."] = ""
-- L["Successfully imported %d items to %s."] = ""
-- L["Successfully imported operation settings."] = ""
-- L["Successfully sent %d items to %s."] = ""
-- L["Switch to New Custom Price Source After Creation"] = ""
-- L["Switch to New Group After Creation"] = ""
-- L["Sync removed. Make sure you remove the sync from the other account as well."] = ""
-- L["Sync Setup Error: The specified player on the other account is not currently online."] = ""
-- L["Sync Setup Error: This character is already part of a known account."] = ""
-- L["Sync Setup Error: You entered the name of the current character and not the character on the other account."] = ""
-- L["Target Character:"] = ""
-- L["Target Operation"] = ""
-- L["Test Selected Sound"] = ""
-- L["Text (%s)"] = ""
-- L["The auction buys feature will change the 'You have won an auction of XXX' text into something more useful which contains the link, stack size, and price of the item you bought."] = ""
-- L["The auction sales feature will change the 'A buyer has been found for your auction of XXX' text into something more useful which contains a link to the item and, if possible, the amount the auction sold for."] = ""
-- L["The default design has been changed in TSM3. Would you like to reset your appearance settings and use this new default?"] = ""
-- L["The default tab shown in the 'BankUI' frame."] = ""
-- L["The 'disenchant' price source has been replaced by the more general 'destroy' price source. Please update your custom prices."] = ""
-- L["The Functional Gold Maker (by Xsinthis - The Golden Crusade)"] = ""
-- L["Theme Name"] = ""
-- L["Theme name is empty."] = ""
-- L["The name can ONLY contain letters. No spaces, numbers, or special characters."] = ""
-- L["The operations for the selected module(s) will be displaed in item tooltips."] = ""
-- L["There are no visible banks."] = ""
-- L["The total value of all your items is %s!"] = ""
-- L["This allows you to export your appearance settings to share with others."] = ""
-- L["This allows you to import appearance settings which other people have exported."] = ""
-- L["This dropdown determines the default tab when you visit a group."] = ""
-- L["This dropdown will list all characters on your other accounts which have active syncing connections and are currently online."] = ""
-- L["This EditBox is Disabled"] = ""
-- L["This group already has operations. Would you like to add another one or replace the last one?"] = ""
-- L["This group already has the max number of operation. Would you like to replace the last one?"] = ""
-- L["This group is too large to send automatically. Please use manual import / export instead."] = ""
-- L["This is not a valid profile name. Profile names must be at least one character long and may not contain '@' characters."] = ""
-- L["This looks like an exported operation and not a custom price."] = ""
-- L["This operation will be ignored when you're on any character which is checked in this dropdown."] = ""
-- L["This option sets which tab TSM and its modules will use for printing chat messages."] = ""
-- L["This relationship cannot be applied because doing so would create a circular relationship."] = ""
-- L["This slider controls how long the BankUI code will sleep betwen individual moves, default of 0 should be fine but increase it if you run into problems."] = ""
-- L["Title"] = ""
-- L["Toggles the bankui"] = ""
-- L["Tooltip Options"] = ""
-- L["Tooltip Price Format:"] = ""
-- L["Total"] = ""
-- L["Total Value"] = ""
-- L["TradeSkillMaster Error Window"] = ""
-- L["TradeSkillMaster Info:"] = ""
-- L["TradeSkillMaster Team"] = ""
-- L["TradeSkillMaster tooltip options for |cff99ffff%s|r have changed and therefore been reset to their default values."] = ""
-- L["Transform Value:"] = ""
-- L["Transform Value x%s:"] = ""
-- L["TSM_Auctioning 'Cancel' Button"] = ""
-- L["TSM_Auctioning 'Post' Button"] = ""
-- L["TSM Classic (by Jim Younkin - Power Word: Gold)"] = ""
-- L["TSM_Crafting 'Craft Next' Button"] = ""
-- L["TSMDeck (by Jim Younkin - Power Word: Gold)"] = ""
-- L["TSM_Destroying 'Destroy Next' Button"] = ""
-- L["TSM Features"] = ""
-- L["/tsm help|r - Shows this help listing"] = ""
-- L["/tsm|r - opens the main TSM window."] = ""
-- L["TSM_Shopping 'Buyout' Button"] = ""
-- L["TSM_Shopping 'Buyout' (Confirmation) Button"] = ""
-- L["TSM_Shopping 'Cancel' (Confirmation) Button"] = ""
-- L["TSM_Vendoring 'Sell All' Button"] = ""
-- L["TSM Version Info:"] = ""
-- L["TUJ 14-Day Price"] = ""
-- L["TUJ 3-Day Price"] = ""
-- L["TUJ Global Mean"] = ""
-- L["TUJ Global Median"] = ""
-- L["Twitter Integration"] = ""
-- L["Type in the name of a new operation you wish to create with the same settings as this operation."] = ""
-- L["Type '/tsm sources' to print out all available price sources."] = ""
-- L["Unbalanced parentheses."] = ""
-- L["Ungrouped Items:"] = ""
-- L["Unofficial Module"] = ""
-- L["Unwrap Gift"] = ""
-- L["Up"] = ""
-- L["Usage: /tsm price <ItemLink> <Price String>"] = ""
-- L["Use the group box below to move this group and all subgroups of this group. Moving a group will cause all items in the group (and its subgroups) to be removed from its current parent group and added to the new parent group."] = ""
-- L["Use the options below to change and tweak the appearance of TSM."] = ""
-- L["Use the tabs above to select the module for which you'd like to configure operations."] = ""
-- L["Using our website you can get help with TSM, suggest features, and give feedback."] = ""
-- L["Value Price Source"] = ""
-- L["Various modules can sync their data between multiple accounts automatically whenever you're logged into both accounts."] = ""
-- L["Vendor Buy Price:"] = ""
-- L["Vendor Buy Price x%s:"] = ""
-- L["Vendor Sell Price:"] = ""
-- L["Vendor Sell Price x%s:"] = ""
-- L["View Operation Options"] = ""
-- L["WARNING: The macro was too long, so was truncated to fit by WoW."] = ""
-- L["When adding items to groups, you can filter by items with a value below a certain value. This custom price determines the value of items for the purpose of filter. For example, if you set this to 'dbmarket' and entered '/2000g' into the filter box, only items with a market value of at least 2000g will be shown. You can also specify a price range, such as '/200g/500g'."] = ""
--[==[ L[ [=[When checked, random enchants will be ignored for ungrouped items.

NB: This will not affect parent group items that were already added with random enchants

If you have this checked when adding an ungrouped randomly enchanted item, it will act as all possible random enchants of that item.]=] ] = "" ]==]
-- L["When clicked, makes this group a top-level group with no parent."] = ""
-- L["Will cause the macro to be triggered when the scroll wheel goes down (with the selected modifiers pressed)."] = ""
-- L["Will cause the macro to be triggered when the scroll wheel goes up (with the selected modifiers pressed)."] = ""
-- L["Will include the TSM_Auctioning 'Cancel' button in the macro."] = ""
-- L["Will include the TSM_Auctioning 'Post' button in the macro."] = ""
-- L["Will include the TSM_Crafting 'Craft Next' button in the macro."] = ""
-- L["Will include the TSM_Destroying 'Destroy Next' button in the macro."] = ""
-- L["Will include the TSM_Shopping 'Buyout' button in the macro."] = ""
-- L["Will include the TSM_Shopping buyout confirmation window 'Buyout' button in the macro."] = ""
-- L["Will include the TSM_Shopping cancel confirmation window 'Cancel' button in the macro."] = ""
-- L["Will include the TSM_Vendoring 'Sell All' button in the macro."] = ""
-- L["Would you like to add this new operation to %s?"] = ""
-- L["You appear to be attempting to import an operation from a different module."] = ""
-- L["You can change the active database profile, so you can have different settings for every character."] = ""
-- L["You can either create a new profile by entering a name in the editbox, or choose one of the already exisiting profiles."] = ""
-- L["You can hold shift while clicking this button to leave the items in the parent group (if one exists) rather than removing from all groups."] = ""
-- L["You cannot change tabs within the main TSM window while in combat."] = ""
-- L["You cannot use %s as part of this custom price."] = ""
-- L["You cannot use %s within convert() as part of this custom price."] = ""
-- L["You currently don't have any groups setup. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to setup TSM groups."] = ""
-- L["You have closed the bankui. Use '/tsm bankui' to view again."] = ""
-- L["You must reload your UI for these settings to take effect. Reload now?"] = ""
-- L["Your auction of %s has sold for %s!"] = ""
-- L["You won an auction for %sx%d for %s"] = ""
