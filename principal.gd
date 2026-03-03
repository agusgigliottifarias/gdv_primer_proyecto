extends Node2D

var controlador_pid = -1

func _ready():
	# 1. Buscamos el ejecutable que moviste a la carpeta raíz
	var ruta = ProjectSettings.globalize_path("res://juego.exe")
	
	# 2. Lanzamos la IA de gestos (invisible por el --noconsole)
	controlador_pid = OS.create_process(ruta, [])
	
	if controlador_pid != -1:
		print("¡Controlador de gestos activado! PID:", controlador_pid)
	else:
		# Si sale este error, revisa que el archivo se llame juego.exe y no Juego.exe
		print("Error: No se encontró juego.exe en la carpeta del proyecto.")

func _exit_tree():
	# 3. Cerramos el proceso al salir para que no quede la webcam prendida
	if controlador_pid != -1:
		OS.kill(controlador_pid)
		print("Proceso de gestos finalizado.")
