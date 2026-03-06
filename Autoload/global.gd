extends Node

# Creamos una señal (un grito) que avisa cuando las monedas cambian
signal monedas_cambiadas(nueva_cantidad)

var coins = 0:
	set(value):
		coins = value
		# Cada vez que alguien sume o reste monedas, emitimos la señal
		monedas_cambiadas.emit(coins)
