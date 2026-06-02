extends Area2D

# Adiciona o texto da placa via inspetor
@export var texto_visivel: String

# Referencia a label no codigo
@onready var text_label: Label = $Control/Label

func _ready():
	# Quando inicia define o texto da placa que foi colocado no inspetor
	text_label.text = texto_visivel

func _on_body_entered(body: Node2D):
	# Quando o player (apenas qm ta definido no grupo "player") entrar na area
	if body.is_in_group("player"):
		# define o texto como visivel
		text_label.visible = true

func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		# define o texto como não visivel
		text_label.visible = false
