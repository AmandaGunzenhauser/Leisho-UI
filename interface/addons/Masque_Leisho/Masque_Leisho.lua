--Leisho Button Skins, a World of Warcraft® user interface addon plugin.
--Copyright© 2015-2016 Amanda L. Ferry, aka Leisho

--[[ Leisho Button Skins for Masque]]

if not LibStub then return end

local MSQ = LibStub("Masque", true)

if not MSQ then return end

MSQ:AddSkin("Leisho: Serpent",{

	-- Skin data start.

	Author = "Leisho",
	Version = "40300.2",
	Masque_Version = 40200,
	Shape = "Serpent",

	Normal = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_Leisho\images\serpent\SerpentButton]],
		Static = true,
		Color = {0.3, 0.3, 0.3, 1},
	},
	Pushed = {
		Width = 39,
		Height = 39,
		Texture = [[Interface\AddOns\Masque_Leisho\images\serpent\SerpentButton]],
		Color = {0.65, 0.65, 0.7, 1},
	},
	Checked = {
		Width = 33,
		Height = 33,
		Texture = [[Interface\AddOns\Masque_Leisho\images\round\RoundButtonChecked]],
		BlendMode = "ADD",
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_Leisho\images\round\RoundButtonHiLight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_Leisho\images\round\RoundButtonBorder]],
	},
	Gloss = {
		Width = 30,
		Height = 30,
		Texture = [[Interface\AddOns\Masque_Leisho\images\round\RoundButtonSheen2]],
	},
	Disabled = {
		Hide = true,
	},
	Icon = {
		Width = 23,
		Height = 23,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Cooldown = {
		Width = 23,
		Height = 23,
	},
	Backdrop = {
		Width = 23,
		Height = 23,
		Texture = [[Interface\AddOns\Masque_Leisho\images\leisho_button_bg]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetY = 4,
	},
	Count = {
		Width = 32,
		Height = 10,
		OffsetX = -1,
		OffsetY = 5,
	},
	HotKey = {
		Width = 32,
		Height = 10,
		OffsetX = 3,
		OffsetY = -4,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 32,
		Height = 32,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
	AutoCastable = {
		Width = 54,
		Height = 54,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Flash = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	-- Skin data end.

},true)

MSQ:AddSkin("Leisho: Hexagon",{

	-- Skin data start.
	Author = "Leisho",
	Version = "40300.2",
	Masque_Version = 40200,
	Shape = "Square",

	Normal = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_Leisho\images\hex\hex]],
		Static = true,
		Color = {0.3, 0.3, 0.3, 1},
	},
	Pushed = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\AddOns\Masque_Leisho\images\hex\hex]],
		Color = {0.3, 0.3, 0.3, 1},
	},
	Checked = {
		Width = 34,
		Height = 34,
		Texture = [[Interface\AddOns\Masque_Leisho\images\hex\hexChecked]],
		BlendMode = "ADD",
	},
	Highlight = {
		Width = 36,
		Height = 36,
		Texture = [[Interface\AddOns\Masque_Leisho\images\hex\hexHighlight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 35,
		Height = 35,
		Texture = [[Interface\AddOns\Masque_Leisho\images\hex\hexBorder]],
		BlendMode = "ADD",
	},
	Gloss = {
		Width = 33,
		Height = 33,
		Texture = [[Interface\AddOns\Masque_Leisho\images\round\RoundButtonSheen2]],
	},
	Disabled = {
		Hide = true,
	},
	Icon = {
		Width = 21,
		Height = 21,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Cooldown = {
		Width = 21,
		Height = 21,
	},
	Backdrop = {
		Width = 21,
		Height = 21,
		Texture = [[Interface\AddOns\Masque_Leisho\images\Leisho_button_bg]],
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetY = 4,
	},
	Count = {
		Width = 32,
		Height = 10,
		OffsetX = -1,
		OffsetY = 5,
	},
	HotKey = {
		Width = 32,
		Height = 10,
		OffsetX = 3,
		OffsetY = -4,
	},
	Duration = {
		Width = 36,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 32,
		Height = 32,
		OffsetX = 0.5,
		OffsetY = -0.5
	},
	AutoCastable = {
		Width = 54,
		Height = 54,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Flash = {
		Width = 32,
		Height = 32,
		Texture = [[Interface\Buttons\UI-QuickslotRed]],
	},
	-- Skin data end.

},true)
