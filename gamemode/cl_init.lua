include("shared.lua")

function GM:HUDShouldDraw(name)
  if (name == "CHudHealth") then
    return false
  end
  return true
end

function GM:HUDPaint()
  hook.Run("HUDDrawTargetID")
end