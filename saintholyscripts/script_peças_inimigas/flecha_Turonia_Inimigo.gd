extends peça

func _init():
	health = 80
	mana_max = 90
	mana = 0
	range = 3
	basic_attack_damage = 10
	ability_damage = 15
	mana_por_hit = 15
	bonus = 0
	is_player_team = false
	classe = "Flecha"

func habilidade():
	var diff = global_position - peça_alvo.global_position
	
	if diff.x > 0 and diff.y == 0:
		diff = Vector2(16, 0)
	elif diff.x < 0 and diff.y == 0:
		diff = Vector2(-16, 0)
	elif diff.x == 0 and diff.y > 0:
		diff = Vector2(0, 16)
	elif diff.x == 0 and diff.y < 0:
		diff = Vector2(0, -16)
		
	instance = HIT_BOX.instantiate()
	instance.global_position -= diff
	instance.set_is_player_team(is_player_team)
	instance.set_timer(1)
	
	if enemy_bonus_dmg_randomizer():
		bonus_skill_effect()
	else:
		skill_effect()
	
	efeitos.stream = efeito_hab
	efeitos.play()
	add_child(instance)
	
	for x in 10:
		await get_tree().create_timer(0.08).timeout
		instance.global_position -= diff

func bonus_skill_effect():
	instance.set_damage(ability_damage + bonus)
	mana = 30
	hp_bar._set_mana(mana)
