# 🎮 Guia de Estudo Técnico: Arquitetura e Mecânicas (Godot 4)

Este repositório foi desenvolvido como material de estudo de jogos utilizando a **Godot Engine 4.6**. O código do projeto foi completamente comentado para fins didáticos (Não é o melhor apenas o mais simples).

---

## 1. Arquitetura de Sinais Globais (Padrão EventBus)

Para evitar o acoplamento rígido entre nós independentes — como a Interface do Usuário (HUD) — o projeto utiliza o padrão de projeto **Observer** através de um Autoload centralizador chamado `EventBus`.

### Principais Variáveis e Sinais Globais:
* `life_player: int`: Armazena a saúde atual do jogador.
* `signal life_changed(new_life: int)`: Disparado sempre que a vida do jogador sofre alteração.
* `coins: int`: Armazena a quantidade de moedas.
* `coin_changed(new_coin: int)`: Disparado sempre que a quantidade de moedas sofre alteração.
* 
> **Regra de Ouro do Fluxo:** O inimigo não precisa saber quanta vida o jogador tem ou onde o HUD está na árvore. O inimigo apenas diz: `EventBus.modificar_vida(-1)`. O `EventBus` processa a matemática e emite o sinal `life_changed`, que é capturado pelo HUD para atualizar o `TextureRect` via `match`.

---

## 4. Persistência de Vetores

### Vetor de Disparo da Orb (`player.gd` + `orb.gd`)
Para resolver o problema clássico de projéteis que ficam estáticos quando o jogador atira sem se mover, a Orb calcula sua direção baseando-se no estado visual do nó de renderização (`AnimatedSprite2D.flip_h`) do Player no momento exato do nascimento. Como o sprite só pode estar como verdadeiro ou falso, a direção da Orb obrigatoriamente será `1` ou `-1`, tornando matematicamente impossível que o tiro saia com velocidade zero.

---

## 📌 Créditos e Assets

Utilize este espaço para documentar a autoria de recursos de terceiros utilizados no projeto:

* **Sprites de Personagens / Tilesets do Cenário:** [o_lobster/(https://o-lobster.itch.io/platformmetroidvania-pixel-art-asset-pack)]
* **Inimigos:** [MonoPixelArt/(https://monopixelart.itch.io/forest-monsters-pixel-art)]
