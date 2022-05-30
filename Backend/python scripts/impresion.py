import time

import solenoid
import text_parser_v2
import stepper_28BYJ_48
import nema

pin_end_of_travel = 10

# Mueve el cabezal hasta cerrar el circuito
# del end-of-travel switch
def cabezal_go_home():
    while True:  # Run forever
        if GPIO.input(pin_end_of_travel) == GPIO.HIGH:
            print("Button was pushed!")


# Mueve el cabezal hasta cerrar el circuito
# del end-of-travel switch
def toggle_solenoid():
    solenoid.solenoid_low()


# Fuerza que el solenoide se retraiga
def solenoid_up():
    solenoid.solenoid_high()


# Fuerza que el solenoide se extienda
def solenoid_down():
    solenoid.solenoid_low()


def cabezal_next_char():
    nema.moveNema(3)
    pass


def cabezal_move_in_char(inverted=False):
    nema.moveNema(3)
    pass


def cabezal_move_between_chars(inverted=False):
    nema.moveNema(3)


def load_paper():
    stepper_28BYJ_48.moveStepper(3)


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
            cabezal_move_between_chars(True)
            time.sleep(0.2)
        else:
            char_spacing_aux += 1
            cabezal_move_in_char(True)
            time.sleep(0.2)

        # si es un punto, se activa el solenoide
        if dot == 1:
            solenoid_down()
            time.sleep(0.2)
            solenoid_up()
            time.sleep(0.2)

# def main_printing_proces():

texto_base = "En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivia un hidalgo de los de lanza en astillero, adarga antigua, rocin flaco y galgo corredor. Una olla de algo mas vaca que carnero, salpicon las mas noches, duelos y quebrantos los sabados, lentejas los viernes, algun palomino de anadidura los domingos, consumian las tres partes de su hacienda. El resto della concluian sayo de velarte, calzas de velludo para las fiestas con sus pantuflos de lo mismo, los dias de entre semana se honraba con su vellori de lo mas fino. Tenia en su casa una ama que pasaba de los cuarenta, y una sobrina que no llegaba a los veinte, y un mozo de campo y plaza, que asi ensillaba el rocin como tomaba la podadera. Frisaba la edad de nuestro hidalgo con los cincuenta anos, era de complexion recia, seco de carnes, enjuto de rostro; gran madrugador y amigo de la caza. Quieren decir que tenia el sobrenombre de Quijada o Quesada (que en esto hay alguna diferencia en los autores que deste caso escriben), aunque por conjeturas verosimiles se deja entender que se llama Quijana; pero esto importa poco a nuestro cuento; basta que en la narracion del no se salga un punto de la verdad."

braille_lines = text_parser_v2.braille_formatting(texto_base)

solenoid_up()
cabezal_go_home()

load_paper()

line_index = 0
while line_index < len(braille_lines):
    if (line_index % 2) == 0:
        print_ltr(braille_lines[line_index])
    else:
        print_rtl(braille_lines[line_index])
    line_index += 1
