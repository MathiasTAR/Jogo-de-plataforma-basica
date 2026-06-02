extends Node

# Vida do player
var life_player: int = 3
# Moedas atuais
var coins: int = 0
# Define o estado do player
var player_death: bool = false

# Sinal se a vida do player for alterada
signal life_changed(new_life: int)
# Sinal se a quantidade de moeda for alterada
signal coin_changed(new_coin: int)

# Função para emitir a nova vida
func change_life(damage: int) -> void:
	# Pega o valor do damage e diminuir da vida total
	life_player += damage
	# Da um clamp (a vida n passa de 0 ou 3)
	life_player = clamp(life_player, 0, 3) 
	
	# Emite a nova vida
	life_changed.emit(life_player)

# Função para emitir nova quantidade de moeda
func change_coin(value: int):
	# Aumenta a moeda de acordo com o value
	coins += value
	
	# Emite a nova quantidade
	coin_changed.emit(coins)
