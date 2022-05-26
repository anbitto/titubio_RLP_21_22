from syltippy import syllabize
import const as letras
import math

def middle_signos(ref):
    if ref == "\"":
        result = "punto"
    elif ref == ",":
        result = "coma"
    elif ref == ";":
        result = "punto_coma"
    elif ref == ":":
        result = "dos_puntos"
    elif ref == "-":
        result = "guion"
    elif ref == "?" or ref == "¿":
        result = "interrogacion"
    elif ref == "!" or ref == "¡":
        result = "exclamacion"
    elif ref == "\"":
        result = "comillas"
    elif ref == "(":
        result = "abrir_parentesis"
    elif ref == ")":
        result = "cerrar_parentesis"
    elif ref == "'":
        result = "apostrofe"
    elif ref == " ":
        result = "espacio"
    else:
        result = ref

    return result


def middle_number(ref):
    if ref == "1":
        result = "b1"
    elif ref == "2":
        result = "b2"
    elif ref == "3":
        result = "b3"
    elif ref == "4":
        result = "b4"
    elif ref == "5":
        result = "b5"
    elif ref == "6":
        result = "b6"
    elif ref == "7":
        result = "b7"
    elif ref == "8":
        result = "b8"
    elif ref == "9":
        result = "b9"
    elif ref == "0":
        result = "b0"
    else:
        result = ref

    return result


def middle_acento(ref):
    if ref == "á":
        result = "a_acento"
    elif ref == "é":
        result = "e_acento"
    elif ref == "í":
        result = "i_acento"
    elif ref == "ó":
        result = "o_acento"
    elif ref == "ú":
        result = "u_acento"
    elif ref == "ü":
        result = "u_dieresis"
    elif ref == "ñ":
        result = "enye"
    else:
        result = ref

    return result


def extract_first_line(content, subrow):
    cache_letras_len = math.trunc(width / 2)
    subrow = subrow*2
    buffer = []

    for subline in range(cache_letras_len):
        buffer = buffer + content[subline][subrow:subrow+2]

    print(buffer)


syllables, stress = syllabize(u'hola buenas tardes')

# print(u'-'.join(s if stress != i else s.upper() for (i, s) in enumerate(syllables)))

texto_de_ejemplo = "Reina en mi espíritu una alegría admirable, muy parecida a las dulces alboradas de la primavera, de que gozo "
# "aquí con delicia. Estoy solo, y me felicito de vivir en este país, el más a propósito para almas como la mía, " \
# "soy tan dichoso, mi querido amigo, me sojuzga de tal modo la idea de reposar, que no me ocupo de mi arte. "

width = 16

result = []

saltos_de_linea = []

for it, x in enumerate(texto_de_ejemplo):
    x = middle_signos(x)
    x = middle_number(x)
    x = middle_acento(x)

    if x == "espacio":
        saltos_de_linea.append(it)

    if x.isupper():
        result.append(letras.dict_basic_letter["mayus"])

    result.append(letras.dict_basic_letter[x.lower()])
    print("letter ", x)

print(saltos_de_linea)

#truncar la lista en trozos de la longitud del ancho, falta mirar las silabas
extract_first_line(result, 0)
extract_first_line(result, 1)
extract_first_line(result, 2)
