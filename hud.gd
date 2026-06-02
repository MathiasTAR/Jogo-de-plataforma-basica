extends TextureRect

# Referencia o hud da vida no codigo
@onready var life_1: TextureRect = $life1
@onready var life_2: TextureRect = $life2
@onready var life_3: TextureRect = $life3

# Referencia a label da moeda no codigo
@onready var coins_label: Label = $coins/coins_label

func _ready() -> void:
	# Conecta o sinal de vida e moeda e executa a função
	EventBus.life_changed.connect(atualizar_vida)
	EventBus.coin_changed.connect(atualizar_coins)
	
	# Atualiza o hud quando inicia a cena para garantir para mostrar os valores certo
	atualizar_vida(EventBus.life_player)
	atualizar_coins(EventBus.coins)

# Função de atualizar no hud a life
func atualizar_vida(new_life: int):
	# De acordo com o valor da vida usando o match deixa visivel ou não o coração
	match new_life:
		3: life_3.visible = true;
		2: life_2.visible = true; life_3.visible = false
		1: life_1.visible = true; life_2.visible = false
		0: life_1.visible = false

# Função de atualizar o texto de moedas
func atualizar_coins(new_coins: int):
	# Transforma a variavel de int para string e adiciona um pad de 0 zeros para mostrar no label
	coins_label.text = str(new_coins).pad_zeros(6)
