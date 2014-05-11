DeriveGamemode("base")

GM.Name = "Last Man Standing"
GM.Author = "Henrik Melsom"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:CreateTeams()
  if (!GAMEMODE.TeamBased) then return end
  
  TEAM_DEFAULT = 0
  team.SetUp(TEAM_DEFAULT, "Default", Color(50, 255, 50), true)
  team.SetSpawnPoint(TEAM_DEFAULT, {"info_player_start", "info_player_terrorist", "info_player_rebel", "info_player_deathmatch"})
  team.SetClass(TEAM_DEFAULT, "player_default")
  
  team.SetUp(TEAM_SPECTATOR, "Spectators", Color(200, 200, 200), true)
  team.SetSpawnPoint(TEAM_SPECTATOR, {"info_player_start", "info_player_terrorist", "info_player_counterterrorist", "info_player_combine", "info_player_rebel"})
end