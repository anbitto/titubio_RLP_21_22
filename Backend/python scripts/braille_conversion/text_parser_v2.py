import braille_utils

# Número de carácteres que caben en una linea
LINE_CHAR_LIMIT = 12
# Número de carácteres que caben en una linea
paper_line_limit = 13
# Número de carácteres que se llevan escritos
page_buffer = 0
# Número de carácteres que se llevan escritos
line_buffer = 0

texto_de_ejemplo = "Reina en mi espíritu una alegría admirable, muy parecida a las dulces alboradas de la primavera, de que gozo "

# 1. Separar el texto en palabras
text_by_words = texto_de_ejemplo.split(' ')

total_lines = []
line = []
# 2. Mirar si la palabra cabe en la linea
for word in text_by_words:

    next_line = False
    if (aux_buffer != None):
        line_buffer = line_buffer + aux_buffer
        aux_buffer = None

    while(not next_line):
        total_space = line_buffer + len(word)
        if (total_space < LINE_CHAR_LIMIT):
            continue
        elif(total_space == LINE_CHAR_LIMIT):
            continue
        else:
            # comrovar por silabas
            total_lines.append(line)
            # En una nueva funcion:
            # comrovar bufer - si no cabe -> comrovar por silabas
            line = [word]
            next_line = True








# 2. Separar las palabras por letras
text = list()
text.append([letter for letter in text_by_words])

# 3. Traducir a braile
for word in text:
    x = braille_utils.middle_signos(word)
    x = braille_utils.middle_number(x)
    x = braille_utils.middle_acento(x)
