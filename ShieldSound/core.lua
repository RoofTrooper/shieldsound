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
  
  if destGUID == playerGUID then 
    if (subevent == "SWING_MISSED") then 
      missType, isOffHand, amountMissed, critical = select(12,...)
    elseif (subevent == "RANGE_MISSED") or (subevent =="SPELL_MISSED") then
      spellId, spellName, critical, missType = select(12,...)  
    elseif subevent == "SWING_DAMAGE" then
      amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
    elseif (subevent == "SPELL_DAMAGE") or (subevent == "RANGE_DAMAGE") then
      spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
    end
      if (missType == "BLOCK") or (blocked and blocked > 0) then 
        PlaySoundFile("Interface\\AddOns\\ShieldSound\\sound.mp3", "Ambience")
      end
      missType, blocked = nil
  end
end
