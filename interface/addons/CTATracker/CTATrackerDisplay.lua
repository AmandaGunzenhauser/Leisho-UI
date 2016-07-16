function CTATracker_CreateInnerFrame()
  CTATracker_MainFrame:SetWidth(89);
  CTATracker_MainFrame:SetHeight(0);
  CTATracker_InnerFrame = CreateFrame("frame","CTATracker_IFrame",CTATracker_MainFrame);
  CTATracker_InnerFrame:SetPoint("RIGHT",CTATracker_MainFrame,-2,0);
  CTATracker_InnerFrame:SetWidth(50);
  CTATracker_InnerFrame:SetHeight(0);
  CTATracker_InnerFrame:SetMovable(true);
  CTATracker_InnerFrame:EnableMouse(true);
  CTATracker_InnerFrame:SetFrameStrata("BACKGROUND");

  CTATracker_InnerFrame.texture = CTATracker_InnerFrame:CreateTexture();
  CTATracker_InnerFrame.texture:SetAllPoints(CTATracker_InnerFrame);
  CTATracker_InnerFrame.texture:SetTexture(0,0,0,0.75);

end

function CTATracker_UpdateDisplay(name, tank, healer, dps)
  local foundRelavantPoint = 0;
  if(tank == true or healer == true or dps == true) then
    CTATracker_DisplayName(name);
  end
  if(tank == true) then
    foundRelavantPoint = CTATracker_DisplayTankIcon(foundRelavantPoint);
  end
  if(healer == true) then
    foundRelavantPoint = CTATracker_DisplayHealerIcon(foundRelavantPoint);
  end
  if(dps == true) then
    foundRelavantPoint = CTATracker_DisplayDPSIcon(foundRelavantPoint);
  end
  CTATracker_MainFrame:SetHeight((16*(CTATracker_NumberOfCTA-1)));
  CTATracker_InnerFrame:SetHeight((16*(CTATracker_NumberOfCTA-1)));
  foundRelavantPoint = 0;
end
--this function puts the name of the current cta in a font string and displays it
function CTATracker_DisplayName(name)
  local text = CTATracker_MainFrame:CreateFontString(nil,"BACKGROUND");
  text:SetPoint("RIGHT", 4, 0);
  --top if runs when it is the first name to be displayed, second runs otherwise
    if(CTATracker_CurrentCTA[CTATracker_NumberOfCTA] == CTATracker_MainFrame) then
      text:SetPoint("LEFT", CTATracker_CurrentCTA[CTATracker_NumberOfCTA], "TOPLEFT", 2, -10);
    else
      text:SetPoint("LEFT", CTATracker_CurrentCTA[CTATracker_NumberOfCTA], "TOPLEFT", 0, -20);
    end
  text:SetFont("Fonts\\FRIZQT__.TTF", 8);
  text:SetShadowOffset(1,-1);
  text:SetJustifyH("LEFT");
  text:SetText(name);
  table.insert(CTATracker_CurrentCTA, text);
  CTATracker_NumberOfCTA = CTATracker_NumberOfCTA + 1;
end
--if there is a tank CTA for the current lfg/lfr check, the tank icon is displayed
function CTATracker_DisplayTankIcon(foundRelavantPoint)
  --tank texture
  local tankFrame = CreateFrame("frame","tankFrame",CTATracker_InnerFrame);
  --for determining if other CTA's will be aligned to this icon or not
  if((CTATracker_NumberOfCTA-1) == 1 and CTATracker_CurrentRoleIconNum == 0) then --checks for first cta found
    tankFrame:SetPoint("LEFT",CTATracker_CurrentCTA[CTATracker_NumberOfCTA],"CENTER",-10,0);
    CTATracker_NextRelativePoint = tankFrame;
    foundRelavantPoint = 1;
  else --checks for relative point for displaying next CTA icon
    tankFrame:SetPoint("TOP", CTATracker_NextRelativePoint,"BOTTOM");
    CTATracker_NextRelativePoint = tankFrame;
    foundRelavantPoint = 1;
  end
  tankFrame:SetWidth(16);
  tankFrame:SetHeight(16);
  tankFrame:SetFrameStrata("BACKGROUND");

  local textureTank = tankFrame:CreateTexture();
  textureTank:SetTexture("Interface\\LFGFRAME\\UI-LFG-ICON-ROLES.blp");
  textureTank:SetTexCoord(0,0.26,0.26,0.52);
  textureTank:SetAllPoints(tankFrame);
  table.insert(CTATracker_RoleIcons, tankFrame);
  CTATracker_CurrentRoleIconNum = CTATracker_CurrentRoleIconNum + 1;
  return foundRelavantPoint;
