extends Control

@onready var tropa_imagem = $"Tropa Imagem"
@onready var habilidade_texto = $"Hud Habilidade/Habilidade Texto"
@onready var seta_direita = $"Seta Direita"
@onready var seta_esquerda = $"Seta Esquerda"
@onready var nome_tropa = $"Nome Tropa"
@onready var vida_texto = $"Status/Vida Texto"
@onready var mana_texto = $"Status/Mana Texto"
@onready var mana_basic_texto = $"Status/Mana_Basic Texto"
@onready var dano_basic_texto = $"Status/Dano_Basic Texto"
@onready var range_texto = $"Status/Range Texto"
@onready var bonus_texto = $"Status/Bonus Texto"
@onready var music_battle = $MusicBattle

var T0 = preload("res://saintholyscripts/script_peças_aliadas/sabre_Turonia_Aliado.gd")
var T1 = preload("res://saintholyscripts/script_peças_aliadas/broquel_Turonia_Aliado.gd")
var T2 = preload("res://saintholyscripts/script_peças_aliadas/flecha_Turonia_Aliado.gd")
var T3 = preload("res://saintholyscripts/script_peças_aliadas/cajado_Turonia_Aliado.gd")
var T4 = preload("res://saintholyscripts/script_peças_aliadas/sabre_Solesia_Aliado.gd")
var T5 = preload("res://saintholyscripts/script_peças_aliadas/broquel_Solesia_Aliado.gd")
var T6 = preload("res://saintholyscripts/script_peças_aliadas/flecha_Solesia_Aliado.gd")
var T7 = preload("res://saintholyscripts/script_peças_aliadas/cajado_Solesia_Aliado.gd")
var T8 = preload("res://saintholyscripts/script_peças_aliadas/sabre_Verovia_Aliado.gd")
var T9 = preload("res://saintholyscripts/script_peças_aliadas/cajado_Verovia_Aliado.gd")

var t0 = T0.new()
var t1 = T1.new()
var t2 = T2.new()
var t3 = T3.new()
var t4 = T4.new()
var t5 = T5.new()
var t6 = T6.new()
var t7 = T7.new()
var t8 = T8.new()
var t9 = T9.new()

var tropas = [t0, t1, t2, t3, t4, t5, t6, t7, t8, t9]
var indice : int = 0
@export var indice_max : int = 9

func update_tropa():
	vida_texto.text = "❤: " + str(tropas[indice].health)
	mana_texto.text = "💧: " + str(tropas[indice].mana_max)
	mana_basic_texto.text = "💧⚔: " + str(tropas[indice].mana_por_hit)
	dano_basic_texto.text = "⚔: " + str(tropas[indice].basic_attack_damage) + "💥"
	range_texto.text = "🏹: " + str(tropas[indice].range)
	if indice == 9:
		bonus_texto.text = "🌟: +4💥⠀⠀⠀+15💧"
	else:
		bonus_texto.text = "🌟: +" + str(tropas[indice].bonus) + tropas[indice].bonus_tipo
	
	nome_tropa.text = tropas[indice].nome
	habilidade_texto.text = tropas[indice].habilidade_txt
	tropa_imagem.texture = tropas[indice].imagem


func _ready():
	update_tropa()
	
	if Global.troops_first_run:
		music_battle.play(0.0)
	else:
		music_battle.play(Global.music_progress)

func _on_seta_direita_pressed():
	indice += 1
	if indice == indice_max + 1:
		indice = 0
	update_tropa()

func _on_seta_esquerda_pressed():
	indice -= 1
	if indice == -1:
		indice = indice_max
	update_tropa()


func _on_voltar_pressed():
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name == "Tropas":
		Global.pre_game_runned_before = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		Global.music_progress = music_battle.get_playback_position()   
		get_tree().change_scene_to_file("res://scenes/pre_game.tscn")
	else:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_escolher_pressed():
	Global.jogo_iniciado = true
	Global.protagonista_nome = tropas[indice].nome
	var path = tropas[indice].path
	Global.banco.append(path)
	Global.troops_first_run = false
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	Global.music_progress = music_battle.get_playback_position()   
	get_tree().change_scene_to_file("res://scenes/cut_scene_inicial.tscn")
	
