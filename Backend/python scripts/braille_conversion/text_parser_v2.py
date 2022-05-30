import braille_utils
from syltippy import syllabize


def juntar_lista_silabas(lista_silabas):
    return ''.join((str(n) for n in lista_silabas))


def split_palabra(palabra, espacio_disponible):
    syllables, stress = syllabize(palabra)

    # recorremos al revés la lista de sílabas, disminuyendo
    # con ello la cantidad que incluimos en la comprobación
    inline = ""
    index_limite = -1
    for index_silaba in reversed(range(1, len(syllables))):
        segmento = juntar_lista_silabas(syllables[0:index_silaba])
        mayus_count = count_mayus(segmento)
        segmento = segmento

        if len(segmento) + 1 + mayus_count <= espacio_disponible:
            index_limite = index_silaba
            inline = segmento
            break

    if index_limite == -1:
        return "", palabra
    else:
        return inline + '-', palabra[len(inline): len(palabra)]


def count_mayus(palabra):
    return sum(1 for c in palabra if c.isupper())


def braille_formatting(text):
    # Número de carácteres que caben en una linea
    LINE_CHAR_LIMIT = 12
    # Número de carácteres que caben en una linea
    paper_line_limit = 13
    # Número de carácteres que se llevan escritos
    page_buffer = 0
    # Número de carácteres que se llevan escritos
    line_buffer = 0

    # texto_de_ejemplo = "Reina en mi espíritu una alegría admirable, muy parecida a las dulces alboradas de la primavera, de que gozo "

    # texto_de_ejemplo = "En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivia un hidalgo de los de lanza en astillero, adarga antigua, rocin flaco y galgo corredor. Una olla de algo mas vaca que carnero, salpicon las mas noches, duelos y quebrantos los sabados, lentejas los viernes, algun palomino de anadidura los domingos, consumian las tres partes de su hacienda. El resto della concluian sayo de velarte, calzas de velludo para las fiestas con sus pantuflos de lo mismo, los dias de entre semana se honraba con su vellori de lo mas fino. Tenia en su casa una ama que pasaba de los cuarenta, y una sobrina que no llegaba a los veinte, y un mozo de campo y plaza, que asi ensillaba el rocin como tomaba la podadera. Frisaba la edad de nuestro hidalgo con los cincuenta anos, era de complexion recia, seco de carnes, enjuto de rostro; gran madrugador y amigo de la caza. Quieren decir que tenia el sobrenombre de Quijada o Quesada (que en esto hay alguna diferencia en los autores que deste caso escriben), aunque por conjeturas verosimiles se deja entender que se llama Quijana; pero esto importa poco a nuestro cuento; basta que en la narracion del no se salga un punto de la verdad."

    text = text.replace(",", " ,")  # 1. Separar el texto en palabras
    text_by_words = text.split(' ')

    total_lines = []
    line = ""
    # 2. Mirar si la palabra cabe en la linea
    for word in text_by_words:

        # next_line = False
        # if (next_line):
        # while (not next_line):

        # tener en cuenta mayúsculas

        total_space = len(line) + len(word) + count_mayus(word) + count_mayus(line)
        if (total_space < LINE_CHAR_LIMIT):
            line = line + word + " "
        elif (total_space == LINE_CHAR_LIMIT):
            line = line + word
            total_lines.append(line)
            line = ""
        else:

            if LINE_CHAR_LIMIT - len(line) > 1:
                # comrovar por silabas
                silabas_in, silabas_next = split_palabra(word, LINE_CHAR_LIMIT - (len(line) + count_mayus(line)))
                total_lines.append(line + silabas_in)
                line = silabas_next + " "
            else:
                total_lines.append(line)
                line = word + " "
            # En una nueva funcion:
            # comrovar bufer - si no cabe -> comrovar por silabas

            # next_line = True

    for fire in total_lines:
        print(len(fire))

    for fire in total_lines:
        print(fire)

    dot_lines = []

    for line in total_lines:

        result = []
        for it, x in enumerate(line):

            x = braille_utils.middle_signos(x)
            x = braille_utils.middle_number(x)
            if x.isalnum():
                x = braille_utils.middle_acento(x.lower())

            if x.isupper():
                result.append(braille_utils.letras.dict_basic_letter["mayus"])

            if x.isalnum():
                x = x.lower()

            result.append(braille_utils.letras.dict_basic_letter[x])

        dot_lines.append(braille_utils.extract_first_line(result, 0))
        dot_lines.append(braille_utils.extract_first_line(result, 1))
        dot_lines.append(braille_utils.extract_first_line(result, 2))

    return dot_lines


