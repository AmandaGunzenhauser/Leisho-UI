-------------------------------------------------------------------------------
--                 L  O  C  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

local addonName, L = ...;

local DATA_MAGIC_NUMBER = "NigglesPetTeam";
local DATA_VERSION      = 2;
local DATA_MIN_LENGTH   = 183;

local base64urlEncodeMapping =
{
  "A", "B", "C", "D", "E", "F", "G", "H",
  "I", "J", "K", "L", "M", "N", "O", "P",
  "Q", "R", "S", "T", "U", "V", "W", "X",
  "Y", "Z", "a", "b", "c", "d", "e", "f",
  "g", "h", "i", "j", "k", "l", "m", "n",
  "o", "p", "q", "r", "s", "t", "u", "v",
  "w", "x", "y", "z", "0", "1", "2", "3",
  "4", "5", "6", "7", "8", "9", "-", "_",
};

-- NOTE: Performance of the base64url decode is improved by about 10% if this
--       array isn't sparse.
local base64urlDecodeMapping =
{
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 62,  0,  0, 52,
  53, 54, 55, 56, 57, 58, 59, 60, 61,  0,  0,  0,  0,  0,  0,  0,
   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
  16, 17, 18, 19, 20, 21, 22, 23, 24, 25,  0,  0,  0,  0, 63,  0,
  26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
  42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
};

local dataTypeFunc;
local dataImportFunc;

local importExportFrame;

local tutorialPlateInfo =
{
  FramePos  = {x = 0, y = -20},
  FrameSize = {width = 312, height = 228},
  [1] =
  {
    HighLightBox = {x = 8, y = -59, width = 282, height = 149},
    ButtonPos    = {x = 126, y = -113},
    ToolTipDir   = "UP",
    ToolTipText  = "",
  }
};

-------------------------------------------------------------------------------
--                  L  O  C  A  L     C  L  A  S  S  E  S
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--              L  O  C  A  L     D  E  F  I  N  I  T  I  O  N  S
-------------------------------------------------------------------------------

local dataByteIsType;
local dataBytePack;
local dataByteUnpack;
local dataStringIsType;
local dataStringPack;
local dataStringUnpack;
local dataUint16IsType;
local dataUint16Pack;
local dataUint16Unpack;
local dataUint32IsType;
local dataUint32Pack;
local dataUint32Unpack;
local fletcher16;
local tutorialOnClick;

