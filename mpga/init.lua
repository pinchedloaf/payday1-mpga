-- Enable PD1 Debug Menu
core:import( "CoreFreeFlight" )
Global.DEBUG_MENU_ON = true

-- Determine if we are in a level or not.
function is_game()
  if not game_state_machine then
    return
  end
  local any_ingame = {
    ingame_standard = true,
    ingame_mask_off = true,
    ingame_clean = true,
    ingame_bleed_out = true,
    ingame_fatal = true,
    ingame_arrested = true,
    ingame_incapacitated = true,
    ingame_waiting_for_players = true,
    ingame_waiting_for_respawn = true,
    ingame_access_camera = true,
  }
  return any_ingame[game_state_machine:last_queued_state_name()]
end

-- Determine player position in world
function ray_pos()
  local unit = managers.player:player_unit()
  if not alive(unit) then
    return
  end
  local from = managers.player:player_unit():movement():m_head_pos()
  local to = from + managers.player:player_unit():movement():m_head_rot():y() * 200
  local ray = managers.player:player_unit():raycast("ray", from, to, "slot_mask", managers.slot:get_mask("trip_mine_placeables"), "ignore_unit", {})
  if not ray then
    return
  end
  return ray.position, unit:rotation()
end

-- Identify and return player ID
function verify_player_id(id)
  if not managers.network:session() then return false end
  return managers.network:session():peer(id) and managers.criminals:character_name_by_peer_id(id)
end


-- Unlock all masks
function NetworkAccountSTEAM:has_mask(...) --All masks
	return true
end
