AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

timeWarmUp = 10 -- How long the warm up stage is (in seconds)

numPlys = 0 -- Number of valid players
targets = {} -- Table holding all players and their targets

function GM:Initialize()
  self.BaseClass:Initialize(self)
  
  timer.Create("Warm up", timeWarmUp, 1, function() DoRoundStart() end) -- Start warm up sequence
end

function GM:Think()
end

function GM:PlayerConnect(ply, adress)
end

--
-- Player Death - Runs when a player dies
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
    -- SetPlayerTarget(GetPlayerTargetedBy(ply), PlayerTarget(ply)) -- Give the dying players target to the player targeting the dying player
    RemovePlayer(ply) -- Remove the dying player from table.
  end
  
  if (table.Count(targets) == 1) then
    print("["..PlayerID(atk).."]["..atk:Nick().."] is the last man standing!") -- Print last standing player
  else
    print("New Targets:") 
    PrintTable(targets)
  end
end

--
-- Do Round Start - Actions to do at the start of each round
--
function DoRoundStart()
  numPlys = team.NumPlayers(0) -- Checks how many valid players exist
  targets = AssignTargets() -- Assigns targets to the appropriate variable
  
  print("Initial Targets:")
  PrintTable(targets) -- Print targets
end

--
-- Assign Targets - Assigns random targets to each player
--
function AssignTargets()
  local plys = team.GetPlayers(0) -- Table holding valid players
  local targs = team.GetPlayers(0) -- Table holding valid targets
  local rng = math.random(numPlys) -- Random value used to pick random players
  local result = {} -- The resulting table of targets
  
  for i = 1, numPlys, 1 do -- Do actions for each valid player
    rng = math.random(numPlys) -- Generate a random number
    while (rng == i or targs[rng] == nil) do
      rng = math.random(numPlys) print("["..i.."]["..plys[i]:Nick().."] New target")
    end
    table.Add(result, {[i] = {Player = plys[i], Target = targs[rng]}}) -- Assign target to player based on the random number
    targs[rng] = nil -- Remove assigned target from valid targets
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
concommand.Add("lsm_targets_new", function(ply, cmd, args, str)
  targets = AssignTargets()
  print("New Targets:")
  PrintTable(targets)
end)
concommand.Add("lsm_targets", function(ply, cmd, args, str)
  print("Current Targets:")
  PrintTable(targets)
end)