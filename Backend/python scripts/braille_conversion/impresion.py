import time
import text_parser_v2

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


def cabezal_move_in_char(inverted=False):
    pass


def cabezal_move_between_chars(inverted=False):
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