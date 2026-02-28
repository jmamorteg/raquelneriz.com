# Web de Raquel Neriz · Guía fácil

Este documento está pensado para usar la web sin complicaciones técnicas.

## ✅ Lo que usarás casi siempre

Abre la carpeta `BOTONES` y usa estos accesos:

1. `01-NUEVO-POST.bat` → crear un post nuevo.
2. `02-NUEVO-ITEM-PORTFOLIO.bat` → subir una nueva imagen al portfolio.
3. `03-PUBLICAR.bat` → publicar cambios en la web.
4. `04-SETUP-EQUIPO-NUEVO.bat` → solo para preparar un ordenador nuevo.

Después de publicar, espera 1-3 minutos para verlo online.

## ✍️ Cómo corregir textos

### Caso A: corregir texto de una página

Si cambias un texto (por ejemplo “Servicios”), hazlo en los 3 idiomas:

- `ca/servicios.markdown`
- `es/servicios.markdown`
- `en/servicios.markdown`

El mismo criterio aplica para `about`, `contact`, `portfolio`, `taller-kintsugi`, etc.

### Caso B: corregir texto del menú

Edita estos 3 archivos:

- `_data/navigation_ca.yml`
- `_data/navigation_es.yml`
- `_data/navigation_en.yml`

## 🖼️ Cómo meter o corregir imágenes

### Subir imagen nueva al portfolio (recomendado)

Usa `02-NUEVO-ITEM-PORTFOLIO.bat` y sigue las preguntas en pantalla.

### Corregir una imagen del portfolio

1. Reemplaza la imagen en `assets/img/portfolio/`.
2. Si el nombre del archivo cambia, actualiza también `_data/portfolio.json`.
3. Publica con `03-PUBLICAR.bat`.

### Imagen de una página (no portfolio)

1. Copia/reemplaza imagen en `assets/img/`.
2. Ajusta la ruta en la página correspondiente.
3. Publica con `03-PUBLICAR.bat`.

## 🌍 Idiomas de la web

- La web tiene catalán, español e inglés.
- Si corriges un texto importante, revisa siempre los 3 idiomas.
- La portada (`/`) entra por defecto en catalán si no detecta idioma claro.

## 🧭 Para evitar errores

- No tocar la carpeta `_site`.
- No tocar la carpeta `vendor`.
- No borrar líneas `---` al inicio de los archivos `.markdown`.

## 🗂️ Ruta recomendada para cualquier cambio

1. Haz el cambio (texto o imagen).
2. Revisa rápido que esté bien.
3. Ejecuta `03-PUBLICAR.bat`.
4. Comprueba la web (si aplica, en `/ca`, `/es` y `/en`).

## 🛠️ Solo si hace falta (parte técnica)

### Preparar un equipo nuevo

- Ejecutar `04-SETUP-EQUIPO-NUEVO.bat`.

### Ver la web en local

- Tarea de VS Code: `Serve Jekyll Site`.
- URL local: `http://127.0.0.1:4000`.

### Archivos técnicos clave (para soporte)

- Estilos: `assets/css/style.scss`
- Menús: `_data/navigation_*.yml`
- Portfolio: `_data/portfolio.json`
- Layout base: `_layouts/default.html`
