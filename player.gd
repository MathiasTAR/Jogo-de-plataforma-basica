extends CharacterBody2D

# Faz um pre carreganto da cena do tiro
const ORB_ATTACK_PLAYER = preload("uid://cwgar1gttrb5a")

# Referencia o animatedsprite2d no codigo
@onready var anim: AnimatedSprite2D = $anim

# Define speed do player
const SPEED = 300.0
# Define a velocidade(força) do pulo
const JUMP_VELOCITY = -400.0
# Define a direção 1 = direita / -1 = esquerda
var direction = 0
# Salva a direção em outra variavel para usar no tiro
var lado_olhado = 1

# Physics_processos parecido com process pórem com fisica
func _physics_process(delta: float) -> void:
	# Garante que caso o player esteja morto n processa mais nada
	if EventBus.life_player <= 0:
		# Executa a função
		_player_die()
		return
	
	# Usando uma função ja da godot caso n esteja no chão pega ativa a gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Quando aperta o botão de pulo e esteja no chão
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		# Aumentar o y de acordo com a velocidade do player
		velocity.y = JUMP_VELOCITY
		
	# Quando aperta o botão de attack
	if Input.is_action_just_pressed("attack"):
		# Inicia animação de ataque (n funcionando)
		anim.play("attack")
		# Chama a função de spawnar o tiro
		shot_orb()

	# Define a direção de acordo com o botão pressionado
	direction = Input.get_axis("move_left", "move_right")
	# Quando direção tiver valor
	if direction:
		# X de acordo com a velocidade e direção
		velocity.x = direction * SPEED
		# Toca animação de correndo
		anim.play("run")
		# Salva a posição na variavel lado_olhado so quando valor n for 0
		lado_olhado = direction
	else:
		# Se n tiver direção velocidade X zera
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Toca animação de idle
		anim.play("idle")
	
	# Se direção for maior q 0 desativa o flip
	if direction > 0:
		anim.flip_h = false
	# Caso direção for menor q 0 ativa o flip
	elif direction < 0:
		anim.flip_h = true
		
	# Se n tiver no chão toca animação de pulando
	if not is_on_floor():
		anim.play('jump')
	
	move_and_slide()

# Função de atirar
func shot_orb():
	# Carrega uma instancia de uma nova variavel do tiro
	var new_orb = ORB_ATTACK_PLAYER.instantiate()
	# Adiciona como irmã do player na hierarquia da cena 
	add_sibling(new_orb)
	# Define a posição do tiro de acordo com a propria posição do player
	new_orb.position = self.position
	# Define a direção do tio de acordo com a variavel lado_olhando (n pode ser 0)
	new_orb.direction = lado_olhado

# Função de morte
func _player_die():
	# Toca animação de morte
	anim.play("death")
	# Esperar acabar a animação para continuar
	await anim.animation_finished
	# Define a variavel global do player morto como true
	EventBus.player_death = true
