local function findCorner(angle)
    local x = 0.5 + math.cos(angle) / sqrt(2);
    local y = 0.5 + math.sin(angle) / sqrt(2);
    return x, y;
end

local function MistWeaver_UpdateArrow(self)
    -- not visible
    if (not self:IsVisible() or not self.unitframe) then
        self.timer = 0;
        return;
    end
    
    -- get unit
    local unit = self.unitframe.unit;

    -- no unit or unit is player
    if (not unit or UnitIsUnit("player",unit)) then
        self:Hide();
        self.timer = 0;
        return;
    end

    -- get coordinates
    local playerX, playerY, playerZ, playerMapId = UnitPosition("player");
    local unitX, unitY, unitZ, unitMapId = UnitPosition(unit);

    -- no coordinates
    if (not playerX or not unitX) then
        self:Hide();
        self.timer = 0;
        return;
    end

    -- start next timer
    self.timer = 0.01;

    local arrowTexture = self.texture;
    
    local distanceSquared, checkedDistance = UnitDistanceSquared(unit);
    
    -- text and color
    local distance = sqrt(UnitDistanceSquared(unit));
    self.distance:SetText(format("%.0f", distance));
    
    if (distance < 20) then
        arrowTexture:SetVertexColor(0, 1, 0);
    elseif (UnitInRange(unit)) then
        arrowTexture:SetVertexColor(1, 1, 1);
    else
        arrowTexture:SetVertexColor(1, 0, 0);
    end

    -- rotate
    local dy = unitY - playerY;
    local dx = unitX - playerX;
    local angle = atan2(dy, dx) * PI / 180 - GetPlayerFacing();

    local ulx, uly = findCorner(angle + 1.25 * PI);
    local llx, lly = findCorner(angle + 0.75 * PI);
    local urx, ury = findCorner(angle - 0.25 * PI);
    local lrx, lry = findCorner(angle + 0.25 * PI);
    
    arrowTexture:SetTexCoord(ulx, uly, llx, lly, urx, ury, lrx, lry);
end

function MistWeaver_CreateArrow(unitframe)
    local parent = _G[unitframe:GetName().."RaidButton1"];

    local arrowFrame = CreateFrame("Frame", unitframe:GetName().."RaidButton1Arrow", parent);
    arrowFrame:Hide();
    arrowFrame.timer = 0;
    arrowFrame:SetFrameStrata("MEDIUM");    
    arrowFrame:SetSize(32, 32);
    
    arrowFrame.texture = arrowFrame:CreateTexture(nil, "OVERLAY");
    arrowFrame.texture:SetAllPoints(true);
    arrowFrame.texture:SetTexture("Interface\\MiniMap\\MiniMap-QuestArrow");
    
    arrowFrame.distance = arrowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
    arrowFrame.distance:SetPoint("TOP", arrowFrame, "BOTTOM", 0, 8);
    
    arrowFrame.unitframe = unitframe;
    
    arrowFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = self.timer - elapsed;
        if (self.timer < 0) then
            MistWeaver_UpdateArrow(self);
        end
    end);
    
    arrowFrame:ClearAllPoints();
    arrowFrame:SetPoint("CENTER", parent, "CENTER");
    
    return arrowFrame;
end

function MistWeaver_ShowArrow(unitframe)
    if (UnitIsUnit("player", unitframe.unit)) then
        return;
    end

    local arrow = _G[unitframe:GetName().."RaidButton1Arrow"];
    if (not arrow) then
        arrow = MistWeaver_CreateArrow(unitframe);
        arrow:EnableMouse(false);
    end
    
    arrow:Show();    
    arrow.timer = 0.01;    
    MistWeaver_UpdateArrow(arrow);
end

function MistWeaver_HideArrow(unitframe)
    if (not unitframe.unit or UnitIsUnit("player", unitframe.unit)) then
        return;
    end
    
    local isOver = MouseIsOver(_G[unitframe:GetName().."RaidButton1"]);
    if (isOver) then
        MistWeaver_ShowArrow(unitframe);
        return;
    end
    
    local arrow = _G[unitframe:GetName().."RaidButton1Arrow"];
    if (not arrow) then
        arrow = MistWeaver_CreateArrow(unitframe);
    end
    
    arrow:Hide();    
    arrow.timer = 0;
end
