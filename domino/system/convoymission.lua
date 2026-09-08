
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Missions" Text="ConvoyMission"/>
--
-- <ControlIn  Name="Start"/>
-- <ControlIn  Name="Cancel"/>
-- <DataIn     Name="ConvoyEntity"  Type="Nomad|entity"/>
--
-- <ControlOut Name="Success"       Delayed="true"/>
-- <ControlOut Name="Failure"       Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

ConvoyMission = {
};

function ConvoyMission:Create(cbox)
	-- left empty on purpose
end

function ConvoyMission:Init(cbox)
	-- left empty on purpose
end

function ConvoyMission:ShutDown()
    self._type.UnregisterCallback(self);
end

function ConvoyMission:Start()
    if(self.ConvoyEntity) then
	    --System:Trace("StartConvoy "..self.ConvoyEntity);

	    self.callidSuccessfulConvoy = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.ConvoyEntity, self, "Event_Success", "SuccessfulConvoy");
	    self.callidFailedConvoy = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.ConvoyEntity, self, "Event_Failure", "FailedConvoy");
        CDominoManager_GetInstance():SendCommandEventToEntity(self.ConvoyEntity, "StartConvoy");
    end
end

function ConvoyMission:Cancel()
    if(self.ConvoyEntity) then
        if(self.callidSuccessfulConvoy) then
        	--System:Trace("CancelConvoy "..self.ConvoyEntity);
	        CDominoManager_GetInstance():SendCommandEventToEntity(self.ConvoyEntity, "CancelConvoy");
	    end
	end
end

function ConvoyMission:Event_Success(entity)
	self._type.UnregisterCallback(self);
	return self:Success();
end

function ConvoyMission:Event_Failure(entity)
	-- Update 3.3: Prevent convoy missions from "failing"
	self._type.UnregisterCallback(self);
	return self:Success();
	--return self:Failure();
end

function ConvoyMission:UnregisterCallback()
	if(self.ConvoyEntity) then
		cbSyst = CScriptCallbackSystem_GetInstance(); 
		if (self.callidSuccessfulConvoy ~= nil) then
			cbSyst:RemoveCallback(self.ConvoyEntity, self.callidSuccessfulConvoy);
			self.callidSuccessfulConvoy = nil;
		end
		if (self.callidFailedConvoy ~= nil) then
			cbSyst:RemoveCallback(self.ConvoyEntity, self.callidFailedConvoy);
			self.callidFailedConvoy = nil;
		end
	end
end


export = ConvoyMission;
ConvoyMission = nil;