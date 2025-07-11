# Sitio Web de Raquel Neriz

Este es un sitio web personal construido con Jekyll y hospedado en GitHub Pages.

## 🚀 Configuración inicial

### 1. Preparar el repositorio en GitHub

1. Crea un nuevo repositorio público en GitHub llamado `raquelneriz.com`
2. Sube todo el contenido de esta carpeta al repositorio
3. Ve a Settings → Pages
4. Selecciona "Deploy from a branch" → "main" → "/ (root)"
5. Guarda los cambios

### 2. Configurar tu dominio personalizado

1. En GitHub, ve a Settings → Pages
2. En "Custom domain" ingresa: `raquelneriz.com`
3. Marca "Enforce HTTPS"
4. En tu proveedor de dominios, configura los DNS:
   - Tipo A: apunta a 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
   - Tipo CNAME: www apunta a tu-usuario.github.io

## 📝 Cómo publicar nuevos posts

### Opción 1: Directamente en GitHub (más fácil)
1. Ve a tu repositorio en GitHub
2. Navega a la carpeta `_posts`
3. Haz clic en "Add file" → "Create new file"
4. Nombra el archivo: `2025-07-11-titulo-del-post.markdown`
5. Copia la plantilla desde `PLANTILLA-POST.md`
6. Escribe tu contenido
7. Haz "Commit" y tu post se publicará automáticamente

### Opción 2: Usando VS Code
1. Abre esta carpeta en VS Code
2. Crea un nuevo archivo en `_posts` con el formato de fecha
3. Copia la plantilla y escribe tu contenido
4. Haz commit y push a GitHub

## 🛠️ Desarrollo local

Si quieres probar cambios localmente antes de publicar:

```bash
# Instalar dependencias
bundle install

# Ejecutar servidor local
bundle exec jekyll serve

# Ver el sitio en: http://localhost:4000
```

## 🎨 Personalización

### Colores y estilos
- **Archivo principal**: `assets/css/main.css` - Aquí está todo tu diseño personalizado
- **Archivo alternativo**: `assets/css/style.scss` - Versión SCSS (menos prioritaria)
- Los colores principales están definidos en las variables CSS al inicio del archivo

### Estructura y layouts
- `_layouts/default.html`: Layout base de todas las páginas (HTML estructura)
- `_layouts/home.html`: Layout específico para la página de inicio
- `_layouts/post.html`: Layout para posts individuales

### Contenido de páginas
- `index.html`: Página de inicio (usa layout: default)
- `about.markdown`: Página "Sobre mí"
- `blog.markdown`: Página del blog
- `contact.markdown`: Página de contacto

### Configuración general
- `_config.yml`: Configuración general del sitio
- Cambia título, descripción, email, etc.

### Orden de prioridad para modificar el diseño:
1. **`assets/css/main.css`** - ¡EL MÁS IMPORTANTE! Aquí están todos los estilos
2. **`_layouts/default.html`** - Para cambios en la estructura HTML
3. **`index.html`** - Para cambios en el contenido de la página principal
4. **`_config.yml`** - Para cambios en la configuración general

## 📱 Responsive Design

El sitio está optimizado para móviles y tablets automáticamente.

## 🔧 Mantenimiento

- Los posts se publican automáticamente cuando haces commit
- GitHub Pages se actualiza automáticamente
- El sitio funciona sin necesidad de servidor propio

## 🎯 Archivos clave para el diseño

### Para aplicar cambios visuales:
1. **`assets/css/main.css`** - Archivo CSS principal con todos los estilos
2. **`_layouts/default.html`** - Estructura HTML base
3. **`index.html`** - Contenido de la página principal

### Para ver cambios:
- **Localmente**: `http://localhost:4000` (con servidor corriendo)
- **GitHub Pages**: `https://jmamorteg.github.io/raquelneriz.com/`
- **Con dominio**: `https://raquelneriz.com` (cuando esté configurado)

### Solución de problemas:
- Si los estilos no se aplican, verifica que `main.css` existe y está linkeado en `default.html`
- Si hay errores de build en GitHub Actions, GitHub Pages maneja Jekyll automáticamente
- Consulta `TROUBLESHOOTING.md` para problemas comunes
- Espera 2-3 minutos después de hacer push para ver cambios en GitHub Pages
- Si ves "Error 404", verifica que el repositorio esté público y GitHub Pages esté activado

## 📞 Soporte

Si necesitas ayuda con el sitio, contacta:
- Teléfono: +34 654 10 77 98
- Email: info@raquelneriz.com

---

¡Disfruta escribiendo y compartiendo tus ideas! 🌟
