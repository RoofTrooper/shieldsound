local playerGUID = UnitGUID("player")

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
  self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
  local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
  local spellId, spellName, spellSchool
  local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand

  if subevent == "SWING_DAMAGE" then
    amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
  elseif subevent == "SPELL_DAMAGE" then
    spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
  end

  if blocked and blocked > 0 and destGUID == playerGUID then
    PlaySoundFile("Interface\\AddOns\\ShieldSound\\sound.mp3", "Master")
  end
end
