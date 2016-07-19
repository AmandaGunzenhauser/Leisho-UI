function MistWeaver_TargetFrameOnLoad()
    local _, unitClass = UnitClass("player");
    if (unitClass ~= "MONK") then
        return;
    end

    MwTargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED");

    MwTargetFrame:SetMovable(true);
    MwTargetFrame:SetUserPlaced(true);
    MwTargetFrame:SetClampedToScreen(true);

    MistWeaver_SetBackdrop(MwTargetFrame);

    MwTargetFrame:SetParent(MistWeaverFrame);
    MwTargetFrame:Show();

    MistWeaver_CheckTargetFrameVisibility();
end

function MistWeaver_InitTargetFrame()
    -- unit frame
    local unitFrame = _G["MwTargetUnitFrame"];
    if (not unitFrame) then
        unitFrame = MistWeaver_CreateFrame("Frame", "MwTargetUnitFrame", MwTargetFrame, MwUnitFrameTemplate);
        unitFrame:SetPoint("TOP", MwTargetFrame, "BOTTOM", 0, 5);

        MistWeaver_InitUnitFrame(unitFrame);

        unitFrame:SetSize(100, 50);
        MwTargetUnitFrameHealth:SetWidth(100);

        MistWeaver_TargetFrameTargetChanged();
        unitFrame:Show();
    end

    MistWeaver_TargetFrameTargetChanged();
end

function MistWeaver_CheckTargetFrameVisibility()
    if (MistWeaverData.SHOW_TARGET_FRAME) then
        MwTargetFrame:Show();
    else
        MwTargetFrame:Hide();
    end

    if (MistWeaverData.SHOW_TARGET_FRAME_HEADER) then
        MistWeaver_SetBackdrop(MwTargetFrame);
        MwTargetFrame.title:Show();
    else
        MwTargetFrame:SetBackdrop(nil);
        MwTargetFrame.title:Hide();
    end
end

function MistWeaver_InitTargetSpells()
    MwTargetUnitFrame.unit = "target";
    MistWeaver_RebindSpells(MwTargetUnitFrame);
    MistWeaver_RebindRaidData(MwTargetUnitFrame, "target");
end

function MistWeaver_TargetFrameOnEvent(self, event, ...)
    if (event == "PLAYER_TARGET_CHANGED") then
        MistWeaver_TargetFrameTargetChanged();
    end
end

function MistWeaver_TargetFrameOnMouseDown(frame, button)
    if (button == "RightButton") then
        if (IsControlKeyDown()) then
            MwTargetFrame:StartMoving();
        end
    end
end

function MistWeaver_TargetFrameOnMouseUp(frame, button)
    MwTargetFrame:StopMovingOrSizing();
end

function MistWeaver_TargetFrameTargetChanged()
    local alpha = 1.0
    
    if (MistWeaver_IsActive() and UnitExists("target")) then
        MwTargetFrame:SetAlpha(1.0);
        
        alpha = 1.0;
    else
        MwTargetFrame:SetAlpha(0.7);
        
        alpha = 0.0;
    end
        
    MwTargetUnitFrameHealth:SetAlpha(alpha);
    MwTargetUnitFrameHealthPrediction:SetAlpha(alpha);
    MwTargetUnitFrameAggro:SetAlpha(alpha);
    MwTargetUnitFrameEssenceFont:SetAlpha(alpha);
    MwTargetUnitFrameRenewingMist:SetAlpha(alpha);
    MwTargetUnitFrameEnvelopingMist:SetAlpha(alpha);
    MwTargetUnitFrame.art:SetAlpha(alpha);

    if (MwTargetUnitFrameRaidClassIcon) then
        MwTargetUnitFrameRaidClassIcon:SetAlpha(0.0);
    end

    MwTargetUnitFrameRaidDetoxFrame:SetAlpha(0.0);
end

function MistWeaver_DoTargetUpdate()
    if (UnitExists("target") and MwTargetFrame:IsVisible()) then
        MistWeaver_UpdateUnit(MwTargetUnitFrame, "target");
    end
end
