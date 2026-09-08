
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Buddies" Text="SpawnPrimaryBuddy"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="SpawnPoint"   Type="Nomad|entity"/>
-- <DataIn     Name="Layer"        Type="Core|string"/>
-- <DataIn     Name="Unarmed"      Type="Core|bool"/>
--
-- <ControlOut Name="Out"          Delayed="true"/>
-- <ControlOut Name="BuddyReady"   Delayed="true"/>
-- <DataOut    Name="SpawnedBuddy" Type="Nomad|entity"/>
--
-- DOMINO REFLECTION BOX END

SpawnPrimaryBuddy = {
};

function SpawnPrimaryBuddy:Create(cbox)
	-- left empty on purpose
end

function SpawnPrimaryBuddy:Init(cbox)
	self.callidReadyToPosition = nil;
	self.callidSpawnBuddy = nil;
	self.Layer = "Main";
	self.Unarmed = 0;
end

function SpawnPrimaryBuddy:ShutDown()
	self._type.UnregisterCallback(self);
end

function SpawnPrimaryBuddy:UnregisterCallback()
	local instance = CScriptCallbackSystem_GetInstance();
	if (self.callidReadyToPosition ~= nil) then
		instance:RemoveCallback(self.SpawnedBuddy, self.callidReadyToPosition);
		self.callidReadyToPosition = nil;
	end
	if (self.callidSpawnBuddy ~= nil) then
		instance:RemoveCallback(self.SpawnedBuddy, self.callidSpawnBuddy);
		self.callidSpawnBuddy = nil;
	end
end

function SpawnPrimaryBuddy:In()
	if (self.Layer == nil) then
		-- default back to Main
		self.Layer = "Main";
	end
	if (self.Unarmed == nil) then
		-- default back to false
		self.Unarmed = 0;
	end
	if (self.SpawnPoint ~= nil) then
		self.SpawnedBuddy, exists = GetBuddiesManager():SpawnPrimaryBuddy(self.SpawnPoint, self.Layer, self.Unarmed);
		if (self.SpawnedBuddy ~= GetInvalidEntityId()) then
			-- Set the primary buddy global variable for the buddy kill listener script
			Globals.MASTER_GameGlobals.PrimaryBuddyEntityID = self.SpawnedBuddy;
			if (exists == 1) then
				local positioned, stillSpawned  = self._type.PositionBuddy(self);
		  		if (positioned == 1) then
		  			if (stillSpawned == 1) then
						--System:Trace("spawned and positioned..."..self.SpawnedBuddy);
		  				self:Out();
		  				self:BuddyReady();
		  				return;
		  			else
						--System:Trace("waiting for final positioning..."..self.SpawnedBuddy);
						self.callidSpawnBuddy = CScriptCallbackSystem_GetInstance():RegisterOnSpawnCallback(self.SpawnedBuddy, self, "Event_SpawnBuddy");
						return self:Out();
		  			end
				else
					--System:Trace("error1..."..self.SpawnedBuddy);
				end
			else
				--System:Trace("not spawned... waiting "..self.SpawnedBuddy);
				self.callidReadyToPosition = CScriptCallbackSystem_GetInstance():RegisterOnSpawnCallback(self.SpawnedBuddy, self, "Event_ReadyToPositon");
			end
		else
			System:Log("Invalid entity - primary buddy is unavailable");
			self.SpawnedBuddy = nil;
			return self:Out();
		end
	end
end

function SpawnPrimaryBuddy:Event_SpawnBuddy()
	if (self.callidSpawnBuddy ~= nil) then
		CScriptCallbackSystem_GetInstance():RemoveCallback(self.SpawnedBuddy, self.callidSpawnBuddy);
		self.callidSpawnBuddy = nil;
	end
	--System:Trace("spawned and positioned..."..self.SpawnedBuddy);
	return self:BuddyReady();
end

function SpawnPrimaryBuddy:Event_ReadyToPositon()
	if (self.callidReadyToPosition ~= nil) then
		CScriptCallbackSystem_GetInstance():RemoveCallback(self.SpawnedBuddy, self.callidReadyToPosition);
		self.callidReadyToPosition = nil;
	end
	--System:Trace("ready to position..."..self.SpawnedBuddy);
	local positioned, stillSpawned  = self._type.PositionBuddy(self);
	if (positioned == 1) then
		if (stillSpawned == 1) then
			--System:Trace("spawned and positioned..."..self.SpawnedBuddy);
			self:Out();
			self:BuddyReady();
			return;
		else
			--System:Trace("waiting for final spawning..."..self.SpawnedBuddy);
			self.callidSpawnBuddy = CScriptCallbackSystem_GetInstance():RegisterOnSpawnCallback(self.SpawnedBuddy, self, "Event_SpawnBuddy");
			return self:Out();
		end
	else
		--System:Trace("error2..."..self.SpawnedBuddy);
	end
end

function SpawnPrimaryBuddy:PositionBuddy()
	if (self.SpawnPoint ~= nil and self.SpawnedBuddy ~= nil) then
		return GetBuddiesManager():PositionSpawnedBuddy(self.SpawnedBuddy, self.SpawnPoint);
	end
	--System:Trace("BAD POSITION..."..self.SpawnedBuddy);
	return 0, 0;
end

export = SpawnPrimaryBuddy;
SpawnPrimaryBuddy = nil;
