if not is_game() then
  return
end

if verify_player_id(1) then
  managers.hud:show_hint( { text = "Releasing From Custody", time = 1 } )
  IngameWaitingForRespawnState.request_player_spawn(1)
end