import scipy as sp
import braille_conversion as braille_utils
from syltippy import syllabize

LINE_CHAR_LIMIT = 12
PAPER_LINE_LIMIT = 13

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

def split_text(text):
    formated_text = text.replace(",", " ,")  # 1. Separar el texto en palabras
    text_by_words = formated_text.split(' ')

    total_lines = []
    line = ""
    for word in text_by_words:
        total_space = len(line) + len(word) + count_mayus(word) + count_mayus(line)
        if (total_space < LINE_CHAR_LIMIT):
            line = line + word + " "
        elif (total_space == LINE_CHAR_LIMIT):
            line = line + word
            total_lines.append(line)
            line = ""
        else:
            if LINE_CHAR_LIMIT - len(line) > 1:
                silabas_in, silabas_next = split_palabra(word, LINE_CHAR_LIMIT - (len(line) + count_mayus(line)))
                total_lines.append(line + silabas_in)
                line = silabas_next + " "
            else:
                total_lines.append(line)
                line = word + " "
    return total_lines

def text_to_braille(total_lines):
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


def braille_formatting(text):
    return text_to_braille(split_text(text))