
CliqueDB = nil
CliqueDB3 = {
	["char"] = {
		["Leisho - Thrall"] = {
			["sec_profileKey"] = "Brewmaster pvp",
			["fastooc"] = false,
			["alerthidden"] = true,
			["downclick"] = false,
			["pri_profileKey"] = "Leisho - Thrall",
			["specswap"] = true,
		},
		["Raijah - Thrall"] = {
			["alerthidden"] = true,
			["sec_profileKey"] = "Holy Pally",
			["pri_profileKey"] = "Raijah - Thrall",
			["fastooc"] = false,
			["downclick"] = false,
			["specswap"] = true,
		},
		["Nalyria - Thrall"] = {
			["alerthidden"] = true,
		},
		["Ahka - Thrall"] = {
			["alerthidden"] = true,
		},
		["Kitha - Thrall"] = {
			["alerthidden"] = true,
		},
		["Alinastra - Thrall"] = {
			["alerthidden"] = true,
		},
	},
	["profileKeys"] = {
		["Alyserys - Thrall"] = "Alyserys - Thrall",
		["Leisho - Thrall"] = "Leisho - Thrall",
		["Raijah - Thrall"] = "Raijah - Thrall",
		["Leisho - Durotan"] = "Leisho - Durotan",
		["Mairene - Thrall"] = "Mairene - Thrall",
		["Thilaira - Thrall"] = "Thilaira - Thrall",
		["Ahkka - Durotan"] = "Ahkka - Durotan",
		["Liulu - Thrall"] = "Liulu - Thrall",
		["Thilaria - Thrall"] = "Thilaria - Thrall",
		["Ahka - Thrall"] = "Ahka - Thrall",
		["Therru - Thrall"] = "Therru - Thrall",
		["Nalyria - Thrall"] = "Nalyria - Thrall",
		["Kargen - Thrall"] = "Kargen - Thrall",
		["Kitha - Thrall"] = "Kitha - Thrall",
		["Alinastra - Thrall"] = "Alinastra - Thrall",
	},
	["profiles"] = {
		["Alyserys - Thrall"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Brewmaster pvp"] = {
			["bindings"] = {
				{
					["spell"] = "Surging Mist",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_surgingmist",
					["type"] = "spell",
				}, -- [1]
				{
					["macrotext"] = "/use [combat] Healthstone",
					["type"] = "macro",
					["key"] = "SHIFT-MOUSEWHEELDOWN",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Summon Black Ox Statue",
					["key"] = "ALT-CTRL-NUMPAD0",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Detox",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_rogue_imrovedrecuperate",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Spear Hand Strike",
					["key"] = "ALT-CTRL-NUMPAD7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_spearhand",
					["type"] = "spell",
				}, -- [5]
				{
					["macrotext"] = "/cast [talent:6/1] Rushing Jade Wind; [talent:6/2] Spinning Crane Kick; [talent:6/3] Spinning Crane Kick",
					["type"] = "macro",
					["key"] = "NUMPAD2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [6]
				{
					["spell"] = "Elusive Brew",
					["key"] = "ALT-CTRL-1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_elusiveale",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Serenity",
					["key"] = "ALT-CTRL-SHIFT-F9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_serenity",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Guard",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_guard",
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Provoke",
					["key"] = "ALT-CTRL-NUMPAD3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_provoke",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Chi Brew",
					["key"] = "ALT-CTRL-NUMPAD6",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chibrew",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Nimble Brew",
					["key"] = "NUMPAD4",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_nimblebrew",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Tiger's Lust",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_tigerslust",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Purifying Brew",
					["key"] = "ALT-CTRL-NUMPAD8",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\inv_misc_beer_06",
					["type"] = "spell",
				}, -- [14]
				{
					["macrotext"] = "/cast Legacy of the White Tiger\n/use Empowered Augment Rune\n",
					["type"] = "macro",
					["key"] = "ALT-CTRL-SHIFT-F11",
					["sets"] = {
						["global"] = true,
					},
				}, -- [15]
				{
					["spell"] = "Transcendence",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_transcendence",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Paralysis",
					["key"] = "ALT-CTRL-HOME",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_paralysis",
					["type"] = "spell",
				}, -- [17]
				{
					["macrotext"] = "/use Disabling Technique",
					["type"] = "macro",
					["key"] = "NUMPAD6",
					["sets"] = {
						["global"] = true,
					},
				}, -- [18]
				{
					["spell"] = "Roll",
					["key"] = "ALT-CTRL-3",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_roll",
					["type"] = "spell",
				}, -- [19]
				{
					["spell"] = "Summon Black Ox Statue",
					["key"] = "ALT-CTRL-NUMPAD0",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
					["type"] = "spell",
				}, -- [20]
				{
					["spell"] = "Dizzying Haze",
					["key"] = "ALT-CTRL-NUMPAD2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_drunkenhaze",
					["type"] = "spell",
				}, -- [21]
				{
					["macrotext"] = "/cast [talent:5/1] Purifying Brew; [talent:5/2] Dampen Harm; [talent:5/3] Diffuse Magic",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-F9",
					["sets"] = {
						["global"] = true,
					},
				}, -- [22]
				{
					["spell"] = "Fortifying Brew",
					["key"] = "ALT-CTRL-NUMPAD9",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
					["type"] = "spell",
				}, -- [23]
				{
					["spell"] = "Quaking Palm",
					["key"] = "ALT-CTRL-INSERT",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\pandarenracial_quiveringpain",
					["type"] = "spell",
				}, -- [24]
				{
					["spell"] = "Touch of Death",
					["key"] = "ALT-CTRL-NUMPAD5",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_touchofdeath",
					["type"] = "spell",
				}, -- [25]
				{
					["spell"] = "Breath of Fire",
					["key"] = "NUMPAD8",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_breathoffire",
					["type"] = "spell",
				}, -- [26]
				{
					["spell"] = "Transcendence: Transfer",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shaman_SpectralTransformation",
					["type"] = "spell",
				}, -- [27]
				{
					["macrotext"] = "/use Chi Shaping",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-F10",
					["sets"] = {
						["global"] = true,
					},
				}, -- [28]
			},
		},
		["Thilaria - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Holy Pally"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "CTRL-BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["spell"] = "Holy Radiance",
					["key"] = "ALT-CTRL-1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\spell_paladin_divinecircle",
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Hand of Sacrifice",
					["key"] = "ALT-CTRL-INSERT",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SealOfSacrifice",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Eternal Flame",
					["key"] = "ALT-CTRL-END",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\INV_Torch_Thrown",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Flash of Light",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Holy Shock",
					["key"] = "BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SearingLight",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Beacon of Light",
					["key"] = "ALT-CTRL-DOWN",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Paladin_BeaconofLight",
					["type"] = "spell",
				}, -- [7]
				{
					["type"] = "menu",
					["key"] = "CTRL-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [8]
				{
					["macrotext"] = "/cast Spawn of Galakras",
					["type"] = "macro",
					["key"] = "ALT-CTRL-SHIFT-2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [9]
				{
					["spell"] = "Holy Light",
					["key"] = "ALT-SHIFT-F9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SurgeOfLight",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Lay on Hands",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Hand of Freedom",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SealOfValor",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Blinding Light",
					["key"] = "CTRL-SHIFT-=",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_paladin_blindinglight",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Light of Dawn",
					["key"] = "ALT-CTRL-PAGEDOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\spell_paladin_lightofdawn",
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Cleanse",
					["key"] = "CTRL-SHIFT-BACKSPACE",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_Purify",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Rebuke",
					["key"] = "ALT-CTRL-HOME",
					["sets"] = {
						["default"] = true,
						["global"] = true,
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_rebuke",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Divine Shield",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_divineshield",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Divine Protection",
					["key"] = "ALT-CTRL-RIGHT",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_divineprotection",
					["type"] = "spell",
				}, -- [18]
				{
					["spell"] = "Avenging Wrath",
					["key"] = "ALT-CTRL-PAGEUP",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_AvengineWrath",
					["type"] = "spell",
				}, -- [19]
			},
		},
		["Ahkka - Durotan"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Thilaira - Thrall"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Ahka - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "SHIFT-BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["spell"] = "Healing Wave",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_HealingWaveLesser",
					["type"] = "spell",
				}, -- [2]
				{
					["type"] = "menu",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [3]
				{
					["spell"] = "Riptide",
					["key"] = "BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_nature_riptide",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Healing Surge",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_HealingWay",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Earth Shield",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_SkinofEarth",
					["type"] = "spell",
				}, -- [6]
			},
		},
		["Nalyria - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Aspect of the Cheetah",
					["key"] = "ALT-CTRL-3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Mount_JungleTiger",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Kill Shot",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Hunter_Assassinate2",
					["type"] = "spell",
				}, -- [4]
			},
		},
		["Kitha - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Pummel",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["default"] = true,
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\INV_Gauntlets_04",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Heroic Leap",
					["key"] = "ALT-CTRL-3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_HeroicLeap",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Commanding Shout",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Warrior_RallyingCry",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Dragon Roar",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_warrior_dragonroar",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Intimidating Shout",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_GolemThunderClap",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Taunt",
					["key"] = "ALT-CTRL-NUMPAD3",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_Reincarnation",
					["type"] = "spell",
				}, -- [8]
				{
					["macrotext"] = "/cast Sandstone Drake",
					["type"] = "macro",
					["key"] = "ALT-CTRL-2",
					["sets"] = {
						["global"] = true,
					},
				}, -- [9]
				{
					["spell"] = "Bladestorm",
					["key"] = "NUMPAD2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Warrior_Bladestorm",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Die by the Sword",
					["key"] = "ALT-CTRL-NUMPAD9",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Warrior_Challange",
					["type"] = "spell",
				}, -- [11]
				{
					["macrotext"] = "/cast Ironside Warwolf",
					["type"] = "macro",
					["key"] = "ALT-CTRL-SHIFT-2",
					["sets"] = {
						["global"] = true,
					},
				}, -- [12]
				{
					["spell"] = "Charge",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Warrior_Charge",
					["type"] = "spell",
				}, -- [13]
			},
		},
		["Therru - Thrall"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Kargen - Thrall"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Leisho - Durotan"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Mairene - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Brewmaster"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "SHIFT-BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["spell"] = "Touch of Death",
					["key"] = "ALT-CTRL-NUMPAD5",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_touchofdeath",
					["type"] = "spell",
				}, -- [2]
				{
					["type"] = "menu",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [3]
				{
					["spell"] = "Purifying Brew",
					["key"] = "ALT-CTRL-UP",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\inv_misc_beer_06",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Diffuse Magic",
					["key"] = "ALT-CTRL-DOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_diffusemagic",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Serenity",
					["key"] = "ALT-CTRL-SHIFT-PAGEUP",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_serenity",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Chi Brew",
					["key"] = "ALT-CTRL-NUMPAD6",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chibrew",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Provoke",
					["key"] = "ALT-CTRL-NUMPAD3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_provoke",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Dampen Harm",
					["key"] = "ALT-CTRL-SHIFT-DOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_dampenharm",
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Purifying Brew",
					["key"] = "ALT-CTRL-NUMPAD8",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\inv_misc_beer_06",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Fortifying Brew",
					["key"] = "ALT-CTRL-NUMPAD9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Summon Black Ox Statue",
					["key"] = "ALT-CTRL-INSERT",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Transcendence",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_transcendence",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Diffuse Magic",
					["key"] = "ALT-SHIFT-F10",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_diffusemagic",
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Nimble Brew",
					["key"] = "ALT-SHIFT-F9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_nimblebrew",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Chi Brew",
					["key"] = "ALT-CTRL-RIGHT",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chibrew",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Dizzying Haze",
					["key"] = "ALT-CTRL-DOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_drunkenhaze",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Fortifying Brew",
					["key"] = "ALT-CTRL-PAGEUP",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
					["type"] = "spell",
				}, -- [18]
				{
					["spell"] = "Guard",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_guard",
					["type"] = "spell",
				}, -- [19]
				{
					["spell"] = "Detox",
					["key"] = "ALT-CTRL-END",
					["sets"] = {
						["default"] = true,
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_rogue_imrovedrecuperate",
					["type"] = "spell",
				}, -- [20]
				{
					["spell"] = "Provoke",
					["key"] = "ALT-CTRL-PAGEDOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_provoke",
					["type"] = "spell",
				}, -- [21]
				{
					["spell"] = "Spear Hand Strike",
					["key"] = "ALT-CTRL-HOME",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_spearhand",
					["type"] = "spell",
				}, -- [22]
				{
					["spell"] = "Summon Black Ox Statue",
					["key"] = "ALT-CTRL-NUMPAD0",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
					["type"] = "spell",
				}, -- [23]
				{
					["spell"] = "Spear Hand Strike",
					["key"] = "ALT-CTRL-NUMPAD7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_spearhand",
					["type"] = "spell",
				}, -- [24]
				{
					["spell"] = "Rushing Jade Wind",
					["key"] = "CTRL-SHIFT-BACKSPACE",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_rushingjadewind",
					["type"] = "spell",
				}, -- [25]
				{
					["spell"] = "Charging Ox Wave",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chargingoxwave",
					["type"] = "spell",
				}, -- [26]
				{
					["spell"] = "Zen Sphere",
					["key"] = "BUTTON1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_forcesphere",
					["type"] = "spell",
				}, -- [27]
				{
					["spell"] = "Elusive Brew",
					["key"] = "ALT-CTRL-1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_elusiveale",
					["type"] = "spell",
				}, -- [28]
				{
					["spell"] = "Zen Meditation",
					["key"] = "ALT-CTRL-SHIFT-4",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_zenmeditation",
					["type"] = "spell",
				}, -- [29]
				{
					["spell"] = "Transcendence: Transfer",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shaman_SpectralTransformation",
					["type"] = "spell",
				}, -- [30]
				{
					["spell"] = "Leg Sweep",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_legsweep",
					["type"] = "spell",
				}, -- [31]
				{
					["macrotext"] = "/use 14",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-=",
					["sets"] = {
						["global"] = true,
					},
				}, -- [32]
				{
					["spell"] = "Ring of Peace",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_ringofpeace",
					["type"] = "spell",
				}, -- [33]
				{
					["macrotext"] = "/cast Rushing Jade Wind\n/cast Invoke Xuen, the White Tiger\n/use 13",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-BACKSPACE",
					["sets"] = {
						["global"] = true,
					},
				}, -- [34]
				{
					["macrotext"] = "/cast [@player] Tiger's Lust",
					["type"] = "macro",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["global"] = true,
					},
				}, -- [35]
				{
					["spell"] = "Chi Wave",
					["key"] = "SHIFT-MOUSEWHEELDOWN",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chiwave",
					["type"] = "spell",
				}, -- [36]
				{
					["spell"] = "Invoke Xuen, the White Tiger",
					["key"] = "ALT-CTRL-SHIFT-F10",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_summontigerstatue",
					["type"] = "spell",
				}, -- [37]
				{
					["spell"] = "Diffuse Magic",
					["key"] = "ALT-CTRL-SHIFT-1",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_diffusemagic",
					["type"] = "spell",
				}, -- [38]
				{
					["spell"] = "Surging Mist",
					["key"] = "BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_surgingmist",
					["type"] = "spell",
				}, -- [39]
				{
					["spell"] = "Dizzying Haze",
					["key"] = "ALT-CTRL-NUMPAD2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_drunkenhaze",
					["type"] = "spell",
				}, -- [40]
				{
					["spell"] = "Touch of Death",
					["key"] = "ALT-CTRL-NUMPAD5",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_touchofdeath",
					["type"] = "spell",
				}, -- [41]
			},
		},
		["Liulu - Thrall"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Leisho - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["spell"] = "Tiger Strikes",
					["key"] = "ALT-CTRL-NUMPAD9",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_GhoulFrenzy",
					["type"] = "spell",
				}, -- [2]
				{
					["macrotext"] = "/targetexact Large Illusionary Hive-Singer\n/targetexact Small Illusionary Hive-Singer\n/cast Spear Hand Strike",
					["type"] = "macro",
					["key"] = "ALT-CTRL-NUMPAD7",
					["sets"] = {
						["default"] = true,
					},
				}, -- [3]
				{
					["spell"] = "Surging Mist",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_surgingmist",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Renewing Mist",
					["key"] = "BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_renewingmists",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Soothing Mist",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_soothingmists",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Fortifying Brew",
					["key"] = "NUMPAD4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Enveloping Mist",
					["key"] = "ALT-CTRL-F9",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_envelopingmist",
					["type"] = "spell",
				}, -- [8]
				{
					["type"] = "menu",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [9]
				{
					["spell"] = "Detox",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["default"] = true,
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_rogue_imrovedrecuperate",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Mana Tea",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_cherrymanatea",
					["type"] = "spell",
				}, -- [11]
				{
					["macrotext"] = "/skada toggle",
					["type"] = "macro",
					["key"] = "BACKSLASH",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [12]
				{
					["spell"] = "Thunder Focus Tea",
					["key"] = "ALT-CTRL-NUMPAD8",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_thunderfocustea",
					["type"] = "spell",
				}, -- [13]
				{
					["macrotext"] = "/use Winged Guardian",
					["type"] = "macro",
					["key"] = "ALT-CTRL-2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [14]
				{
					["spell"] = "Chi Brew",
					["key"] = "ALT-CTRL-NUMPAD6",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chibrew",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Life Cocoon",
					["key"] = "CTRL-SHIFT-F10",
					["sets"] = {
						["default"] = true,
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chicocoon",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Uplift",
					["key"] = "ALT-CTRL-6",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_uplift",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Diffuse Magic",
					["key"] = "ALT-CTRL-SHIFT-F9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_diffusemagic",
					["type"] = "spell",
				}, -- [18]
				{
					["spell"] = "Expel Harm",
					["key"] = "ALT-CTRL-PAGEDOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_expelharm",
					["type"] = "spell",
				}, -- [19]
				{
					["spell"] = "Detonate Chi",
					["key"] = "ALT-CTRL-END",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_healthsphere",
					["type"] = "spell",
				}, -- [20]
				{
					["macrotext"] = "/cast [@mouseover,  dead] Resuscitate; [@mouseover, nodead] Renewing Mist",
					["type"] = "macro",
					["key"] = "BUTTON1",
					["sets"] = {
						["default"] = true,
						["friend"] = true,
					},
				}, -- [21]
				{
					["spell"] = "Summon Jade Serpent Statue",
					["key"] = "ALT-CTRL-5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_summonserpentstatue",
					["type"] = "spell",
				}, -- [22]
				{
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["type"] = "spell",
					["icon"] = "Interface\\Icons\\ability_monk_touchofdeath",
					["spell"] = "Touch of Death",
				}, -- [23]
				{
					["spell"] = "Chi Explosion",
					["key"] = "ALT-CTRL-NUMPAD3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_chiexplosion",
					["type"] = "spell",
				}, -- [24]
				{
					["spell"] = "Fortifying Brew",
					["key"] = "ALT-CTRL-NUMPAD9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
					["type"] = "spell",
				}, -- [25]
				{
					["macrotext"] = "/use Draenic Intellect Potion",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-BACKSPACE",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [26]
				{
					["spell"] = "Summon Jade Serpent Statue",
					["key"] = "ALT-CTRL-NUMPAD0",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_summonserpentstatue",
					["type"] = "spell",
				}, -- [27]
				{
					["macrotext"] = "/cast Legacy of the Emperor\n/use Empowered Augment Rune",
					["type"] = "macro",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [28]
				{
					["macrotext"] = "/swapactionbar 1 2",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-F10",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [29]
				{
					["spell"] = "Nimble Brew",
					["key"] = "NUMPAD4",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_monk_nimblebrew",
					["type"] = "spell",
				}, -- [30]
				{
					["macrotext"] = "/use Disabling Technique",
					["type"] = "macro",
					["key"] = "NUMPAD6",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [31]
				{
					["spell"] = "Transcendence: Transfer",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shaman_SpectralTransformation",
					["type"] = "spell",
				}, -- [32]
				{
					["spell"] = "Nimble Brew",
					["key"] = "CTRL-SHIFT-=",
					["sets"] = {
					},
					["icon"] = "Interface\\Icons\\spell_monk_nimblebrew",
					["type"] = "spell",
				}, -- [33]
				{
					["spell"] = "Paralysis",
					["key"] = "ALT-CTRL-HOME",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_paralysis",
					["type"] = "spell",
				}, -- [34]
				{
					["macrotext"] = "/use Draenic Intellect Potion\n/cast Revival",
					["type"] = "macro",
					["key"] = "ALT-CTRL-NUMPAD5",
					["sets"] = {
						["global"] = true,
					},
				}, -- [35]
				{
					["spell"] = "Roll",
					["key"] = "ALT-CTRL-3",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_roll",
					["type"] = "spell",
				}, -- [36]
				{
					["macrotext"] = "/cast [stance:2] Stance of the Wise Serpent(Mistweaver Stance); [stance:1] Stance of the Spirited Crane(Mistweaver Stance)",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-F10",
					["sets"] = {
						["global"] = true,
					},
				}, -- [37]
				{
					["spell"] = "Rushing Jade Wind",
					["key"] = "NUMPAD2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_rushingjadewind",
					["type"] = "spell",
				}, -- [38]
				{
					["spell"] = "Spear Hand Strike",
					["key"] = "ALT-CTRL-NUMPAD7",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_monk_spearhand",
					["type"] = "spell",
				}, -- [39]
				{
					["spell"] = "Transcendence",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\monk_ability_transcendence",
					["type"] = "spell",
				}, -- [40]
				{
					["macrotext"] = "/cast [@player] Tiger's Lust",
					["type"] = "macro",
					["key"] = "ALT-CTRL-NUMPAD1",
					["sets"] = {
						["global"] = true,
					},
				}, -- [41]
			},
		},
		["Raijah - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [1]
				{
					["spell"] = "Hand of Sacrifice",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SealOfSacrifice",
					["type"] = "spell",
				}, -- [2]
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [3]
				{
					["spell"] = "Avenger's Shield",
					["key"] = "ALT-CTRL-DOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_AvengersShield",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Reckoning",
					["key"] = "ALT-CTRL-NUMPAD3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_UnyieldingFaith",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Sacred Shield",
					["key"] = "ALT-CTRL-RIGHT",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Paladin_BlessedMending",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Divine Protection",
					["key"] = "ALT-CTRL-UP",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_divineprotection",
					["type"] = "spell",
				}, -- [7]
				{
					["macrotext"] = "/use Healing Tonic",
					["type"] = "macro",
					["key"] = "ALT-SHIFT-F10",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [8]
				{
					["macrotext"] = "/use Shieldtronic Shield",
					["type"] = "macro",
					["key"] = "ALT-SHIFT-F9",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [9]
				{
					["macrotext"] = "/cast Sandstone Drake",
					["type"] = "macro",
					["key"] = "ALT-CTRL-SHIFT-2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [10]
				{
					["spell"] = "Ardent Defender",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_ArdentDefender",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Guardian of Ancient Kings",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_Heroism",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Consecration",
					["key"] = "ALT-CTRL-1",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_InnerFire",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Rebuke",
					["key"] = "ALT-CTRL-HOME",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_rebuke",
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Lay on Hands",
					["key"] = "ALT-SHIFT-F7",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Reckoning",
					["key"] = "ALT-CTRL-PAGEDOWN",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_UnyieldingFaith",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Speed of Light",
					["key"] = "ALT-CTRL-3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_paladin_speedoflight",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Guardian of Ancient Kings",
					["key"] = "RIGHT",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_Heroism",
					["type"] = "spell",
				}, -- [18]
				{
					["spell"] = "Holy Wrath",
					["key"] = "CTRL-SHIFT-=",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_WeaponMastery",
					["type"] = "spell",
				}, -- [19]
				{
					["spell"] = "Word of Glory",
					["key"] = "ALT-CTRL-END",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\inv_helmet_96",
					["type"] = "spell",
				}, -- [20]
				{
					["spell"] = "Fist of Justice",
					["key"] = "ALT-CTRL-SHIFT-HOME",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FistOfJustice",
					["type"] = "spell",
				}, -- [21]
				{
					["spell"] = "Consecration",
					["key"] = "CTRL-SHIFT-BACKSPACE",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_InnerFire",
					["type"] = "spell",
				}, -- [22]
				{
					["spell"] = "Execution Sentence",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_paladin_executionsentence",
					["type"] = "spell",
				}, -- [23]
				{
					["spell"] = "Word of Glory",
					["key"] = "ALT-CTRL-INSERT",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\inv_helmet_96",
					["type"] = "spell",
				}, -- [24]
				{
					["spell"] = "Hand of Freedom",
					["key"] = "ALT-CTRL-SHIFT-DASH",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SealOfValor",
					["type"] = "spell",
				}, -- [25]
			},
		},
		["Alinastra - Thrall"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Flash Heal",
					["key"] = "BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [3]
			},
		},
	},
}
