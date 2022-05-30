import time

import solenoid
import text_parser_v2
import stepper_28BYJ_48
import nema

END_OF_TRAVEL_SWITCH_PIN = 10
DISTANCE_BETWEEN_DOTS = 0.5 # in cm

# Mueve el cabezal hasta cerrar el circuito del end-of-travel switch
def cabezal_go_home():
    not_pulsed = True
    while not_pulsed:  # Run forever
        move_cabezal()
        if GPIO.input(END_OF_TRAVEL_SWITCH_PIN) == GPIO.HIGH:
            not_pulsed = False

# Fuerza que el solenoide se retraiga
def solenoid_up():
    solenoid.solenoid_high()

# Fuerza que el solenoide se extienda
def solenoid_down():
    solenoid.solenoid_low()

def move_cabezal(distance=DISTANCE_BETWEEN_DOTS, inverted=False):
    nema.moveNema(distance, inverted)

def move_paper():
    stepper_28BYJ_48.move_next_line()

def print_ltr(braille_line):
    for dot in braille_line:
        move_cabezal()

        if dot == 1:
            solenoid_down()
            time.sleep(0.2)
            solenoid_up()
            time.sleep(0.2)


def print_rtl(braille_line):
    for dot in braille_line:
        move_cabezal(inverted=True)

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
