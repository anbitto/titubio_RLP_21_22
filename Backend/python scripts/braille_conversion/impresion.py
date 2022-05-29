import time


# plan es hacer que todas las funciones de movimiento devuelvan los pasos que se han
# dado, para luego tener una variable que comparar con el límite del recorrido


# Mueve el cabezal hasta cerrar el circuito
# del end-of-travel switch
def cabezal_go_home():
    pass


# Mueve el cabezal hasta cerrar el circuito
# del end-of-travel switch
def toggle_solenoid():
    pass


# Fuerza que el solenoide se retraiga
def solenoid_up():
    pass


# Fuerza que el solenoide se extienda
def solenoid_down():
    pass


# Mover el papel a la siguiente linea,
# activando stepper de la hoja y cabezal para ello
def cabezal_next_line():
    pass


def cabezal_next_char():
    pass


def cabezal_move_in_char():
    pass


def cabezal_move_between_chars():
    pass


def load_paper():
    pass


def print_ltr(braille_line):

    char_spacing_aux = 0
    for dot in braille_line:

        # controlar espacios entre caracteres
        if char_spacing_aux == 2:  # puede que esto sea un 1 pero para qué pensar cuando se puede probar?
            char_spacing_aux = 0
            cabezal_move_between_chars()
            time.sleep(0.2)
        else:
            char_spacing_aux += 1
            cabezal_move_in_char()
            time.sleep(0.2)

        # si es un punto, se activa el solenoide
        if dot == 1:
            solenoid_down()
            time.sleep(0.2)
            solenoid_up()
            time.sleep(0.2)


def print_rtl(braille_line):
    char_spacing_aux = 0
    for dot in braille_line:

        # controlar espacios entre caracteres
        if char_spacing_aux == 2:  # puede que esto sea un 1 pero para qué pensar cuando se puede probar?
            char_spacing_aux = 0
            cabezal_move_between_chars()
            time.sleep(0.2)
        else:
            char_spacing_aux += 1
            cabezal_move_in_char()
            time.sleep(0.2)

        # si es un punto, se activa el solenoide
        if dot == 1:
            solenoid_down()
            time.sleep(0.2)
            solenoid_up()
            time.sleep(0.2)


# procesar texto
# generar partrón puntos
braille_lines = [
    [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]
]

solenoid_up()
cabezal_go_home()

load_paper()


# line_index = 0
# while line_index < len(braille_lines):
#     if (line_index % 2) == 0:
#         print_ltr(braille_lines[line_index])
#     else:
#         print_rtl(braille_lines[line_index])

for braille_line in braille_lines:

    char_spacing_aux = 0
    for dot in braille_line:

        # controlar espacios entre caracteres
        if char_spacing_aux == 2:  # puede que esto sea un 1 pero para qué pensar cuando se puede probar?
            char_spacing_aux = 0
            cabezal_move_between_chars()
            time.sleep(0.2)
        else:
            char_spacing_aux += 1
            cabezal_move_in_char()
            time.sleep(0.2)

        # si es un punto, se activa el solenoide
        if dot == 1:
            solenoid_down()
            time.sleep(0.2)
            solenoid_up()
            time.sleep(0.2)

            # por aqui pondría la comprobación del limite de hoja pero
            # como que hacemos que impirma en ambas direcciones pues ez