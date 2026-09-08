
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Player Avatar" Text="PhoneCall"/>
--
-- <ControlIn  Name="In"/>
-- <ControlIn  Name="Disable"/>
--
-- <DataIn     Name="PhonecallSound"  Type="Nomad|Sound"/>
--
-- <ControlOut Name="Out"/>
-- <ControlOut Name="CallTimeout"     Delayed="true"/>
-- <ControlOut Name="CallPicked"      Delayed="true"/>
-- <ControlOut Name="HangUpCall"      Delayed="true"/>
-- <ControlOut Name="VoiceFinished"   Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PhoneCallBox = {
};

function PhoneCallBox:Create(cbox)
	-- left empty on purpose
end

function PhoneCallBox:Init(cbox)
	self.callHungUp = 0;
	self.PhoneCallInstance = nil;
	self.PhonecallSound = nil;
	self.PhoneCallPlaying = 0;
	self.timerDelay = 1.35;
	self.callidCallPicked = nil;
	self.callidVoiceFinished = nil;
	self.callidCallTimeout = nil;
	self.callidHangUpCall = nil;
end

function PhoneCallBox:ShutDown()
  self._type.UnregisterCallback(self);
end

function PhoneCallBox:In()
	Globals.MASTER_GameGlobals.PhoneCallInstance = Globals.MASTER_GameGlobals.PhoneCallInstance + 1;
	self.PhoneCallInstance = Globals.MASTER_GameGlobals.PhoneCallInstance;
	self.callHungUp = 0;
	if (self.PhonecallSound ~= nil) then
		local cbSyst = CScriptCallbackSystem_GetInstance();
		local playerId = GetLocalPlayerId();
		if (self.callidCallPicked == nil) then
			self.callidCallPicked = cbSyst:RegisterEventCallback(playerId, self, "Event_CallPicked", "call_picked");
		end
		if (self.callidVoiceFinished == nil) then
			self.callidVoiceFinished = cbSyst:RegisterEventCallback(playerId, self, "Event_VoiceFinished", "voice_finished");
		end
		if (self.callidCallTimeout == nil) then
			self.callidCallTimeout = cbSyst:RegisterEventCallback(playerId, self, "Event_CallTimeout", "call_timeout");
		end
		if (self.callidHangUpCall == nil) then
			self.callidHangUpCall = cbSyst:RegisterEventCallback(playerId, self, "Event_HangUpCall", "hangup_call");
		end
		if (self.PhoneCallPlaying == 0) then
			PhoneCall(self.PhonecallSound);
			self.PhoneCallPlaying = 1;
		end
		return self:Out();
	end
end

function PhoneCallBox:Disable()
  self._type.UnregisterCallback(self);
end

function PhoneCallBox:Event_CallPicked()
	if(self.Timer == nil) then
		self.Timer = CDominoDelayManager_GetInstance():CreateDelay(self.timerDelay, self, "TimerDone");
		if (self.Timer ~= nil) then
			CDominoDelayManager_GetInstance():SendCommand(self.Timer, "start");
		end
	else
		CDominoDelayManager_GetInstance():SendCommand(self.Timer, "restart");
	end
	return self:CallPicked();
end

function PhoneCallBox:TimerDone()
	CDominoDelayManager_GetInstance():RemoveDelay(self.Timer);
	self.Timer = nil;
	if (self.PhoneCallInstance == Globals.MASTER_GameGlobals.PhoneCallInstance) then
		StartSoundMixingFromLua("Exclusive.Phone_Call");
		CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), self.PhonecallSound, 6, self, "Callback_Sound");
	end
end

function PhoneCallBox:HolsterPhoneDone()
	CDominoDelayManager_GetInstance():RemoveDelay(self.HolsterTimer);
	self.HolsterTimer = nil;
	self.PhonecallSound = nil;
	self.PhoneCallPlaying = 0;
	PopPlayerActionMap("watch_custom"); -- Pop watch actionmap just in case the player pulled it out at the wrong time
	HolsterWeapon();
	DrawWeapon();
	PopPlayerActionMap("watch_custom");
end

function PhoneCallBox:Callback_Sound(reason)
	if (reason == "finished") then
		StopSoundMixingFromLua("Exclusive.Phone_Call");
		if (self.callHungUp == 0) then
			PopPlayerActionMap("watch_custom"); -- Pop watch actionmap just in case the player pulled it out at the wrong time
			PlayAnimSimpleObject(GetLocalPlayerId(), "pawn_generic_holster", 0);
			PopPlayerActionMap("watch_custom");

			if (self.HolsterTimer == nil) then
				self.HolsterTimer = CDominoDelayManager_GetInstance():CreateDelay(1.50, self, "HolsterPhoneDone");
				if (self.HolsterTimer ~= nil) then
					CDominoDelayManager_GetInstance():SendCommand(self.HolsterTimer, "start");
				end
			else
				CDominoDelayManager_GetInstance():SendCommand(self.HolsterTimer, "restart");
			end
		else
			self.PhonecallSound = nil;
			self.PhoneCallPlaying = 0;
		end
	end
end

function PhoneCallBox:Event_VoiceFinished()
	return self:VoiceFinished();
end

function PhoneCallBox:Event_CallTimeout()
	return self:CallTimeout();
end

function PhoneCallBox:Event_HangUpCall()
	self.callHungUp = 1;
	--StopSoundMixingFromLua("Exclusive.Phone_Call");
	return self:HangUpCall();
end

function PhoneCallBox:UnregisterCallback()
	if (self.callidCallPicked ~= nil) then
		--System:Trace("Disabling the phone call listener");
		local playerId = GetLocalPlayerId();
		local cbSyst = CScriptCallbackSystem_GetInstance();
		if (self.callidCallPicked ~= nil) then
			cbSyst:RemoveCallback(playerId, self.callidCallPicked);
			self.callidCallPicked = nil;
		end
		if (self.callidVoiceFinished ~= nil) then
			cbSyst:RemoveCallback(playerId, self.callidVoiceFinished);
			self.callidVoiceFinished = nil;
		end
		if (self.callidCallTimeout ~= nil) then
			cbSyst:RemoveCallback(playerId, self.callidCallTimeout);
			self.callidCallTimeout = nil;
		end
		if (self.callidHangUpCall ~= nil) then
			cbSyst:RemoveCallback(playerId, self.callidHangUpCall);
			self.callidHangUpCall = nil;
		end
	end
end

export = PhoneCallBox;
PhoneCallBox = nil;
