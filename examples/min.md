📚 Módulos más comunes y sus atajos por defecto
1. mini.surround

Reemplaza plugins como vim-surround

    sa{motion}{char} → Añadir surround (ej: saiw" rodea la palabra con comillas)

    sd{char} → Eliminar surround

    sr{old}{new} → Reemplazar surround

2. mini.comment

Reemplaza Comment.nvim

    Visual: Seleccionas texto y gc → comenta/descomenta

    Normal: gcc → comenta la línea actual

3. mini.ai

Mejora los objetos de texto

    va) → Visual seleccionar a parenthesis

    vi" → Visual seleccionar dentro de comillas
    (Es como los objetos de texto de Vim, pero con más inteligencia: funciona en bloques, funciones, etc.)

4. mini.files

Explorador de archivos

    <leader>e (por defecto si lo configuras así) → Abre explorador

        l o <CR> → abrir

        h → subir de carpeta

        q → cerrar

5. mini.bracketed

Movimiento rápido

    [b / ]b → Ir al buffer anterior / siguiente

    [q / ]q → Ir a errores (quickfix list)

    [d / ]d → Ir a diagnósticos LSP prev / next

6. mini.jump

Búsqueda rápida de caracteres

    s{char} → Saltar a un carácter en pantalla

    S{char}{char} → Saltar a dos caracteres seguidos

7. mini.jump2d

Búsqueda aún más avanzada tipo Hop/Easymotion

    <leader>j → Empieza salto a cualquier parte del buffer

8. mini.indentscope

Visualiza y navega indentación

    [ y ] en ciertas configuraciones → moverte por bloques indentados
