if not is_game() then
  return
end

function replenish_myself()
  if not managers.player or not managers.player:player_unit() then
    return
  end
  managers.hud:show_hint( { text = "Revived & Downs Reset", time = 1 } )
  managers.player:player_unit():base():replenish()
  managers.player:set_player_state( "standard" )
end

replenish_myself()