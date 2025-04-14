-- Local instances of Global tables --

 local LCK = LibCharacterKnowledge
 local PA = PersonalAssistant


-- ---------------------------------------------------------------------------------------------------------------------

local function _GetCharacter(name)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    for _,v in ipairs(LCK.GetCharacterList()) do
        if v.name == name then
            return v
        end
    end
	return "none"
end


-- ---------------------------------------------------------------------------------------------------------------------

local function GetCharacterNames()
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    local characterNames = {}
    for _,v in ipairs(LCK.GetCharacterList()) do
        table.insert(characterNames, v.name)
    end
    return characterNames
end

local function IsInstalled()
    return LibCharacterKnowledge
end

local function IsEnabled()
    if PA == nil then PA = PersonalAssistant end -- workaround 08/06/2023
	if PA and PA.Integration and PA.Integration.SavedVars and PA.Integration.SavedVars.CharacterKnowledge and PA.Integration.SavedVars.CharacterKnowledge.enabled then
        return true
	else
        return false
	end
end

local function IsKnown(itemLink)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022

     local characters = LCK.GetItemKnowledgeList(itemLink)
     local inList = false
     local known = false

     for i, character in ipairs(characters) do

         local knowledge = LCK.GetItemKnowledgeForCharacter(itemLink, nil, character.id)

         -- Fail fast if it's us
         if character.name == GetUnitName("player") then
             inList = true
             if knowledge == LCK.KNOWLEDGE_KNOWN then known = true end
             break
         end

         if knowledge == LCK.KNOWLEDGE_UNKNOWN then
             known = true
             break
         end
     end

     if inList == false then return true end
     return known

end

 local function IsAllKnown(itemLink)
     if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022

     local characters = LCK.GetItemKnowledgeList(itemLink)
     local known = true

     for i, character in ipairs(characters) do

         local knowledge = LCK.GetItemKnowledgeForCharacter(itemLink, nil, character.id)

         if knowledge == LCK.KNOWLEDGE_UNKNOWN then
             known = false
             break
         end
    end
    return known
end

local function RegisterForInitializationCallback(executableFunction)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    LCK.RegisterForCallback(PA.Integration.AddonName, LCK.EVENT_INITIALIZED, executableFunction)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export

PA.Libs = PA.Libs or {}
PA.Libs.CharacterKnowledge = {
    GetCharacterNames = GetCharacterNames,
    IsInstalled = IsInstalled,
    IsEnabled = IsEnabled,
    IsKnown = IsKnown,
	IsAllKnown = IsAllKnown,
    RegisterForInitializationCallback = RegisterForInitializationCallback
}