AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

numPlys = 0
targets = {}

function GM:Initialize()
  self.BaseClass:Initialize(self)
  
  timer.Create("Warmup", 10, 1, function() DoRoundStart() end)
end

function GM:Think()
end

function GM:PlayerConnect(ply, adress)
end

--
-- Player Death
-- ply - dying player, wep - entity used to kill, atk - killing player
--
function GM:PlayerDeath(ply, wep, atk)
  
  print("["..PlayerID(atk).."]["..atk:Nick().."] killed ["..PlayerID(ply).."]["..ply:Nick().."]") -- Print kill
  
  -- Check if the dying player was the killing players target
  if (PlayerTarget(atk) == ply) then
    print("It was their target!")
    SetPlayerTarget(atk, PlayerTarget(ply)) -- Give the dying players target to the killing player
    RemovePlayer(ply) -- Remove the dying player from the table.
  else
    print("It was not their target!")
    SetPlayerTarget(GetPlayerTargetedBy(ply), PlayerTarget(ply)) -- Give the dying players target to the player targeting the dying player
    RemovePlayer(ply) -- Remove the dying player from table.
  end
  
  if (table.Count(targets) == 1) then
    print("["..Player(atk).."]["..atk:Nick().."] is the last man standing!") -- Print last standing player
  else
    print("New Targets:")
    PrintTargets()
  end
end

function DoRoundStart()
  numPlys = team.NumPlayers(0)
  targets = AssignTargets()
  
  print("Initial Targets:")
  PrintTargets()
end

function AssignTargets()
  local plys = team.GetPlayers(0)
  local targs = team.GetPlayers(0)
  local rng = math.random(numPlys)
  local result = {}
  
  for i = 1, numPlys, 1 do
    table.Add(result, {[i] = {Player = plys[i], Target = targs[rng]}})
  end
  
  return result
end

function PrintTargets()
  PrintTable(targets)
end

function PlayerID (pl)
  local result = nil
  
  if (table.HasValue(team.GetPlayers(0), pl)) then
    result = table.KeyFromValue(team.GetPlayers(0), pl)
  end
  
  return result
end

function SetPlayerTarget(pl, targ)
  local id = PlayerID(pl)
  
  if (targets[id] ~= nil) then
    targets[id].Target = targ
  end
end

function PlayerTarget(pl)
  local id = PlayerID(pl)
  
  if (targets[id] ~= nil) then
    return targets[id].Target
  end
end

function GetPlayerTargetedBy(pl)
  if (table.HasValue(targets, pl)) then
    return table.KeyFromValue(targets, pl)
  end
end

function PlayerHasTarget(pl)
  if table.HasValue(targets, pl) then
    return true
  else
    return false
  end
end

function RemovePlayer(pl)
  local id = PlayerID(pl)
  
  if (targets[id] ~= nil) then
    targets[id] = nil
  end
end

concommand.Add("lsm_target", function(ply, cmd, args, str)
  print(PlayerTarget(ply):Nick())
end)
concommand.Add("lsm_round_new", function(ply, cmd, args, str)
  DoRoundStart()
end)
concommand.Add("lsm_newtargets", function(ply, cmd, args, str)
  targets = AssignTargets()
  print("New Targets:")
  PrintTargets()
end)
concommand.Add("lsm_printtargets", function(ply, cmd, args, str)
  print("Current Targets:")
  PrintTargets()
end)