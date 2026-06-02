extends CharacterBody2D

# Referencia o animatedsprite2d no codigo
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
# Referencia o raycast no codigo
@onready var ray_cast: RayCast2D = $RayCast

const SPEED = 70.0
# Definir o estado do inimigo
var death = false
# Salvar a posição inicial para voltar depois
var pos_salva
# Define a direção 1 = direita / -1 = esquerda
var direction := -1

func _ready() -> void:
	# Quando iniciar define o valor da variavel pos
	pos_salva = global_position

func _physics_process(delta: float) -> void:
	# Garante que caso o player ou o inimigo esteja morto n processa mais nada
	if EventBus.life_player <= 0 or death:
		return
	
	# Ser o raycast bater em alguma coisa muda a direçao e a scale (inverte para o outro lado)
	if ray_cast.is_colliding():
		direction *= -1
		ray_cast.scale.x *= -1
		
	# De acordo com a direção da o flip no sprite do inimigo
	if direction == 1:
		anim.flip_h = true
	else:
		anim.flip_h = false
	
	# A velocidade no x do inimigo
	velocity.x = direction * SPEED
	
	move_and_slide()

# Quando o player (apenas qm ta definido no grupo "player") colide toma dano
func _on_hitbox_body_entered(body: Node2D):
	if body.is_in_group("player") and not death:
		EventBus.change_life(-1)

# Quando o tiro do player (apenas qm ta definido no grupo "player") colide com a hitbox
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		# O objeto que colidiu "area" desaparece
		area.queue_free()
		# Manda o sinal para aumentar e alterar a quantidade de moeda
		EventBus.change_coin(+10)
		# Define o estado do inimigo como morto
		death = true
		# Toca animação de morrendo
		anim.play("death")
		# Esperar acabar a animação para continuar
		await anim.animation_finished
		# Muda a posição no y para sumir da tela
		self.position.y = -100
		# Cria um timer e espera acabar
		await get_tree().create_timer(7).timeout
		# Volta na posição salva
		self.position = pos_salva
		# Toca animação de stun
		anim.play("stun")
		# Esperar acabar a animação para continuar
		await anim.animation_finished
		# Define o estado do inimigo como vivo
		death = false
		# Toca animação de andando
		anim.play("walk")
