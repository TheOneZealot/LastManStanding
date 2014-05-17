SWEP.PrintName = "Revolver"
SWEP.Author = "Henrik Melsom"

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
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

function SWEP:Initialize()
  self.Weapon:SetWeaponHoldType("revolver")
end

function SWEP:PrimaryAttack()
  if (!self:CanPrimaryAttack()) then return end
  self.Weapon:SetNextPrimaryFire(CurTime() + .75)
  self:EmitSound("Weapon_357.Single")
  self:ShootBullet(999, 1, 0)
  self.Owner:ViewPunch(Angle(-0, 0, 0))
end

function SWEP:SecondaryAttack() end