
-- DOMINO REFLECTION BOX START
--
-- <Display Category="DLC" Text="DLC1WeaponsSpawn"/>
--
-- <ControlIn  Name="In"/>
-- <ControlOut Name="Out"          Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

DLC1WeaponsSpawn = {
};

function DLC1WeaponsSpawn:Create(cbox)
  -- left empty on purpose
end

function DLC1WeaponsSpawn:Init(cbox)
  self.ParentEntity = cbox:GetParentEntity();
end

function DLC1WeaponsSpawn:ShutDown()
end

function DLC1WeaponsSpawn:UnregisterCallback()
end

function DLC1WeaponsSpawn:In()

  local crate = "DLC1Weapons.DLC1.WeaponCrate";
  local crossbow = "DLC1Weapons.DLC1.Pickup_Crossbow";
  local silencedShotgun = "DLC1Weapons.DLC1.Pickup_SilencedShotgun";
  local sawedOffShotgun = "DLC1Weapons.DLC1.Pickup_SawedOffShotgun";
  
  if (self.ParentEntity == "2058084353816150950") then
    -- W1B2
    System:Trace("DLC1WeaponsSpawn 2058084353816150950");
    SpawnEntityFromArchetype(crate, 1275.58, 3108.97, 28.7483, 0, 0, -72);
    --SpawnEntityFromArchetype(crossbow, 1275.37, 3109.14, 29.4587, -13.11, 76.6642, 1.227);
    --SpawnEntityFromArchetype(silencedShotgun, 1275.81, 3108.82, 29.4255, 9.4652, -73.9177, 9.8383);
    --SpawnEntityFromArchetype(sawedOffShotgun, 1275.84, 3108.57, 29.4285, -2.9236, 54.9809, 141.695);
  else 
    if(self.ParentEntity == "2058085501430141572") then
      -- W1B3
      System:Trace("DLC1WeaponsSpawn 2058085501430141572");
      SpawnEntityFromArchetype(crate, 2974.02, 3830.91, 20.6525, 0, 0, 40);
      --SpawnEntityFromArchetype(crossbow, 2973.94, 3830.66, 21.3629, -13.11, 76.6642, 113.227);
      --SpawnEntityFromArchetype(silencedShotgun, 2974.08, 3831.19, 21.3297, 9.4652, -73.9177, 121.838);
      --SpawnEntityFromArchetype(sawedOffShotgun, 2974.3, 3831.31, 21.3327, -2.9236, 54.9809, -106.305);
    else 
      if (self.ParentEntity == "2058084692818659353") then
        -- W1C3
        System:Trace("DLC1WeaponsSpawn 2058084692818659353");
        SpawnEntityFromArchetype(crate, 2629.74, 2099.04, 18.4063, 0, 0, 16);
        --SpawnEntityFromArchetype(crossbow, 2629.56,2098.84,19.1167, 346.89, 76.6642, 89.227);
        --SpawnEntityFromArchetype(silencedShotgun, 2629.9, 2099.27, 19.0835, 9.4652, 286.0823, 97.8383);
        --SpawnEntityFromArchetype(sawedOffShotgun, 2630.15,2099.29, 19.0865, 357.0764, 54.9809, 229.695);
      else 
        if (self.ParentEntity == "2058084431406569589") then
          -- W1C4
          System:Trace("DLC1WeaponsSpawn 2058084431406569589");
          SpawnEntityFromArchetype(crate, 3695.11, 2127.29, 55.5141, 0, 0, 135);
          --SpawnEntityFromArchetype(crossbow, 3695.37, 2127.23, 56.2245, -13.11, 76.6642, -151.773);
          --SpawnEntityFromArchetype(silencedShotgun, 3694.83, 2127.32, 56.1913, 9.4652, -73.9177, -143.162);
          --SpawnEntityFromArchetype(sawedOffShotgun, 3694.69, 2127.53, 56.1943, -2.9236, 54.9809, -11.305);
        else 
          if (self.ParentEntity == "2058084284383634095") then
            -- W1D2
            System:Trace("DLC1WeaponsSpawn 2058084284383634095");
            SpawnEntityFromArchetype(crate, 1241.39, 1246.92, 20.8941, 0, 0, -21);
            --SpawnEntityFromArchetype(crossbow, 1241.13, 1246.86, 21.6045, -13.11, 76.6642, 52.227);
            --SpawnEntityFromArchetype(silencedShotgun, 1241.66, 1247, 21.5713, 9.4652, -73.9177, 60.8383);
            --SpawnEntityFromArchetype(sawedOffShotgun, 1241.87, 1246.87, 21.5743, -2.9236, 54.9809, -167.305);
          else 
            if (self.ParentEntity == "2058084721459471280") then
              -- W2B2
              System:Trace("DLC1WeaponsSpawn 2058084721459471280");
              SpawnEntityFromArchetype(crate, 1186.69, 3836.58, 20.4364, 0, 0, 12);
              --SpawnEntityFromArchetype(crossbow, 1186.5, 3836.39, 21.1468, -13.11, 76.6642, 85.2271);
              --SpawnEntityFromArchetype(silencedShotgun, 1186.87, 3836.8, 21.1136, 9.4652, -73.9177, 93.8383);
              --SpawnEntityFromArchetype(sawedOffShotgun, 1187.12, 3836.8, 21.1166, -2.9236, 54.9809, -134.305);
            else 
              if (self.ParentEntity == "2058084287489514158") then
                -- W2B4
                System:Trace("DLC1WeaponsSpawn 2058084287489514158");
                SpawnEntityFromArchetype(crate, 3304.33, 3725.44, 31.5362, 0, 0, -177);
                --SpawnEntityFromArchetype(crossbow, 3304.55, 3725.6, 32.2466, -13.11, 76.6642, -103.773);
                --SpawnEntityFromArchetype(silencedShotgun, 3304.12, 3725.26, 32.2134, 9.4652, -73.9177, -95.1617);
                --SpawnEntityFromArchetype(sawedOffShotgun, 3303.87, 3725.29, 32.2164, -2.9236, 54.9809, 36.695);
              else 
                if (self.ParentEntity == "2058084264297115465") then
                  -- W2C3
                  System:Trace("DLC1WeaponsSpawn 2058084264297115465");
                  SpawnEntityFromArchetype(crate, 2932.64, 2808.07, 20.5938, 0, 0, 178);
                  --SpawnEntityFromArchetype(crossbow, 2932.87, 2808.2, 21.3042, -13.11, 76.6642, -108.773);
                  --SpawnEntityFromArchetype(silencedShotgun,2932.42, 2807.9, 21.271, 9.4652, -73.9177, -100.162);
                  --SpawnEntityFromArchetype(sawedOffShotgun, 2932.17, 2807.95, 21.274, -2.9236, 54.9809, 31.695);
                else 
                  if (self.ParentEntity == "2058084586369332774") then
                    -- W2D2
                    System:Trace("DLC1WeaponsSpawn 2058084586369332774");
                    SpawnEntityFromArchetype(crate, 1241.15, 1758.46, 44.6475, 0, 0, -33);
                    --SpawnEntityFromArchetype(crossbow, 1240.89, 1758.46, 45.3579, -13.11, 76.6642, 40.227);
                    --SpawnEntityFromArchetype(silencedShotgun, 1241.43, 1758.49, 45.3247, 9.4652, -73.9177, 48.8383);
                    --SpawnEntityFromArchetype(sawedOffShotgun, 1241.61, 1758.31, 45.3277, -2.9236, 54.9809, -179.305);
                  else 
                    if (self.ParentEntity == "2058084398540005602") then
                      -- W2D4
                      System:Trace("DLC1WeaponsSpawn 2058084398540005602");
                      SpawnEntityFromArchetype(crate, 3302.53, 1545.03, 18.5746, 0, 0, -84);
                      --SpawnEntityFromArchetype(crossbow, 3302.36, 1545.24, 19.285, -13.11, 76.6642, -10.773);
                      --SpawnEntityFromArchetype(silencedShotgun, 3302.72, 1544.83, 19.2518, 9.4652, -73.9177, -2.1617);
                      --SpawnEntityFromArchetype(sawedOffShotgun, 3302.7, 1544.58, 19.2548, -2.9236, 54.9809, 129.695);
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end


export = DLC1WeaponsSpawn;
DLC1WeaponsSpawn = nil;