end
--if there is a healer cta for the current lfg/lfr check, the healer icon is displayed
function CTATracker_DisplayHealerIcon(foundRelavantPoint)
  --healer texture
  local healerFrame = CreateFrame("frame","healerFrame",CTATracker_InnerFrame);
  if((CTATracker_NumberOfCTA-1) == 1 and CTATracker_CurrentRoleIconNum == 0) then --checks for first cta found
    healerFrame:SetPoint("LEFT",CTATracker_CurrentCTA[CTATracker_NumberOfCTA],"CENTER",-10,0);
    CTATracker_NextRelativePoint = healerFrame;
    foundRelavantPoint = 1;
  elseif(tank ~= true and CTATracker_CurrentRoleIconNum == 0) then
    healerFrame:SetPoint("LEFT",CTATracker_CurrentCTA[CTATracker_NumberOfCTA],"CENTER",-10,0);
    CTATracker_NextRelativePoint = healerFrame;
  elseif(tank ~= true and foundRelavantPoint == 0) then
    healerFrame:SetPoint("TOP",CTATracker_NextRelativePoint,"BOTTOM",0,0);
    CTATracker_NextRelativePoint = healerFrame;
    foundRelavantPoint = 1;
  else
    healerFrame:SetPoint("LEFT", CTATracker_RoleIcons[CTATracker_CurrentRoleIconNum],"RIGHT",0,0);
  end
  healerFrame:SetWidth(16);
  healerFrame:SetHeight(16);
  healerFrame:SetFrameStrata("BACKGROUND");

  local textureHealer = healerFrame:CreateTexture();
  textureHealer:SetTexture("Interface\\LFGFRAME\\UI-LFG-ICON-ROLES.blp");
  textureHealer:SetTexCoord(0.26,0.52,0,0.26);
  textureHealer:SetAllPoints(healerFrame);
  table.insert(CTATracker_RoleIcons, healerFrame);
  CTATracker_CurrentRoleIconNum = CTATracker_CurrentRoleIconNum + 1;
  return foundRelavantPoint;
end
--if there is a dps cta for the current lfg/lfr check, the dps icon is displayed
function CTATracker_DisplayDPSIcon(foundRelavantPoint)
  --dps texture
  local dpsFrame = CreateFrame("frame","dpsFrame",CTATracker_InnerFrame);
  if(tank ~= true and healer ~= true and CTATracker_CurrentRoleIconNum == 0) then
    dpsFrame:SetPoint("LEFT",CTATracker_CurrentCTA[CTATracker_NumberOfCTA],"CENTER",-10,0);
    CTATracker_NextRelativePoint = dpsFrame;
  elseif(tank ~= true and healer ~= true and foundRelavantPoint == 0) then
    dpsFrame:SetPoint("TOP", CTATracker_NextRelativePoint,"BOTTOM",0,0);
    CTATracker_NextRelativePoint = dpsFrame;
    foundRelavantPoint = 1;
  else
    dpsFrame:SetPoint("LEFT", CTATracker_RoleIcons[CTATracker_CurrentRoleIconNum],"RIGHT",0,0);
  end
  dpsFrame:SetWidth(16);
  dpsFrame:SetHeight(16);
  dpsFrame:SetFrameStrata("BACKGROUND");

  local textureDPS = dpsFrame:CreateTexture();
  textureDPS:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES.blp");
  textureDPS:SetTexCoord(0.26,0.52,0.26,0.52);
  textureDPS:SetAllPoints(dpsFrame);
  table.insert(CTATracker_RoleIcons, dpsFrame);
  CTATracker_CurrentRoleIconNum = CTATracker_CurrentRoleIconNum + 1;
  return foundRelavantPoint;
end
