local MSQ = LibStub("Masque", true)
if not MSQ then return end


MSQ:AddSkin("Legion", {
	Author = "Tim",
	Version = "1.0",
	Shape = "Square",
	Masque_Version = 40200,
	Backdrop = {
		Width = 36,
		Height = 36,
		Color = {0.8, 0.8, 0.8, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_backdrop.blp]],
	},
	Icon = {
		Width = 32,
		Height = 32,
		TexCoords = {0.08, 0.92, 0.08, 0.92},
	},
	Flash = {
		Width = 40,
		Height = 40,
		Color = {1, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_highlight.blp]],
	},
	Cooldown = {
		Width = 36,
		Height = 36,
	},
	Pushed = {
		Width = 40,
		Height = 40,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_border.blp]],
	},
	Normal = {
		Width = 40,
		Height = 40,
		Color = {0.7, 0.7, 0.7, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_normal.blp]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_overlay.blp]],
	},
	Border = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Texture = [[Interface\AddOns\Masque_Legion\media\m_border.blp]],
	},
	Gloss = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\Masque_Legion\media\m_gloss.tga]],
	},
	AutoCastable = {
		Width = 64,
		Height = 64,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_Legion\media\m_highlight.blp]],
	},
	Name = {
		Width = 36,
		Height = 10,
		OffsetY = 4,
	},
	Count = {
		Width = 32,
		Height = 10,
		OffsetX = 2,
		OffsetY = 2,
	},
	HotKey = {
		Width = 32,
		Height = 10,
		OffsetX = 6,
	},
	Duration = {
		Width = 32,
		Height = 10,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 24,
		Height = 24,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)