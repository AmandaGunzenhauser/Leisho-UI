function MistWeaver_FocusFrameOnLoad()
    local _, unitClass = UnitClass("player");
    if (unitClass ~= "MONK") then
        return;
    end

    MwFocusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");

    MwFocusFrame:SetMovable(true);
    MwFocusFrame:SetUserPlaced(true);
    MwFocusFrame:SetClampedToScreen(true);

    MistWeaver_SetBackdrop(MwFocusFrame);

    MwFocusFrame:SetParent(MistWeaverFrame);
    MwFocusFrame:Show();

    MistWeaver_CheckFocusFrameVisibility();
end

function MistWeaver_InitFocusFrame()
    -- unit frame
    local unitFrame = _G["MwFocusUnitFrame"];
    if (not unitFrame) then
        unitFrame = MistWeaver_CreateFrame("Frame", "MwFocusUnitFrame", MwFocusFrame, MwUnitFrameTemplate);
        unitFrame:SetPoint("TOP", MwFocusFrame, "BOTTOM", 0, 5);

        MistWeaver_InitUnitFrame(unitFrame);

        unitFrame:SetSize(100, 50);
        MwFocusUnitFrameHealth:SetWidth(100);

        MistWeaver_FocusFrameFocusChanged();
        unitFrame:Show();
    end

    MistWeaver_FocusFrameFocusChanged();
end

function MistWeaver_CheckFocusFrameVisibility()
    if (MistWeaverData.SHOW_FOCUS_FRAME) then
        MwFocusFrame:Show();
    else
        MwFocusFrame:Hide();
    end

    if (MistWeaverData.SHOW_FOCUS_FRAME_HEADER) then
        MistWeaver_SetBackdrop(MwFocusFrame);
        MwFocusFrame.title:Show();
    else
        MwFocusFrame:SetBackdrop(nil);
        MwFocusFrame.title:Hide();
    end
end

function MistWeaver_InitFocusSpells()
    MwFocusUnitFrame.unit = "focus";
    MistWeaver_RebindSpells(MwFocusUnitFrame);
    MistWeaver_RebindRaidData(MwFocusUnitFrame, "focus");
end

function MistWeaver_FocusFrameOnEvent(self, event, ...)
    if (event == "PLAYER_FOCUS_CHANGED") then
        MistWeaver_FocusFrameFocusChanged();
    end
end

function MistWeaver_FocusFrameOnMouseDown(frame, button)
    if (button == "RightButton") then
        if (IsControlKeyDown()) then
            MwFocusFrame:StartMoving();
        end
    end
end

function MistWeaver_FocusFrameOnMouseUp(frame, button)
    MwFocusFrame:StopMovingOrSizing();
end

function MistWeaver_FocusFrameFocusChanged()
    local alpha = 1.0
    
    if (MistWeaver_IsActive() and UnitExists("focus")) then
        MwFocusFrame:SetAlpha(1.0);
        
        alpha = 1.0;
    else
        MwFocusFrame:SetAlpha(0.7);
        
        alpha = 0.0;
    end
    
    MwFocusUnitFrameHealth:SetAlpha(alpha);
    MwFocusUnitFrameHealthPrediction:SetAlpha(alpha);
    MwFocusUnitFrameAggro:SetAlpha(alpha);
    MwFocusUnitFrameEssenceFont:SetAlpha(alpha);
    MwFocusUnitFrameRenewingMist:SetAlpha(alpha);
    MwFocusUnitFrameEnvelopingMist:SetAlpha(alpha);
    MwFocusUnitFrame.art:SetAlpha(alpha);

    if (MwFocusUnitFrameRaidClassIcon) then
        MwFocusUnitFrameRaidClassIcon:SetAlpha(alpha);
    end

    MwFocusUnitFrameRaidDetoxFrame:SetAlpha(0.0);
end

function MistWeaver_DoFocusUpdate()
    if (UnitExists("focus") and MwFocusFrame:IsVisible()) then
        MistWeaver_UpdateUnit(MwFocusUnitFrame, "focus");
    end
end
