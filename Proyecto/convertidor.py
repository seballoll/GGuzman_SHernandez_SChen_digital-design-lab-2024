from PIL import Image

def image_to_sequential_mif(image_path, mif_path, width=200, height=200):
    # Cargar la imagen y asegurar que tiene las dimensiones adecuadas
    img = Image.open(image_path).resize((width, height)).convert("RGB")

    # Crear el archivo .mif
    with open(mif_path, "w") as mif_file:
        # Configuración inicial del archivo .mif
        mif_file.write(f"DEPTH = {width * height * 3};\n")  # 3 canales (RGB) x 40000 píxeles
        mif_file.write("WIDTH = 8;\n")                       # 8 bits por dirección
        mif_file.write("ADDRESS_RADIX = HEX;\n")
        mif_file.write("DATA_RADIX = HEX;\n")
        mif_file.write("CONTENT BEGIN\n")
        
        # Dirección inicial para la ROM
        address = 0

        # Escribir el canal Rojo (primeros 40000 valores)
        for y in range(height):
            for x in range(width):
                r, _, _ = img.getpixel((x, y))
                mif_file.write(f"    {address:05X} : {r:02X};\n")
                address += 1

        # Escribir el canal Verde (siguientes 40000 valores)
        for y in range(height):
            for x in range(width):
                _, g, _ = img.getpixel((x, y))
                mif_file.write(f"    {address:05X} : {g:02X};\n")
                address += 1

        # Escribir el canal Azul (últimos 40000 valores)
        for y in range(height):
            for x in range(width):
                _, _, b = img.getpixel((x, y))
                mif_file.write(f"    {address:05X} : {b:02X};\n")
                address += 1

        mif_file.write("END;\n")

    print(f"Archivo .mif generado en {mif_path}")

# Ejemplo de uso
image_to_sequential_mif("tu_imagen.png", "sequential_image.mif")
