extends Node2D

func _process(_delta: float) -> void:
	# Se a variavel global for true ativa a função do gameover
	if EventBus.player_death:
		GameOver()

# Função de GameOver
func GameOver():
	# Troca de tela para gameover
	get_tree().change_scene_to_file("res://gameover.tscn")
	# Reseta as variaveis
	EventBus.life_player = 3
	EventBus.player_death = false

# Se cair fora do mapa inicia a função gameover
func _on_fora_mapa_body_entered(body: Node2D) -> void:
	GameOver()