-------------------------------------------------------------------------------
--                 L  O  C  A  L     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function to decode a string from base64url
--
local function base64urlDecode(data)
  -- Local Variables
  local byte1;
  local byte2;
  local byte3;
  local dataLen = string.len(data);
  local encoded1;
  local encoded2;
  local encoded3;
  local encoded4;
  local isPadded = (string.sub(data, -1, -1) == "=");
  local mapping = base64urlDecodeMapping;
  local output = {};
  local strbyte = string.byte;
  local strChar = string.char;

  -- Check the length and characters of the data are valid
  if ((dataLen%4 ~= 0) or (string.find(data, "[^%a%d\-_=]") ~= nil)) then
    return nil;
  end

  -- Process as much data as possible in 4 character blocks
  for dataPos = 1, dataLen-(isPadded and 4 or 0), 4 do
    -- Extract the next 4 base64url characters
    encoded1 = mapping[strbyte(data, dataPos  )];
    encoded2 = mapping[strbyte(data, dataPos+1)];
    encoded3 = mapping[strbyte(data, dataPos+2)];
    encoded4 = mapping[strbyte(data, dataPos+3)];

    -- Decode the 4 base64url characters into 3 bytes
    byte2 = encoded2%16;
    byte1 = (encoded1*4)+((encoded2-byte2)/16);
    byte3 = (encoded3%4);
    byte2 = (byte2*16)+((encoded3-byte3)/4);
    byte3 = (byte3*64)+encoded4;

    -- Add the bytes to the output table
    output[#output+1] = strChar(byte1)..strChar(byte2)..strChar(byte3);
  end

  -- Check if the encoded data is padded
  if (isPadded) then
    -- Work out how many bytes are still to be decoded
    dataPos = dataLen-3;
    if (string.sub(data, -2, -2) == "=") then
      -- Extract the next 2 base64url characters
      encoded1 = mapping[strbyte(data, dataPos  )];
      encoded2 = mapping[strbyte(data, dataPos+1)];

      -- Decode the 2 base64url characters into a byte
      byte1 = (encoded1*4)+((encoded2-(encoded2%16))/16);

      -- Add the byte to the output table
      output[#output+1] = strChar(byte1);
    else
      -- Extract the next 3 base64url characters
      encoded1 = mapping[strbyte(data, dataPos  )];
      encoded2 = mapping[strbyte(data, dataPos+1)];
      encoded3 = mapping[strbyte(data, dataPos+2)];

      -- Decode the 3 base64url characters into 2 bytes
      byte2 = encoded2%16;
      byte1 = (encoded1*4)+((encoded2-byte2)/16);
      byte2 = (byte2*16)+((encoded3-(encoded3%4))/4);

      -- Add the bytes to the output table
      output[#output+1] = strChar(byte1)..strChar(byte2);
    end
  end

  return table.concat(output);
end

--
-- Function to encode a string into base64url
--
local function base64urlEncode(data)
  -- Local Variables
  local byte1;
  local byte2;
  local byte3;
  local dataLeft;
  local dataLen = string.len(data);
  local dataPos;
  local encoded1;
  local encoded2;
  local encoded3;
  local encoded4;
  local mapping = base64urlEncodeMapping;
  local output = {};
  local strbyte = string.byte;

  -- Process as much data as possible in 3 byte blocks
  for dataPos = 1, dataLen-(dataLen%3), 3 do
    -- Extract the next 3 bytes to be encoded
    byte1 = strbyte(data, dataPos  );
    byte2 = strbyte(data, dataPos+1);
    byte3 = strbyte(data, dataPos+2);

    -- Encode the 3 bytes into 4 base64url characters
    encoded2 = byte1%4;
    encoded1 = (byte1-encoded2)/4;
    encoded3 = byte2%16;
    encoded2 = (encoded2*16)+((byte2-encoded3)/16);
    encoded4 = byte3%64;
    encoded3 = (encoded3*4)+((byte3-encoded4)/64);

    -- Add the base64url characters to the output table
    output[#output+1] = mapping[encoded1+1]..mapping[encoded2+1]..
                        mapping[encoded3+1]..mapping[encoded4+1];
  end

  -- Process any data left
  dataLeft = dataLen%3;
  dataPos  = dataLen-dataLeft+1;
  if (dataLeft == 1) then
    -- Extract the last byte to be encoded
    byte1 = strbyte(data, dataPos);

    -- Encode the byte into 2 base64url characters
    encoded2 = byte1%4;
    encoded1 = (byte1-encoded2)/4;
    encoded2 = (encoded2*16);

    -- Add the base64url characters to the output table, with padding
    output[#output+1] = mapping[encoded1+1]..mapping[encoded2+1].."==";
  elseif (dataLeft == 2) then
    -- Extract the last 2 bytes to be encoded
    byte1 = strbyte(data, dataPos  );
    byte2 = strbyte(data, dataPos+1);

    -- Encode the 2 bytes into 3 base64url characters
    encoded2 = byte1%4;
    encoded1 = (byte1-encoded2)/4;
    encoded3 = byte2%16;
    encoded2 = (encoded2*16)+((byte2-encoded3)/16);
    encoded3 = (encoded3*4);

    -- Add the base64url characters to the output table, with padding
    output[#output+1] = mapping[encoded1+1]..mapping[encoded2+1]..
                        mapping[encoded3+1].."=";
  end

  return table.concat(output);
end

--
-- Function to check if a value can be represented as a byte
--
dataByteIsType = function(value)
  return ((type(value) == "number") and (value >= 0) and (value <= 255));
end

--
-- Function to pack a byte ready for adding to a data string
--
dataBytePack = function(value)
  return "B"..string.char((value or 0)%256);
end

--
-- Function to unpack a byte from a data string
--
dataByteUnpack = function(data, dataPos, dataLeft)
  -- Local Variables
  local value;

  -- Check there is enough data left and the next item is a Uint16
  if (dataLeft >= 1) then
    value = string.byte(data, dataPos);
    dataPos = dataPos+1;
  else
    dataPos = -1;
  end

  return value, dataPos
end

--
-- Function called when cursor moves in the editbox of the Import/Export
-- frame.
--
local function dataEditBoxOnCursorChanged(self)
  -- Check which mode the frame is in
  if (importExportFrame.layoutName == "export") then
    self:HighlightText(0, -1);
  end

  return;
end

--
-- Function called when the editbox of the Import/Export frame gains focus.
--
local function dataEditBoxOnEditFocusGained(self)
  self:HighlightText(0, -1);
  return;
end

--
-- Function called when the text changes in the editbox of the Import/Export
-- frame.
--
local function dataEditBoxOnTextChanged(self, userInput)
  -- Check which mode the frame is in
  if (importExportFrame.layoutName == "import") then
    -- Local Variables
    local _;
    local data = self:GetText();
    local dataChecksum;
    local dataHeaderEnd;
    local dataLen;
    local dataVersion;
    local isValid = false;

    -- Check the data entered is large enough to be a valid pet team
    if (self:GetNumLetters() >= DATA_MIN_LENGTH) then
      -- Get the data entered
      data = self:GetText():gsub("[\n ]", "");

      -- Check the data's basic structure is correct
      _, dataHeaderEnd, dataVersion, dataLen, dataChecksum = string.find(data,
        "^{"..DATA_MAGIC_NUMBER.."(%x%x)(%x%x%x%x)(%x%x%x%x)");
      if ((dataVersion ~= nil) and (string.sub(data, -1, -1) == "}")) then
        -- Convert the data length and checksum back into numbers
        dataLen      = tonumber(dataLen,      16);
        dataChecksum = tonumber(dataChecksum, 16);

        -- Check the length of the data appears valid
        if (dataLen == string.len(data)-dataHeaderEnd-1) then
          -- Check the checksum matches
          data = string.sub(data, dataHeaderEnd+1, -2);
          if (fletcher16(data) == dataChecksum) then
            isValid = true;
          end
        end
      end
    end

    -- Enable/disable the Import button
    importExportFrame.import:SetEnabled(isValid);
  else
    self:SetText(importExportFrame.data);
    self:HighlightText(0, -1);
  end

  return;
end

--
-- Function to pack the specified values into a data string
--
local function dataPack(...)
  -- Local Variables
  local data = {};
  local dataIdx = 0;
  local numArgs = select("#", ...);
  local validType;
  local validTypes;
  local valueType;
  local valueData;

  -- Check there is an even number of arguments
  if (numArgs%2 == 0) then
    -- Pack each value specified
    for argIdx = 1, numArgs, 2 do
      -- Get the next value to be packed and its valid types
      validTypes, value = select(argIdx, ...);
      valueData         = nil;

      -- Search for a valid type that represent the value
      for typeIdx = 1, string.len(validTypes) do
        validType = string.sub(validTypes, typeIdx, typeIdx);
        if ((dataTypeFunc[validType] ~= nil) and
            (dataTypeFunc[validType][1](value))) then
          -- Pack the data
          valueData = (dataTypeFunc[validType][2])(value);
          break;
        end
      end

      -- Check the value could be packed
      if (valueData ~= nil) then
        dataIdx = dataIdx+1;
        data[dataIdx] = (dataTypeFunc[validType][2])(value);
      else
        dataIdx = 0;
        break;
      end
    end
  end

  return (dataIdx > 0 and table.concat(data) or nil);
end

--
-- Function to check if a value can be represented as a string
--
dataStringIsType = function(value)
  return (type(value) == "string");
end

--
-- Function to pack a string ready for adding to a data string
--
dataStringPack = function(string)
  -- Local Variables
  local data;
  local stringLen;

  -- Get the length of the string
  stringLen = string.len(string);

  -- Check the string isn't too long
  if (stringLen <= 0xFFFF) then
    data = "S"..string.char(stringLen%256)..
      string.char((stringLen-(stringLen%256))/256)..string;
  end

  return data;
end

--
-- Function to unpack a string from a data string
--
dataStringUnpack = function(data, dataPos, dataLeft)
  -- Local Variables
  local value;
  local valueLen;

  -- Check there is enough data left and the next item is a string
  if (dataLeft >= 2) then
    -- Get the length of the value
    valueLen = (string.byte(data, dataPos+1)*256)+string.byte(data, dataPos);

    -- Check there is enough data left
    if (2+valueLen <= dataLeft) then
      -- Extract the value from the data
      value  = (valueLen > 0 and
        string.sub(data, dataPos+2, dataPos+valueLen+1) or "");
      dataPos = dataPos+2+valueLen;
    else
      dataPos = -1;
    end
  end

  return value, dataPos;
end

--
-- Function to check if a value can be represented as a Uint16
--
dataUint16IsType = function(value)
  return ((type(value) == "number") and (value >= 0) and (value <= 0xFFFF));
end

--
-- Function to pack a Uint16 ready for adding to a data string
--
dataUint16Pack = function(value)
  -- Local Variables
  local byte1;
  local byte2;

  -- Extract each byte from the value
  value = (value or 0)
  byte1 = value%256;
  byte2 = (value-byte1)/256;

  return "O"..string.char(byte1)..string.char(byte2);
end

--
-- Function to unpack a Uint16 from a data string
--
dataUint16Unpack = function(data, dataPos, dataLeft)
  -- Local Variables
  local value;

  -- Check there is enough data left and the next item is a Uint16
  if (dataLeft >= 2) then
    value = string.byte(data, dataPos)+(string.byte(data, dataPos+1)*0x0100);
    dataPos = dataPos+2;
  else
    dataPos = -1;
  end

  return value, dataPos
end

--
-- Function to check if a value can be represented as a Uint32
--
dataUint32IsType = function(value)
  return ((type(value) == "number") and (value >= 0) and (value <= 0xFFFFFFFF));
end

--
-- Function to pack a Uint32 ready for adding to a data string
--
dataUint32Pack = function(value)
  -- Local Variables
  local byte1;
  local byte2;
  local byte3;
  local byte4;

  -- Extract each byte from the value
  value = (value or 0)
  byte1 = value%256;
  value = (value-byte1)/256;
  byte2 = value%256;
  value = (value-byte2)/256;
  byte3 = value%256;
  byte4 = (value-byte3)/256;

  return "I"..string.char(byte1)..string.char(byte2)..
    string.char(byte3)..string.char(byte4);
end

--
-- Function to unpack a Uint32 from a data string
--
dataUint32Unpack = function(data, dataPos, dataLeft)
  -- Local Variables
  local value;

  -- Check there is enough data left and the next item is a Uint32
  if (dataLeft >= 4) then
    value = string.byte(data, dataPos  )+
           (string.byte(data, dataPos+1)*0x00000100)+
           (string.byte(data, dataPos+2)*0x00010000)+
           (string.byte(data, dataPos+3)*0x01000000);
    dataPos = dataPos+4;
  else
    dataPos = -1;
  end

  return value, dataPos
end

--
-- Function to unpack the specified values from a data string
--
local function dataUnpack(data, dataPos, dataLen, valueTypes)
  -- Local Variables
  local dataType;
  local values = {};

  -- Extract values from the data
  for valueIdx = 1, #valueTypes do
    -- Get the type of the next value in the data
    dataType = string.sub(data, dataPos, dataPos);

    -- Check the type is one of the expected types
    if (string.find(valueTypes[valueIdx], dataType, 1, true) ~= nil) then
      values[valueIdx], dataPos =
        (dataTypeFunc[dataType][3])(data, dataPos+1, dataLen-dataPos);
      if (dataPos == -1) then
        break;
      end
    else
      dataPos = -1;
      break;
    end
  end

  return dataPos, unpack(values);
end

--
-- Function to generate a checksum for an imported/exported pet team
--
fletcher16 = function(data)
  -- Local Variables
  local band = bit.band;
  local dataIdx = 1;
  local dataLen = string.len(data);
  local min = math.min;
  local rshift = bit.rshift;
  local strbyte = string.byte;
  local sum1 = 0xFF;
  local sum2 = 0xFF;

  -- Process the data in 20-byte chunks
  while (dataIdx <= dataLen) do
    for blockIdx = dataIdx, min(dataLen, dataIdx+19) do
      sum1 = sum1+strbyte(data, blockIdx);
      sum2 = sum2+sum1;
    end
    sum1    = band(sum1, 0xFF)+rshift(sum1, 8);
    sum2    = band(sum2, 0xFF)+rshift(sum2, 8);
    dataIdx = dataIdx+20;
  end
  sum1 = band(sum1, 0xFF)+rshift(sum1, 8);
  sum2 = band(sum2, 0xFF)+rshift(sum2, 8);

  return bit.lshift(sum2, 8)+sum1;
end

--
-- Function called when the 'Import' button is clicked. It tries to import the
-- pet team pasted in the data edit box.
--
local function importButtonOnClick(self, mouseButton)
  -- Local Variables
  local _;
  local data = importExportFrame.scrollFrame.data:GetText();
  local dataChecksum;
  local dataHeaderEnd;
  local dataFooterStart;
  local dataLen;
  local dataVersion;
  local errorMsg;
  local isValid = false;

  -- Check the header matches the required format
  _, dataHeaderEnd, dataVersion, dataLen, dataChecksum = string.find(data,
    "^{"..DATA_MAGIC_NUMBER.."(%x%x)(%x%x%x%x)(%x%x%x%x)");
  if (dataVersion == nil) then
    errorMsg = L["PetTeamErrorHeader"];
  end

  -- Check the footer matches the required format
  if (errorMsg == nil) then
    dataFooterStart, _ = string.find(data, "}%s*$");
    if (dataFooterStart == nil) then
      errorMsg = L["PetTeamErrorEnd"];
    end
  end

  -- Strip the header and all spaces from the string
  if (errorMsg == nil) then
    data         = string.sub(data, dataHeaderEnd+1,
      dataFooterStart-1):gsub("%s", "");
    dataLen      = tonumber(dataLen,      16);
    dataChecksum = tonumber(dataChecksum, 16);
  end

  -- Check the length of the data appears valid
  if ((errorMsg == nil) and (dataLen ~= string.len(data))) then
    errorMsg = L["PetTeamErrorLength"];
  end

  -- Check the checksum matches
  if ((errorMsg == nil) and (fletcher16(data) ~= dataChecksum)) then
    errorMsg = L["PetTeamErrorChecksum"];
  end

  -- Check there is an import function for the version
  if ((errorMsg == nil) and
      (dataImportFunc[dataVersion] == nil)) then
    errorMsg = L["PetTeamErrorVersion"];
  end

  -- Convert the base64url data into binary
  if (errorMsg == nil)  then
    data = base64urlDecode(data);
    if (data == nil) then
      errorMsg = L["PetTeamErrorCorrupt"];
    end
  end

  -- Import the pet team
  if ((errorMsg == nil) and
      (not (dataImportFunc[dataVersion])(data, importExportFrame.data))) then
    errorMsg = L["PetTeamErrorCorrupt"];
  end

  -- Check if the pet team was successfully imported
  if (errorMsg == nil) then
    -- Update the pet team displayed in the Pet Team Edit frame
    L.petTeamEditUpdate();
  else
    -- Display the error message
    StaticPopup_Show("NIGGLES_PETTEAMS_WARNING", errorMsg);
  end

  -- Hide the Import/Export frame
  importExportFrame:Hide();

  return;
end

--
-- Function called when the Import/Export frame is shown or hidden
--
local function importExportOnShowHide(self)
  -- Do any processing that is dependant on the frame's state
  if (self:IsShown()) then
    -- Show/hide the help plates, if required
    if ((NglPtDB.settings.generalShowTutorials) and
        (bit.band(NglPtDB.tutorialSeen, self.tutorialFlag) == 0)) then
      HelpPlate_Show(tutorialPlateInfo, self, self.tutorialButton, true);
      NglPtDB.tutorialSeen = bit.bor(NglPtDB.tutorialSeen, self.tutorialFlag);
    else
      HelpPlate_Hide(false);
    end
  else
    -- Hide the help plates
    HelpPlate_Hide(false);
  end

  -- Restore the frame's layout, if required
  if (self:IsShown()) then
    L.layoutRestore(self.layoutName, self, false);
  end

  -- Play the appropriate sound
  PlaySound(self:IsShown() and "igCharacterInfoOpen" or "igCharacterInfoClose");

  return;
end

--
-- Function to show the Import/Export frame
--
local function importExportShow(parent, import, data)
  -- Local Variables
  local frame = importExportFrame;
  local child;

  -- Check if the Import/Export frame exists
  if (frame == nil) then
     -- Create the frame
    frame = CreateFrame("Frame", "NigglesPetTeamImportExport",
      parent, "NigglesPetTeamImportExportTemplate");
    importExportFrame = frame;

    -- Set the frame's portrait
    SetPortraitToTexture(frame.portrait,
      "Interface\\Icons\\PetJournalPortrait");

    -- Initialise the tutorial button
    child = frame.tutorialButton;
    child:SetFrameLevel(frame.dragButton:GetFrameLevel()+1);
    child:SetScript("OnClick", tutorialOnClick);

    -- Initialise the label
    frame.label:SetText(L["EncodedPetTeam"]);

    -- Initialise the scroll frame
    NigglesPetTeamImportExportScrollFrameScrollBarBG:Show();
    NigglesPetTeamImportExportScrollFrameScrollBarBG:SetVertexColor(
      0, 0, 0, 0.75);

    -- Initialise the editbox
    child = frame.scrollFrame.data;
    child:SetTextInsets(0, 0, 0, 0);
    child:SetScript("OnTextChanged",     dataEditBoxOnTextChanged    );
    child:SetScript("OnEditFocusGained", dataEditBoxOnEditFocusGained);
    child:SetScript("OnCursorChanged",   dataEditBoxOnCursorChanged  );

    -- Initialise the Import button
    frame.import:SetText(L["Import"]);
    frame.import:SetScript("OnClick", importButtonOnClick);

    -- Hook script handlers
    frame.dragButton:HookScript("OnMouseUp",
      function(frame)
        L.layoutSave(frame:GetParent().layoutName, frame:GetParent(), false);
        return;
      end);

    -- Set the frame's scripts
    frame:SetScript("OnShow", importExportOnShowHide);
    frame:SetScript("OnHide", importExportOnShowHide);
  end

  -- Initialise the frame for either import or export
  frame.data = data;
  if (import) then
    frame.layoutName = "import";
    frame.tutorialFlag = L.TUTORIALSEENFLAG_IMPORT;
    frame.TitleText:SetText(L["PetTeamImport"]);
    frame.import:Show();
    frame.import:Disable();
    frame.close:SetText(CANCEL);
    frame.scrollFrame.data:SetText("");
    tutorialPlateInfo[1].ToolTipText = L["PetTeamImportTutorial"];
  else
    frame.layoutName = "export";
    frame.tutorialFlag = L.TUTORIALSEENFLAG_EXPORT;
    frame.TitleText:SetText(L["PetTeamExport"]);
    frame.import:Hide();
    frame.close:SetText(CLOSE);
    frame.scrollFrame.data:SetText("");
    frame.scrollFrame.data:HighlightText(0, -1);
    tutorialPlateInfo[1].ToolTipText = L["PetTeamExportTutorial"];
  end

  -- Set the Import/Export frame's parent
  frame:SetParent(parent);
  frame:SetFrameLevel(parent:GetFrameLevel()+20);

  -- Show the Import/Export frame and give the editbox focus
  frame:Show();
  frame.scrollFrame.data:SetFocus();

  return;
end

--
-- Function to export pet teams from the Pet Battle Teams addon to this addon
--
local function petBattleTeamsExport(teams)
  -- Local Variables
  local getPetInfo = C_PetJournal.GetPetInfoByPetID;
  local missingPet;
  local newTeamInfo;
  local notExported = 0;
  local numTeams = 0;

  -- Process all specified teams
  for teamIdx, team in pairs(teams) do
    -- Initialise some variables
    numTeams    = numTeams+1;
    missingPet  = false;
    newTeamInfo = L.petTeamCopy(nil, newTeamInfo);

    -- Check the team's pets are still available
    for petIdx = 1, 3 do
      pet = team[petIdx];
      if (pet == nil) then
        missingPet = true;
        break;
      elseif (pet.petID == "BattlePet-0-000000000000") then
        -- Do nothing
      elseif ((pet.petID ~= nil) and 
              (getPetInfo(pet.petID) ~= nil) and
              (#(pet.abilities) == L.NUM_ACTIVE_ABILITIES)) then
        -- Copy the pet's info to the new team
        newTeamInfo.pets[petIdx].guid = pet.petID;
        for abilityIdx = 1, L.NUM_ACTIVE_ABILITIES do
          newTeamInfo.pets[petIdx].abilityId[abilityIdx] =
            pet.abilities[abilityIdx];
        end
      else
        missingPet = true;
        break;
      end
    end

    -- Check the team isn't missing any pets
    if (not missingPet) then
      newTeamInfo.name = "PBT: "..(team.name or TEAM.." "..teamIdx);
      L.petTeamSave(newTeamInfo, "", nil);
    else
      notExported = notExported+1;
    end
  end

  -- Display a warning if any teams couldn't be exported
  if (notExported > 0) then
    if (numTeams == 1) then
      StaticPopup_Show("NIGGLES_PETTEAMS_WARNING", L["PetTeamErrorMissingPet"]);
    else
      StaticPopup_Show("NIGGLES_PETTEAMS_WARNING",
        format(L["PetTeamWarningExported"], numTeams-notExported, notExported));
    end
  else
    StaticPopup_Show("NIGGLES_PETTEAMS_INFO",
      format(L["PetTeamInfoExported"], numTeams));
  end

  -- Update the Pet Teams list
  L.petTeamsSort();
  L.petTeamsFilter(false);

  return
end

--
-- Function called when any of the menu items added to the pet team right-click
-- menu in Pet Battle Teams. It works out which menu item has been clicked and
-- acts accordingly.
--
local function petBattleTeamsMenuItemOnClick(self)
  -- Local Variables
  local teamIdx = PetBattleTeamsUnitFrameMenu.teamIndex;

  -- Process the menu item that has been clicked
  if (self.value == 1) then
    petBattleTeamsExport({[teamIdx] =
      PetBattleTeamsDB.namespaces.TeamManager.global.teams[teamIdx]});
  elseif (self.value == 2) then
    petBattleTeamsExport(PetBattleTeamsDB.namespaces.TeamManager.global.teams);
  end

  return; 
end

--
-- Function hooked into the function that displays the pet team right-click
-- menu in Pet Battles Teams. It adds 2 extra menu items to export the teams
-- to this addon
--
local function petBattleTeamsMenuOnShow()
  -- Local Variables
  local info;

  -- Add the title
  -- NOTE: Based on 'UnitPopupButtons["SUBSECTION_SEPARATOR"]' in UnitPopup.lua
  info = UIDropDownMenu_CreateInfo();
  info.dist             = 0;
  info.notCheckable     = true;
  info.isTitle          = true;
  info.isUninteractable = true;
  info.iconOnly         = true;
  info.icon             = "Interface\\Common\\UI-TooltipDivider-Transparent";
  info.iconInfo         =
  {
    tCoordLeft        = 0;
    tCoordRight       = 1;
    tCoordTop         = 0;
    tCoordBottom      = 1;
    tSizeX            = 0;
    tSizeY            = 8;
    tFitDropDownSizeX = true;
  };
  UIDropDownMenu_AddButton(info, 1);

  -- Add the title
  info = UIDropDownMenu_CreateInfo();
  info.text         = L["AddonName"];
  info.notCheckable = true;
  info.isTitle      = true;
  UIDropDownMenu_AddButton(info, 1);

  -- Add the 'Export' menu item
  info = UIDropDownMenu_CreateInfo();
  info.text         = L["Export"];
  info.notCheckable = true;
  info.value        = 1;
  info.func         = petBattleTeamsMenuItemOnClick;
  UIDropDownMenu_AddButton(info, 1);

  -- Add the 'Export All' menu item
  info.text  = L["Export All"];
  info.value = 2;
  UIDropDownMenu_AddButton(info, 1);

  return;
end

--
-- Function called when the tutorial button is clicked. It toggles the display
-- of the tutorial plates.
--
tutorialOnClick = function(self, mouseButton)
  -- Show/hide the tutorial plates
  if (not HelpPlate_IsShowing(tutorialPlateInfo)) then
    -- Show the tutorial plates
    HelpPlate_Show(tutorialPlateInfo, importExportFrame, self, true);

    -- Set the flag that indicates the tutorial has been seen
    NglPtDB.tutorialSeen = bit.bor(NglPtDB.tutorialSeen,
      importExportFrame.tutorialFlag);
  else
    HelpPlate_Hide(true);
  end

  return;
end

--
-- Function to import a Niggles Pet Team in version 1 format
--
local function version01Import(data, teamInfo)
  -- Local Variables
  local current;
  local dataLen = string.len(data);
  local dataPos;
  local petLevel;
  local petMaxHealth;
  local petPower;
  local petQuality;
  local petSpeciesId;
  local petSpeed;
  local teamPets = {{abilityId = {}}, {abilityId = {}}, {abilityId = {}}};

  -- Import the general info for the pet team
  dataPos, teamInfo.name, teamInfo.opponentId, teamInfo.iconPathId,
  teamInfo.editTime, teamInfo.editPatch, teamInfo.isHtml, teamInfo.strategy =
    dataUnpack(data, 1, dataLen, {"S", "I", "SI", "I", "S", "B", "S"});
  if (dataPos >= 0) then
    -- Convert the edit patch into a number
    teamInfo.editPatch = L.buildGetNumber(teamInfo.editPatch);
  else
    return false;
  end

  -- Post process any elements that require it
  teamInfo.isHtml = (teamInfo.isHtml == 1);

  -- Import the info for each pet in the pet team
  for petIdx = 1, L.MAX_ACTIVE_PETS do
    current = teamPets[petIdx];
    dataPos, current.speciesId, current.level, current.maxHealth,
      current.power, current.speed, current.quality, current.abilityId[1],
      current.abilityId[2], current.abilityId[3] = dataUnpack(data, dataPos,
        dataLen, {"I", "B", "O", "O", "O", "O", "O", "O", "O"});
    if (dataPos < 0) then
      return false;
    end
  end

  -- Try to find suitable pets in the pet journal for the pet team's pets
  if (not L.petReplaceAll(teamPets, teamInfo)) then
    return false;
  end

  return true;
end

--
-- Function to export a Niggles Pet Team in version 2 format
--
local function version02Export(teamInfo)
  -- Local Variables
  local _;
  local data = {};
  local petLevel;
  local petMaxHealth;
  local petPower;
  local petQuality;
  local petSpeciesId;
  local petSpeed;
  local petAbilityId;

  -- Pack the general data for the pet team
  data[#data+1] = dataPack(
    "S",  teamInfo.name,
    "I",  teamInfo.opponentId,
    "SI", teamInfo.iconPathId,
    "I",  teamInfo.editTime,
    "I",  teamInfo.editPatch,
    "B",  (teamInfo.isHtml and 1 or 0),
    "S",  teamInfo.strategy);
  if (data[1] == nil) then
    return nil;
  end

  -- Pack the data for each pet
  for petIdx = 1, L.MAX_ACTIVE_PETS do
    -- Get the pet's info
    if (teamInfo.pets[petIdx].guid ~= nil) then
      petSpeciesId, _, petLevel, _, petMaxHealth, petPower,
        petSpeed, petQuality = L.petGetInfo(teamInfo.pets[petIdx].guid);
      petAbilityId = teamInfo.pets[petIdx].abilityId;
    else
      petSpeciesId, _, petLevel, _, petMaxHealth, petPower,
        petSpeed, petQuality = 0, 0, 0, 0, 0, 0, 0, 0;
      petAbilityId = {0, 0, 0};
    end

    -- Pack the pet's info
    data[#data+1] = dataPack(
      "I", petSpeciesId,
      "B", petLevel,
      "O", petMaxHealth,
      "O", petPower,
      "O", petSpeed,
      "O", petQuality,
      "O", petAbilityId[1],
      "O", petAbilityId[2],
      "O", petAbilityId[3]);
    if (data[petIdx+1] == nil) then
      return nil;
    end
  end

  return table.concat(data);
end

--
-- Function to import a Niggles Pet Team in version 2 format
--
local function version02Import(data, teamInfo)
  -- Local Variables
  local current;
  local dataLen = string.len(data);
  local dataPos;
  local petLevel;
  local petMaxHealth;
  local petPower;
  local petQuality;
  local petSpeciesId;
  local petSpeed;
  local teamPets = {{abilityId = {}}, {abilityId = {}}, {abilityId = {}}};

  -- Import the general info for the pet team
  dataPos, teamInfo.name, teamInfo.opponentId, teamInfo.iconPathId,
  teamInfo.editTime, teamInfo.editPatch, teamInfo.isHtml, teamInfo.strategy =
    dataUnpack(data, 1, dataLen, {"S", "I", "SI", "I", "I", "B", "S"});
  if (dataPos < 0) then
    return false;
  end

  -- Post process any elements that require it
  teamInfo.isHtml = (teamInfo.isHtml == 1);

  -- Import the info for each pet in the pet team
  for petIdx = 1, L.MAX_ACTIVE_PETS do
    current = teamPets[petIdx];
    dataPos, current.speciesId, current.level, current.maxHealth,
      current.power, current.speed, current.quality, current.abilityId[1],
      current.abilityId[2], current.abilityId[3] = dataUnpack(data, dataPos,
        dataLen, {"I", "B", "O", "O", "O", "O", "O", "O", "O"});
    if (dataPos < 0) then
      return false;
    end
  end

  -- Try to find suitable pets in the pet journal for the pet team's pets
  if (not L.petReplaceAll(teamPets, teamInfo)) then
    return false;
  end

  return true;
end

-------------------------------------------------------------------------------
--                 A  D  D  O  N     F  U  N  C  T  I  O  N  S
-------------------------------------------------------------------------------

--
-- Function to hook into the Pet Battle Teams addon, if required
--
function L.petBattleTeamsHook()
  -- Check if the Pet Battle Teams unit frame exists
  if (PetBattleTeamsUnitFrame ~= nil) then
    -- Hook into the function used to display a right-click menu for pet teams
    hooksecurefunc(PetBattleTeamsUnitFrame, "ShowTeamOptionsMenu",
      petBattleTeamsMenuOnShow);
  end

  return;
end

--
-- Function to display the Import/Export frame in export mode for the specified
-- pet team.
--
function L.petTeamExport(teamInfo, parent)
  -- Local Variables
  local data = {"", "", "}"};
  local dataLen;

  -- Pack the pet team's info
  data[2] = version02Export(teamInfo);
  if (data[2] ~= nil) then
    -- Convert the binary data into base64url
    data[2] = base64urlEncode(data[2]);

    -- Add the header with size and checksum info
    data[1] = format("{%s%02X%04X%04X", DATA_MAGIC_NUMBER, DATA_VERSION,
      string.len(data[2]), fletcher16(data[2]));

    -- Display the encoded pet team in the Import/Export frame
    importExportShow(parent, false, string.gsub(table.concat(data),
      "(................................)", "%1\n"));
  else
    -- Display an error message
    StaticPopup_Show("NIGGLES_PETTEAMS_WARNING", L["PetTeamErrorExport"]);
  end

  return;
end

--
-- Function to display the Import/Export frame in import mode
--
function L.petTeamImport(teamInfo, parent)
  -- Display the Import/Export frame in import mode
  importExportShow(parent, true, teamInfo);

  return;
end

--
-- Function to hide the Import/Export frame
--
function L.petTeamImportExportHide()
  -- Hide the Import/Export frame, if required
  if (importExportFrame ~= nil) then
    importExportFrame:Hide();
  end

  return
end

-------------------------------------------------------------------------------
--                 L  O  C  A  L     V  A  R  I  A  B  L  E  S
-------------------------------------------------------------------------------

-- NOTE: The following tables must be declared before the functions that use
--       them but initialised after the functions in them have been defined.

dataTypeFunc =
{
  ["B"] = {dataByteIsType,   dataBytePack,   dataByteUnpack  },
  ["I"] = {dataUint32IsType, dataUint32Pack, dataUint32Unpack},
  ["O"] = {dataUint16IsType, dataUint16Pack, dataUint16Unpack},
  ["S"] = {dataStringIsType, dataStringPack, dataStringUnpack},
};

dataImportFunc =
{
  ["01"] = version01Import,
  ["02"] = version02Import,
};
