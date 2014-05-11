AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

function GM:Initialize()
  self.BaseClass:Initialize(self)
end