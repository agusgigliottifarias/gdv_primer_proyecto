extends CanvasLayer

@onready var coin_label = $Control/Label

func _ready():
	# Conectamos el HUD a la señal de Global
	Global.monedas_cambiadas.connect(set_coins)
	# Ponemos el texto inicial al arrancar el juego
	set_coins(Global.coins)

func set_coins(amount):
	coin_label.text = str(amount)
