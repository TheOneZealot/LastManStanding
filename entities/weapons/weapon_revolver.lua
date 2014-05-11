SWEP.PrintName = "Revolver"
SWEP.Author = "Henrik Melsom"
SWEP.Instructions = "Shoot bullets!"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize = 1  
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

function SWEP:PrimaryAttack()
  if (!self:CanPrimaryAttack()) then return end
  self.Weapon:SetNextPrimaryFire(CurTime() + .75)
  self:EmitSound("Weapon_AR2.Single")
  self:ShootBullet(200, 1, 0)
  self.Owner:ViewPunch(Angle(-1, 0, 0))
end
