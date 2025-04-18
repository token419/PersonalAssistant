-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAL = PA.Loot
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PALProfileManager = PA.ProfileManager.PALoot

-- =====================================================================================================================

local isNoProfileSelected = PALProfileManager.isNoProfileSelected


local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PAL.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
    PAMF.setValue(PAL.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PALoot()
end

local function setValueAndRefreshScrollListVisible(value, ...)
    setValue(value, ...)
    PAL.ItemIcons.refreshScrollListVisible()
end

local function setValueAndRefreshScrollListVisibleAndEvents(value, ...)
    setValue(value, ...)
    PAL.ItemIcons.refreshScrollListVisible()
    PAEM.RefreshEventRegistration.PALoot()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabled(PAL.SavedVars, ...)
end

local function isDisabledAll(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabledAll(PAL.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PALoot       LootCompanionItems
---------------------------------
local function isPALootCompanionItemsMenuDisabled()
    if isDisabled({"LootEvents", "lootEventsEnabled"}) then return true end
    if getValue({"LootEvents", "LootCompanionItems", "qualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

local function isPALootIconsKnownUnknownMenuDisabled()
    if isDisabled({"ItemIcons", "itemIconsEnabled"}) then return true end
    if isDisabledAll({"ItemIcons", "Recipes", "showKnownIcon"}, {"ItemIcons", "Recipes", "showUnknownIcon"}) and
            isDisabledAll({"ItemIcons", "Motifs", "showKnownIcon"}, {"ItemIcons", "Motifs", "showUnknownIcon"}, {"ItemIcons", "StylePageContainers", "showKnownIcon"}, {"ItemIcons", "StylePageContainers", "showUnknownIcon"}) and
            isDisabledAll({"ItemIcons", "ApparelWeapons", "showKnownIcon"}, {"ItemIcons", "ApparelWeapons", "showUnknownIcon"}) then
        return true
    end
    return false
end

local function isPALootIconsSetCollectionMenuDisabled()
    if isDisabled({"ItemIcons", "itemIconsEnabled"}) then return true end
    if isDisabled({"ItemIcons", "SetCollection", "showUncollectedIcon"}) then return true end
    return false
end

local function isPALootIconsCompanionItemsMenuDisabled()
    if isDisabled({"ItemIcons", "itemIconsEnabled"}) then return true end
    if isDisabled({"ItemIcons", "CompanionItems", "showCompanionItemIcon"}) then return true end
    return false
end



--------------------------------------------------------------------------
-- PALoot       Autofillet
---------------------------------


local function isPALootAutoFilletMenuDisabled()
    if isDisabled({"LootEvents", "lootEventsEnabled"}) then return true end
    if getValue({"LootEvents", "Fishing", "AutoFillet"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end



-- =================================================================================================================

local PALootMenuFunctions = {
    getLootEventsEnabledSetting = function() return getValue({"LootEvents", "lootEventsEnabled"}) end,
    setLootEventsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"LootEvents", "lootEventsEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabledAll({"LootEvents", "lootEventsEnabled"}, {"LootEvents", "LootRecipes", "unknownRecipeMsg"}, {"LootEvents", "LootStyles", "autoLearnRecipe"}, {"LootEvents", "LootStyles", "autoMarkAsJunkRecipes"}) end,
    isUnknownRecipeMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue({"LootEvents", "LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(value, {"LootEvents", "LootRecipes", "unknownRecipeMsg"}) end,
	
	isAutoLearnRecipeDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnRecipeSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnRecipe"}) end,
    setAutoLearnRecipeSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnRecipe"}) end,
	
	isAutoLearnFurnishingPlanDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnFurnishingPlanSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnFurnishingPlan"}) end,
    setAutoLearnFurnishingPlanSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnFurnishingPlan"}) end,
	
	isAutoMarkAsJunkRecipeDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoMarkAsJunkRecipeSetting = function() return getValue({"LootEvents", "LootStyles", "autoMarkAsJunkRecipes"}) end,
    setAutoMarkAsJunkRecipeSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoMarkAsJunkRecipes"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootStylesMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) or isDisabledAll({"LootEvents", "LootStyles", "unknownMotifMsg"}, {"LootEvents", "LootStyles", "unknownStylePageMsg"}, {"LootEvents", "LootStyles", "autoLearnMotif"}, {"LootEvents", "LootStyles", "autoLearnStylePage"}) end,
    
	isUnknownMotifMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue({"LootEvents", "LootStyles", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "unknownMotifMsg"}) end,
   
    isUnknownStylePageMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownStylePageMsgSetting = function() return getValue({"LootEvents", "LootStyles", "unknownStylePageMsg"}) end,
    setUnknownStylePageMsgSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "unknownStylePageMsg"}) end,
	
	isAutoLearnMotifDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnMotifSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnMotif"}) end,
    setAutoLearnMotifSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnMotif"}) end,
	
	
	isAutoLearnStylePageDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnStylePageSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnStylePage"}) end,
    setAutoLearnStylePageSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnStylePage"}) end,
	
    -- ----------------------------------------------------------------------------------
    -- SCRIBING SCRIPTS & GRIMOIRES SETTINGS
    -- -----------------------------
    isLootScribingScriptsMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) or isDisabledAll({"LootEvents", "LootStyles", "unknownScribingScriptMsg"}, {"LootEvents", "LootStyles", "autoLearnScribingScript"}, {"LootEvents", "LootStyles", "autoLearnScribingGrimoire"}, {"LootEvents", "LootStyles", "autoMarkAsJunkScribingScript"}, {"LootEvents", "LootStyles", "autoMarkAsJunkScribingGrimoire"}) end,
    
	isUnknownScribingScriptsMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownScribingScriptsMsgSetting = function() return getValue({"LootEvents", "LootStyles", "unknownScribingScriptMsg"}) end,
    setUnknownScribingScriptsMsgSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "unknownScribingScriptMsg"}) end,
   
	isAutoLearnScribingScriptsDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnScribingScriptsSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnScribingScript"}) end,
    setAutoLearnScribingScriptsSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnScribingScript"}) end,
	
	isAutoLearnScribingGrimoiresDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoLearnScribingGrimoiresSetting = function() return getValue({"LootEvents", "LootStyles", "autoLearnScribingGrimoire"}) end,
    setAutoLearnScribingGrimoiresSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoLearnScribingGrimoire"}) end,
	
	isAutoMarkAsJunkScribingScriptsDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoMarkAsJunkScribingScriptsSetting = function() return getValue({"LootEvents", "LootStyles", "autoMarkAsJunkScribingScript"}) end,
    setAutoMarkAsJunkScribingScriptsSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoMarkAsJunkScribingScript"}) end,
	
	isAutoMarkAsJunkScribingGrimoiresDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoMarkAsJunkScribingGrimoiresSetting = function() return getValue({"LootEvents", "LootStyles", "autoMarkAsJunkScribingGrimoire"}) end,
    setAutoMarkAsJunkScribingGrimoiresSetting = function(value) setValue(value, {"LootEvents", "LootStyles", "autoMarkAsJunkScribingGrimoire"}) end,
	


    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) or isDisabledAll({"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}, {"LootEvents", "LootApparelWeapons", "uncollectedSetMsg"}, {"LootEvents", "LootApparelWeapons", "autoBind"}) end,
    isUnknownTraitMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue({"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(value, {"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}) end,

    isUncollectedSetMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUncollectedSetMsgSetting = function() return getValue({"LootEvents", "LootApparelWeapons", "uncollectedSetMsg"}) end,
    setUncollectedSetMsgSetting = function(value) setValue(value, {"LootEvents", "LootApparelWeapons", "uncollectedSetMsg"}) end,
	
    isAutoBindDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoBindSetting = function() return getValue({"LootEvents", "LootApparelWeapons", "autoBind"}) end,
    setAutoBindSetting = function(value) setValue(value, {"LootEvents", "LootApparelWeapons", "autoBind"}) end,

    -- ----------------------------------------------------------------------------------
    -- COMPANION ITEMS SETTINGS
    -- -----------------------------
    isLootCompanionItemsMenuDisabled = isPALootCompanionItemsMenuDisabled,
    isLootCompanionItemsQualityThresholdDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getLootCompanionItemsQualityThresholdSetting = function() return getValue({"LootEvents", "LootCompanionItems", "qualityThreshold"}) end,
    setLootCompanionItemsQualityThresholdSetting = function(value) setValue(value, {"LootEvents", "LootCompanionItems", "qualityThreshold"}) end,
	
    -- ----------------------------------------------------------------------------------
    -- AUTO FILLET SETTINGS
    -- -----------------------------
    isLootAutoFilletMenuDisabled = isPALootAutoFilletMenuDisabled,
    isAutoFilletDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoFilletSetting = function() return getValue({"LootEvents", "Fishing", "AutoFillet"}) end,
    setAutoFilletSetting = function(value) setValue(value, {"LootEvents", "Fishing", "AutoFillet"}) end,
	
    -- ----------------------------------------------------------------------------------
    -- AUTO COMBINE COLLECTIBLES
    -- -----------------------------
    isLootAutoCombineMenuDisabled = isPALootAutoCombineMenuDisabled,
    isAutoCombineDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getAutoCombineSetting = function() return getValue({"LootEvents", "Collectibles", "AutoCombine"}) end,
    setAutoCombineSetting = function(value) setValue(value, {"LootEvents", "Collectibles", "AutoCombine"}) end,

    -- ----------------------------------------------------------------------------------
	

    -- ----------------------------------------------------------------------------------

    isLowInventorySpaceWarningDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getLowInventorySpaceWarningSetting = function() return getValue({"InventorySpace", "lowInventorySpaceWarning"}) end,
    setLowInventorySpaceWarningSetting = function(value) setValue(value, {"InventorySpace", "lowInventorySpaceWarning"}) end,

    isLowInventorySpaceThresholdDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}, {"InventorySpace", "lowInventorySpaceWarning"}) end,
    getLowInventorySpaceThresholdSetting = function() return getValue({"InventorySpace", "lowInventorySpaceThreshold"}) end,
    setLowInventorySpaceThresholdSetting = function(value) setValue(value, {"InventorySpace", "lowInventorySpaceThreshold"}) end,

    -- ----------------------------------------------------------------------------------

    getItemIconsEnabledSetting = function() return getValue({"ItemIcons", "itemIconsEnabled"}) end,
    setItemIconsEnabledSetting = function(value) setValueAndRefreshScrollListVisibleAndEvents(value, {"ItemIcons", "itemIconsEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isMarkRecipesMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "Recipes", "showKnownIcon"}, {"ItemIcons", "Recipes", "showUnknownIcon"}) end,
    isMarkKnownRecipesDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownRecipesSetting = function() return getValue({"ItemIcons", "Recipes", "showKnownIcon"}) end,
    setMarkKnownRecipesSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Recipes", "showKnownIcon"}) end,

    isMarkUnknownRecipesDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownRecipesSetting = function() return getValue({"ItemIcons", "Recipes", "showUnknownIcon"})  end,
    setMarkUnknownRecipesSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Recipes", "showUnknownIcon"}) end,
	
    -- ----------------------------------------------------------------------------------
    -- SCRIBING SETTINGS
    -- -----------------------------
    isMarkScribingMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "Scribing", "showKnownIcon"}, {"ItemIcons", "Scribing", "showUnknownIcon"}) end,
    isMarkKnownScribingDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownScribingSetting = function() return getValue({"ItemIcons", "Scribing", "showKnownIcon"}) end,
    setMarkKnownScribingSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Scribing", "showKnownIcon"}) end,

    isMarkUnknownScribingDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownScribingSetting = function() return getValue({"ItemIcons", "Scribing", "showUnknownIcon"})  end,
    setMarkUnknownScribingSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Scribing", "showUnknownIcon"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS AND STYLE PAGE CONTAINERS SETTINGS
    -- -----------------------------
    isMarkMotifsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "Motifs", "showKnownIcon"}, {"ItemIcons", "Motifs", "showUnknownIcon"}, {"ItemIcons", "StylePageContainers", "showKnownIcon"}, {"ItemIcons", "StylePageContainers", "showUnknownIcon"}) end,
    isMarkKnownMotifsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownMotifsSetting = function() return getValue({"ItemIcons", "Motifs", "showKnownIcon"}) end,
    setMarkKnownMotifsSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Motifs", "showKnownIcon"}) end,

    isMarkUnknownMotifsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownMotifsSetting = function() return getValue({"ItemIcons", "Motifs", "showUnknownIcon"})  end,
    setMarkUnknownMotifsSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "Motifs", "showUnknownIcon"}) end,

    isMarkKnownStylePageContainersDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownStylePageContainersSetting = function() return getValue({"ItemIcons", "StylePageContainers", "showKnownIcon"})  end,
    setMarkKnownStylePageContainersSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "StylePageContainers", "showKnownIcon"}) end,

    isMarkUnknownStylePageContainersDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownStylePageContainersSetting = function() return getValue({"ItemIcons", "StylePageContainers", "showUnknownIcon"})  end,
    setMarkUnknownStylePageContainersSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "StylePageContainers", "showUnknownIcon"}) end,


    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isMarkApparelWeaponsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "ApparelWeapons", "showKnownIcon"}, {"ItemIcons", "ApparelWeapons", "showUnknownIcon"}, {"ItemIcons", "SetCollection", "showUncollectedIcon"}) end,
    isMarkKnownApparelWeaponsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownApparelWeaponsSetting = function() return getValue({"ItemIcons", "ApparelWeapons", "showKnownIcon"}) end,
    setMarkKnownApparelWeaponsSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "ApparelWeapons", "showKnownIcon"}) end,

    isMarkUnknownApparelWeaponsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownApparelWeaponsSetting = function() return getValue({"ItemIcons", "ApparelWeapons", "showUnknownIcon"})  end,
    setMarkUnknownApparelWeaponsSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "ApparelWeapons", "showUnknownIcon"}) end,

    isMarkUncollectedSetItemDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUncollectedSetItemSetting = function() return getValue({"ItemIcons", "SetCollection", "showUncollectedIcon"})  end,
    setMarkUncollectedSetItemSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "showUncollectedIcon"}) end,


    -- ----------------------------------------------------------------------------------
    -- COMPANION ITEMS SETTINGS
    -- -----------------------------
    isMarkCompanionItemsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "CompanionItems", "showCompanionItemIcon"}) end,
    isMarkCompanionItemDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkCompanionItemSetting = function() return getValue({"ItemIcons", "CompanionItems", "showCompanionItemIcon"})  end,
    setMarkCompanionItemSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "showCompanionItemIcon"}) end,


    -- ----------------------------------------------------------------------------------
    -- ITEM ICONS SETTINGS
    -- -----------------------------
    isIconsKnownUnknownMenuDisabled = isPALootIconsKnownUnknownMenuDisabled,
    isItemIconsDescriptionDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,

    isItemIconsSizeListDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsSizeListSetting = function() return getValue({"ItemIcons", "iconSizeList"}) end,
    setItemIconsSizeListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconSizeList"}) end,

    isItemIconsSizeGridDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsSizeGridSetting = function() return getValue({"ItemIcons", "iconSizeGrid"}) end,
    setItemIconsSizeGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconSizeGrid"}) end,

    isItemIconsXOffsetListDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsXOffsetListSetting = function() return getValue({"ItemIcons", "iconXOffsetList"}) end,
    setItemIconsXOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconXOffsetList"}) end,

    isItemIconsYOffsetListDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsYOffsetListSetting = function() return getValue({"ItemIcons", "iconYOffsetList"}) end,
    setItemIconsYOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconYOffsetList"}) end,

    isItemIconsXOffsetGridDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsXOffsetGridSetting = function() return getValue({"ItemIcons", "iconXOffsetGrid"}) end,
    setItemIconsXOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconXOffsetGrid"}) end,

    isItemIconsYOffsetGridDisabled = isPALootIconsKnownUnknownMenuDisabled,
    getItemIconsYOffsetGridSetting = function() return getValue({"ItemIcons", "iconYOffsetGrid"}) end,
    setItemIconsYOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconYOffsetGrid"}) end,

    -- ----------------------------------------------------------------------------------

    isIconsSetCollectionMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabled({"ItemIcons", "SetCollection", "showUncollectedIcon"}) end,

    isItemIconsSetCollectionSizeListDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionSizeListSetting = function() return getValue({"ItemIcons", "SetCollection", "iconSizeList"}) end,
    setItemIconsSetCollectionSizeListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconSizeList"}) end,

    isItemIconsSetCollectionSizeGridDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionSizeGridSetting = function() return getValue({"ItemIcons", "SetCollection", "iconSizeGrid"}) end,
    setItemIconsSetCollectionSizeGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconSizeGrid"}) end,

    isItemIconsSetCollectionXOffsetListDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionXOffsetListSetting = function() return getValue({"ItemIcons", "SetCollection", "iconXOffsetList"}) end,
    setItemIconsSetCollectionXOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconXOffsetList"}) end,

    isItemIconsSetCollectionYOffsetListDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionYOffsetListSetting = function() return getValue({"ItemIcons", "SetCollection", "iconYOffsetList"}) end,
    setItemIconsSetCollectionYOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconYOffsetList"}) end,

    isItemIconsSetCollectionXOffsetGridDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionXOffsetGridSetting = function() return getValue({"ItemIcons", "SetCollection", "iconXOffsetGrid"}) end,
    setItemIconsSetCollectionXOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconXOffsetGrid"}) end,

    isItemIconsSetCollectionYOffsetGridDisabled = isPALootIconsSetCollectionMenuDisabled,
    getItemIconsSetCollectionYOffsetGridSetting = function() return getValue({"ItemIcons", "SetCollection", "iconYOffsetGrid"}) end,
    setItemIconsSetCollectionYOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "SetCollection", "iconYOffsetGrid"}) end,

    -- ----------------------------------------------------------------------------------

    isIconsCompanionItemsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabled({"ItemIcons", "CompanionItems", "showCompanionItemIcon"}) end,

    isItemIconsCompanionItemsSizeListDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsSizeListSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconSizeList"}) end,
    setItemIconsCompanionItemsSizeListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconSizeList"}) end,

    isItemIconsCompanionItemsSizeGridDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsSizeGridSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconSizeGrid"}) end,
    setItemIconsCompanionItemsSizeGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconSizeGrid"}) end,

    isItemIconsCompanionItemsXOffsetListDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsXOffsetListSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconXOffsetList"}) end,
    setItemIconsCompanionItemsXOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconXOffsetList"}) end,

    isItemIconsCompanionItemsYOffsetListDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsYOffsetListSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconYOffsetList"}) end,
    setItemIconsCompanionItemsYOffsetListSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconYOffsetList"}) end,

    isItemIconsCompanionItemsXOffsetGridDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsXOffsetGridSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconXOffsetGrid"}) end,
    setItemIconsCompanionItemsXOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconXOffsetGrid"}) end,

    isItemIconsCompanionItemsYOffsetGridDisabled = isPALootIconsCompanionItemsMenuDisabled,
    getItemIconsCompanionItemsYOffsetGridSetting = function() return getValue({"ItemIcons", "CompanionItems", "iconYOffsetGrid"}) end,
    setItemIconsCompanionItemsYOffsetGridSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "CompanionItems", "iconYOffsetGrid"}) end,

    -- ----------------------------------------------------------------------------------

    isItemIconsTooltipShownDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsTooltipShownSetting = function() return getValue({"ItemIcons", "iconTooltipShown"}) end,
    setItemIconsTooltipShownSetting = function(value) setValueAndRefreshScrollListVisible(value, {"ItemIcons", "iconTooltipShown"}) end,

    -- ----------------------------------------------------------------------------------

    isSilentModeDisabled = function() return isDisabledAll({"LootEvents", "lootEventsEnabled"}, {"ItemIcons", "itemIconsEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- =====================================================================================================================
-- Export
PAMF.PALoot = PALootMenuFunctions