local players = {}

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	minetest.chat_send_player(name, "Bienvenue sur le serveur Mynetest ! Vous êtes invicible et ne pouvez pas frapper les autres joueurs pendant une heure. Welcome to the Mynetest server ! You are invicible and you can't hit players during an hour.")
	formspec = "size[8,3;]"..
	           "label[.50,.50;Bienvenue sur le serveur Mynetest ! Vous êtes invicible et ne pouvez pas frapper les autres joueurs pendant une heure. Welcome to the Mynetest server ! You are invicible and you can't hit players during an hour.]"
	minetest.show_formspec(name, "first_hour:welcome", formspec)
	
	
	table.insert(players, name)
	minetest.after(3600, function(name, pos)
		table.remove(players, pos)
	end, name, table.getn(player))
end

minetest.register_on_punchplayer(function(player, hitter, time, tool_caps, dir, damage)
	for i = 1, #players do
		if players[i] == player:get_player_name() then
			players[i]:set_hp(players[i]:get_hp() + damage)
			minetest.chat_send_player(player:get_player_name(), "You have been punched but you are invicible because it's your first hour.")
		end
		if hitter:is_player() then
			if players[i] == hitter:get_player_name() then
				player:set_hp(player:get_hp() + damage)
				minetest.chat_send_player(hitter:get_player_name(), "You can't punch a player during your first hour.")
			end
		end
	end
end)