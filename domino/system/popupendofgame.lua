PopUpEndOfGameBox = {
};

function PopUpEndOfGameBox:Create(cbox)
end

function PopUpEndOfGameBox:Init(cbox)
end

function PopUpEndOfGameBox:ShutDown()
end

function PopUpEndOfGameBox:In()
	PopUpEndOfGame();
	-- Update 3.6: Disable return to free-roam to allow the ending scene to play out
	--CGameMessageBoxHelper_GetInstance():CreateTutorialMessageBox("None", "END_MESSAGE", "BUTTON_CONTINUE", self, "PlayerContinue");
	return self:Out();
end

function PopUpEndOfGameBox:PlayerContinue()
	-- Disable final mission objective markers
	CDominoManager_GetInstance():SendRegisteredEventToEntity("2055420779952101532", "CMapElementComponent_Disable");
	CDominoManager_GetInstance():SendRegisteredEventToEntity("2055420768501651610", "CMapElementComponent_Disable");

	-- Revert ending cutscene stuff
	RemoveScriptedSceneParticipant("2057093875425625654", GetLocalPlayerId());
	RemoveScriptedSceneParticipant("2056648033241679207", GetLocalPlayerId());
	SwitchCamera(0, "0");
	UnBind(GetLocalPlayerId(), "2057295922242520304");
	SetCinematicUIMode(1);
	StopSoundMixingFromLua("Exclusive.ENDING");
	SetVisibility(GetLocalPlayerId(), 1);
	CDominoManager_GetInstance():SendCommandEventToEntity(GetLocalPlayerId(), "SetWeaponSafeMode", "false");
	SetPlayerActionMap("default");

	-- Restore all deceased buddies
	--GetBuddiesManager():BypassSetBuddyLifeState("Marty_Alencar", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Flora_Guillen", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Warren_Clyde", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Josip_Idromeno", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Paul_Ferenc", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Quarbani_Singh", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Michele_Dachss", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Nasreen_Davar", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Andre_Hyppolite", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Hakim_Echebbi", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Frank_Bilders", 0);
	--GetBuddiesManager():BypassSetBuddyLifeState("Xianyong_Bai", 0);

	-- Update 3.4: Disable malaria after finishing the game
	SetSicknessLevel(0);

	Globals.MASTER_GameGlobals.FinalStoryMissionCompleted = 1;

	TeleportEntity(GetLocalPlayerId(), SpawnEntityFromArchetype("Domino.Buddies.SpawnPointBuddy", 2615.00, 2516.60, 23.67, 0, 0, 0));
end

export = PopUpEndOfGameBox;
PopUpEndOfGameBox = nil;