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