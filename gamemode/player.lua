local ply = FindMetaTable("Player")

function GM:PlayerInitialSpawn(pl)
end

function GM:PlayerSpawn(pl)
  pl:SetTeam(0)
  pl:SetMaxSpeed(0)

  hook.Call("PlayerLoadout", GAMEMODE, pl)
  hook.Call("PlayerSetModel", GAMEMODE, pl)
end

function GM:PlayerSetModel(pl)
  pl:SetModel("models/player/breen.mdl")
end

function GM:PlayerLoadout(pl)
  pl:Give("weapon_hands")
  pl:Give("weapon_revolver")
end