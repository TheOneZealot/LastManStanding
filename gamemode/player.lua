local ply = FindMetaTable("Player")

function GM:PlayerInitialSpawn(pl)
  pl:SetTeam(0)
end

function GM:PlayerSetModel(pl)
  pl:SetModel("models/player/breen.mdl")
end

function GM:PlayerLoadout(pl)
  pl:Give("weapon_revolver")
end