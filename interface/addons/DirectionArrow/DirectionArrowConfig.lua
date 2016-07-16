local L = LibStub("AceLocale-3.0"):GetLocale("DirectionArrow", false)

-- Config options
DirectionArrowConfig = { 
  type='group',
  name = L["DirectionArrow"],
  desc = L["Display an arrow that points to a raid/party member"],
  args = {
    General = {
      order = 1,
      type = "group",
      name = L["General Options"],
      desc = L["General Options"],
      args = {
        size = {
          order = 1,
          type = 'range',
          name = L["Arrow Size"],
          desc = L["The size of the arrow"],
          get = function ()
            return DirectionArrow.db.profile.size
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.size = arg
            DirectionArrow.f:SetScale (arg)
          end,
          min = 1,
          max = 10,
          step = 0.1,
        },
        distance_size = {
          order = 2,
          type = 'range',
          name = L["Distance Size"],
          desc = L["The size of the distance text"],
          disabled = function ()
            return not DirectionArrow.db.profile.show_distance
          end,
          get = function ()
            return DirectionArrow.db.profile.distance_size
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.distance_size = arg
            DirectionArrow.x:SetFont(DirectionArrow.x:GetFont(), arg)
          end,
          min = 1,
          max = 20,
          step = 0.1,
        },
        spacer11 = {
          order = 3,
          type = "description",
          name = "",
        },
        relative_location_x = {
          order = 4,
          type = 'range',
          name = L["Arrow X axis Location"],
          desc = L["The relative X axis location of the arrow against the unit frame."],
          get = function ()
            return DirectionArrow.db.profile.relative_location_x
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.relative_location_x = arg
			DirectionArrow:SetArrow ()
          end,
          min = -25,
          max = 25,
          step = 0.1,
        },
        relative_location_y = {
          order = 5,
          type = 'range',
          name = L["Arrow Y axis Location"],
          desc = L["The relative Y axis location of the arrow against the unit frame."],
          get = function ()
            return DirectionArrow.db.profile.relative_location_y
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.relative_location_y = arg
            DirectionArrow:SetArrow ()
          end,
          min = -25,
          max = 25,
          step = 0.1,
        },
        spacer12 = {
          order = 6,
          type = "description",
          name = "",
        },
        text_location_x = {
          order = 7,
          type = 'range',
          name = L["Distance Text X axis"],
          desc = L["The relative X axis location of the distance text against the arrow."],
          get = function ()
            return DirectionArrow.db.profile.text_location_x
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.text_location_x = arg
			DirectionArrow.x:ClearAllPoints ()
            DirectionArrow.x:SetPoint("CENTER", DirectionArrow.f, "CENTER", DirectionArrow.db.profile.text_location_x, DirectionArrow.db.profile.text_location_y)
          end,
          min = -25,
          max = 25,
          step = 0.1,
        },
        text_location_y = {
          order = 8,
          type = 'range',
          name = L["Distance Text Y axis"],
          desc = L["The relative Y axis location of the distance text against the arrow."],
          get = function ()
            return DirectionArrow.db.profile.text_location_y
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.text_location_y = arg
			DirectionArrow.x:ClearAllPoints ()
            DirectionArrow.x:SetPoint("CENTER", DirectionArrow.f, "CENTER", DirectionArrow.db.profile.text_location_x, DirectionArrow.db.profile.text_location_y)
          end,
          min = -25,
          max = 25,
          step = 0.1,
        },
        spacer12 = {
          order = 9,
          type = "description",
          name = "",
        },
        opacity = {
          order = 10,
          type = 'range',
          name = L["Opacity"],
          desc = L["The opacity of the arrow"],
          get = function ()
            return DirectionArrow.db.profile.opacity
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.opacity = arg
            DirectionArrow.f:SetAlpha (arg)
          end,
          min = 0,
          max = 1,
          step = 0.05,
        },
        update_frequency = {
          order = 11,
          type = 'range',
          name = L["Update Frequency"],
          desc = L["The number of cycles between each arrow update. 0 means every cycle (Possibly CPU intensive)"],
          get = function ()
            return DirectionArrow.db.profile.update_frequency
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.update_frequency = arg
          end,
          min = 0,
          max = 1,
          step = 0.05,
        },
        spacer13 = {
          order = 12,
          type = "description",
          name = "",
        },
        distance_color = {
          order = 13,
          type = 'color',
          name = L["Distance text color"],
          desc = L["The color of the distance text"],
          disabled = function ()
            return not DirectionArrow.db.profile.show_distance
          end,
          get = function ()
            return unpack (DirectionArrow.db.profile.distance_color)
          end,
          set = function (i, r, g, b, a)
            DirectionArrow.db.profile.distance_color = {r, g, b, a}
            DirectionArrow.x:SetTextColor (r, g, b, a)
          end,
          hasAlpha = true,
        },
        distance_ds_color = {
          order = 14,
          type = 'color',
          name = L["Drop shadow color"],
          desc = L["The color of the distance text drop shadow"],
          disabled = function ()
            return not DirectionArrow.db.profile.show_distance
          end,
          get = function ()
            return unpack (DirectionArrow.db.profile.distance_ds_color)
          end,
          set = function (i, r, g, b, a)
            DirectionArrow.db.profile.distance_ds_color = {r, g, b, a}
            DirectionArrow.x:SetShadowColor (r, g, b, a)
          end,
          hasAlpha = true,
        },
        spacer14 = {
          order = 15,
          type = "description",
          name = "",
        },
        relative_point = {
          order = 16,
          type = 'select',
          name = L["Anchor Point"],
          desc = L["Where to anchor the arrow relative to the unit frame."],
          get = function ()
            return DirectionArrow.db.profile.relative_point
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.relative_point = arg
            DirectionArrow:SetArrow ()
          end,
          values = {
            CENTER = L["Center"],
            TOPCENTER = L["Top Center"],
            BOTTOMCENTER = L["Bottom Center"],
            LEFT = L["Left"],
            RIGHT = L["Right"],
            TOPLEFT = L["Top Left"],
            TOPRIGHT = L["Top Right"],
            BOTTOMLEFT = L["Bottom Left"],
            BOTTOMRIGHT = L["Bottom Right"],
          },
        },
        show_distance = {
          order = 17,
          type = 'toggle',
          name = L["Show Distance"],
          desc = L["Show distance text to unit "],
          get = function ()
            return DirectionArrow.db.profile.show_distance
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.show_distance = arg
            if arg then
              DirectionArrow.x:Show()
            else
              DirectionArrow.x:Hide()
            end
          end
        },
        --[===[@debug@
        spacer199 = {
          order = 99,
          type = "description",
          name = "",
        },
        debug = {
          order = 100,
          type = 'toggle',
          name = "Debug",
          desc = "Debug",
          get = function ()
            return DirectionArrow.db.profile.debug
          end,
          set = function (i, arg)
            DirectionArrow.db.profile.debug = arg
          end
        },
        --@end-debug@]===]
      }
    }
  }
}

-- Config defaults
DirectionArrowDefaultConfigDB = {
  global = {
    ["*"] = {},
  },
  profile = {
    size = 1,
    opacity = 1,
	relative_point = "CENTER",
    relative_location_x = 0,
    relative_location_y = 0,
    text_location_x = 0,
    text_location_y = 0,
    update_frequency = 0,
    show_distance = true,
    distance_size = 4,
    distance_color = {1, 0, 0, 1},
    distance_ds_color = {0, 0, 0, 1},
    --[===[@debug@
    debug = true,
    --@end-debug@]===]
  }
}
