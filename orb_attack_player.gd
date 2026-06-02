extends Area2D

var speed = 400
# Direção
var direction = 1

func _process(delta: float) -> void:
	# Aumenta o x de acordo com a direção e velocidade e delta
	position.x += speed * direction * delta

# Sinal de quando sair da tela apaga o tiro
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
