SWEP.PrintName = "Hands"
SWEP.Author = "Henrik Melsom"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize = -1  
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.ViewModel = ""
SWEP.WorldModel = ""

function SWEP:Initialize()
  self.Weapon:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack() end

function SWEP:SecondaryAttack() end