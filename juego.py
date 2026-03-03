import cv2
import math
import pyautogui
import sys
import mediapipe as mp

# Configuración directa de Mediapipe para evitar errores de empaquetado
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

# Inicializar cámara
cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)

# Umbral de distancia para los gestos
UMBRAL = 0.05    

with mp_hands.Hands(
    model_complexity=0, 
    min_detection_confidence=0.7, 
    min_tracking_confidence=0.7
) as hands:
    
    print("--- CONTROLADOR GESTUAL GUILLERMO ACTIVO ---")
    
    # Estados para evitar repetición infinita de teclas
    st = {"esp": False, "der": False, "izq": False}

    while cap.isOpened():
        success, frame = cap.read()
        if not success: 
            break

        # Espejo y conversión de color
        frame = cv2.flip(frame, 1)
        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = hands.process(rgb_frame)

        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                p = hand_landmarks.landmark
                
                # --- GESTO: ESPACIO (Puntas de pulgar e índice) ---
                dist_esp = math.hypot(p[8].x - p[4].x, p[8].y - p[4].y)
                if dist_esp < UMBRAL:
                    if not st["esp"]: 
                        pyautogui.press('space')
                        print("ACCION: SALTO")
                        st["esp"] = True
                else: 
                    st["esp"] = False

                # --- GESTO: DERECHA (Pulgar y Medio) ---
                dist_der = math.hypot(p[12].x - p[4].x, p[12].y - p[4].y)
                if dist_der < UMBRAL:
                    if not st["der"]: 
                        pyautogui.keyDown('right')
                        print("ACCION: DERECHA (Manteniendo)")
                        st["der"] = True
                else:
                    if st["der"]: 
                        pyautogui.keyUp('right')
                        st["der"] = False

                # --- GESTO: IZQUIERDA (Pulgar y Base del índice) ---
                dist_izq = math.hypot(p[5].x - p[4].x, p[5].y - p[4].y)
                if dist_izq < UMBRAL:
                    if not st["izq"]: 
                        pyautogui.keyDown('left')
                        print("ACCION: IZQUIERDA (Manteniendo)")
                        st["izq"] = True
                else:
                    if st["izq"]: 
                        pyautogui.keyUp('left')
                        st["izq"] = False

                # Dibujar las marcas en la imagen (puedes comentarlo para más velocidad)
                mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

        # Mostrar ventana (Comentar para modo invisible total)
        cv2.imshow('Control Gestual - Guillermo', frame)
        
        # Salir con la tecla ESC
        if cv2.waitKey(1) & 0xFF == 27: 
            break

cap.release()
cv2.destroyAllWindows()