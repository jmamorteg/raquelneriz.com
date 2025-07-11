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
- Edita `assets/css/style.scss` para cambiar los colores y estilos
- Los colores principales están definidos en las variables CSS al inicio del archivo

### Contenido de páginas
- `index.markdown`: Página de inicio
- `about.markdown`: Página "Sobre mí"
- `blog.markdown`: Página del blog
- `contact.markdown`: Página de contacto

### Configuración general
- `_config.yml`: Configuración general del sitio
- Cambia título, descripción, email, etc.

## 📱 Responsive Design

El sitio está optimizado para móviles y tablets automáticamente.

## 🔧 Mantenimiento

- Los posts se publican automáticamente cuando haces commit
- GitHub Pages se actualiza automáticamente
- El sitio funciona sin necesidad de servidor propio

## 📞 Soporte

Si necesitas ayuda con el sitio, contacta:
- Teléfono: +34 654 10 77 98
- Email: info@raquelneriz.com

---

¡Disfruta escribiendo y compartiendo tus ideas! 🌟
