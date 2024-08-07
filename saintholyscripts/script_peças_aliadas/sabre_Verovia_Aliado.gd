extends peça


func _init():
	nome = "Sabre de Verovia"
	bonus_tipo = "❤"
	habilidade_txt = "Ergue sua espada e inspira seus aliados trazendo uma brisa revigorante, curando-os em 15❤."
	imagem = preload("res://assets/sprites/tile_0099.png")
	health = 100
	mana_max = 100
	mana = 0
	range = 1
	basic_attack_damage = 12
	ability_damage = 15
	mana_por_hit = 20
	bonus = 10
	is_player_team = true
	classe = "Sabre"

func habilidade():
	peças = get_tree().get_nodes_in_group("peças")
	
	var cura
	
	if bonus_dmg:
		cura = ability_damage + bonus
	else:
		cura = ability_damage
	
	efeitos.stream = efeito_hab
	efeitos.play()
	for p in peças:
		if is_player_team == p.is_player_team and p != self:
			p.take_damage(-cura)
