local frame = CreateFrame("FRAME", "FooAddonFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
frame:RegisterEvent("COMBAT_TEXT_UPDATE");
frame:RegisterEvent("UNIT_COMBAT");

local function eventHandler(self, event, ...)

-- print("Hello World! Hello " .. event);

  local timestamp, type, hideCaster,                                                                      -- arg1  to arg3
      sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,   -- arg4  to arg11
      spellId, spellName, spellSchool,                                                                      -- arg12 to arg14
      amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = ...             -- arg15 to arg23

  --[[
    * Note, for this example, you could just use 'local type = select(2, ...)'.  The others are included
      so that it's clear what's available.
    * You can also lump all of the arguments into one block (or one really long line):

    local timestamp, type, hideCaster,                                                                      -- arg1  to arg3
      sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,   -- arg4  to arg11
      spellId, spellName, spellSchool,                                                                      -- arg12 to arg14
      amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = ...             -- arg15 to arg23
  ]]

  if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
    if (type == "SWING_DAMAGE") then
    	 amount,
        overkill,
        school,
        resisted,
        blocked,
        absorbed,
        critical,
        glancing,
        crushing
                = select(12, ...)
      if (blocked>0) then -- "== 1" for clarity only.  Not needed.
       -- PlaySoundFile("Sound\\Item\\Weapons\\Shields\\WoodenShieldBlock3.OGG","Master")
        PlaySoundFile("Interface\\AddOns\\ShieldSound\\sound.mp3", "Master")
  end
end
end
end

frame:SetScript("OnEvent", eventHandler);