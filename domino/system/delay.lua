Delay = {
}

function Delay:Create(cbox)
end

function Delay:Init(cbox)
	self.Trigger = nil;
	self.Trigger2 = nil;
	self.SplitTimer = 0;
	self.InitialSeconds = 0;
end

function Delay:ShutDown()
	if (self.Trigger ~= nil) then
		CDominoDelayManager_GetInstance():RemoveDelay(self.Trigger);
	end
end

function Delay:Start()
	-- Split timers are useful for any timer longer than an hour (current max is 2 hours)
	-- Remember to change the timer durations in the Restart() function too!

	self.SplitTimer = 0;

	if (self.Seconds == "Patrol") then
		self.Seconds = Globals.MASTER_GameGlobals.PatrolDelay;
	elseif (self.Seconds == "Outpost") then
		self.Seconds = Globals.MASTER_GameGlobals.OutpostDelay;
	elseif (self.Seconds == "Weapon") then
		self.Seconds = Globals.MASTER_GameGlobals.WeaponRespawnDelay;
	end

	if (self.Seconds == nil) or (self.Seconds <= 0) or (self.Seconds > 7200) then
		self.Seconds = 1;
	end

	-- Use split timers for any timer longer than an hour
	if (self.Seconds > 3600) then
		self.SplitTimer = 1;
	end

	self.InitialSeconds = self.Seconds;

	if (self.Trigger == nil) and (self.SplitTimer == 0) then
		System:Log("Delay: Starting a new timer with a duration of "..self.Seconds);
		self.Trigger = CDominoDelayManager_GetInstance():CreateDelay(self.Seconds, self, "Event_TimeElapsed");
	elseif (self.Trigger == nil) and (self.SplitTimer == 1) then
		System:Log("Delay: TwoTimers - First timer started");
		self.Trigger = CDominoDelayManager_GetInstance():CreateDelay(self.Seconds / 2, self, "Event_TimeElapsed_TwoTimers");
	else
		CDominoDelayManager_GetInstance():SetDelay(self.Trigger, self.Seconds);
	end

	if (self.Trigger ~= nil) then
		--System:Log("Delay: Starting existing timer with a duration of "..self.Seconds);
		CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "start");
	end

	return;
end

function Delay:Pause()
	if (self.Trigger ~= nil) then
		return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "pause");
	end
end

function Delay:Resume()
	if (self.Trigger ~= nil) then
		return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "resume");
	end
end

function Delay:Stop()
	if (self.Trigger ~= nil) then
		return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "stop");
	end
end

function Delay:Restart()
	self.SplitTimer = 0;

	if (self.Seconds == "Patrol") then
		self.Seconds = Globals.MASTER_GameGlobals.PatrolDelay;
	elseif (self.Seconds == "Outpost") then
		self.Seconds = Globals.MASTER_GameGlobals.OutpostDelay;
	elseif (self.Seconds == "Weapon") then
		self.Seconds = Globals.MASTER_GameGlobals.WeaponRespawnDelay;
	end

	if (self.Seconds > 3600) then
		self.SplitTimer = 1;
	end

	if (self.Trigger ~= nil) and (self.Seconds == self.InitialSeconds) then
		--System:Log("Delay: Restarting existing timer with a duration of "..self.Seconds);
		return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "restart");
	else
		-- Allow timer duration to be changed for existing timers without starting a new game
		System:Log("Delay: Existing timer duration changed to "..self.Seconds);
		if (self.SplitTimer == 0) then
			CDominoDelayManager_GetInstance():SetDelay(self.Trigger, self.Seconds);
			self.InitialSeconds = self.Seconds;
			return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "restart");
		elseif (self.SplitTimer == 1) then
			CDominoDelayManager_GetInstance():RemoveDelay(self.Trigger);
			self.Trigger = nil;
			self.Trigger = CDominoDelayManager_GetInstance():CreateDelay(self.Seconds / 2, self, "Event_TimeElapsed_TwoTimers");
			self.InitialSeconds = self.Seconds;
			return CDominoDelayManager_GetInstance():SendCommand(self.Trigger, "start");
		end
	end
end

function Delay:Event_TimeElapsed_TwoTimers()
	System:Log("Delay: TwoTimers - Secondary timer started");
	self.Trigger2 = CDominoDelayManager_GetInstance():CreateDelay(self.Seconds / 2, self, "Event_TimeElapsed_TwoTimers_Done");
	CDominoDelayManager_GetInstance():SendCommand(self.Trigger2, "start");
end

function Delay:Event_TimeElapsed_TwoTimers_Done()
	System:Log("Delay: TwoTimers - Secondary timer finished");
	CDominoDelayManager_GetInstance():RemoveDelay(self.Trigger2);
	self.Trigger2 = nil;
	return self:TimeElapsed();
end

function Delay:Event_TimeElapsed()
	return self:TimeElapsed();
end

export = Delay;
Delay = nil;