# Guía de Troubleshooting - Jekyll en GitHub Pages

## Problemas comunes y soluciones

### 1. Los estilos CSS no se cargan

**Problema**: El sitio se ve sin estilos en GitHub Pages
**Solución**: 
- Asegúrate de que el archivo `assets/css/style.scss` tenga las líneas `---` al inicio
- Verifica que `_config.yml` no tenga `theme: minima` activado
- En GitHub Pages, ve a Settings → Pages y verifica que esté configurado para "Deploy from a branch"

### 2. El sitio no se actualiza

**Problema**: Los cambios no se reflejan en el sitio
**Solución**:
- Espera 2-3 minutos después de hacer push
- Ve a Actions en GitHub para ver si hay errores de build
- Verifica que el branch esté configurado correctamente en Pages

### 3. El logo no se muestra

**Problema**: La imagen del logo no aparece
**Solución**:
- Verifica que la imagen esté en `assets/img/RN_logo.svg`
- Asegúrate de que el archivo se haya subido correctamente

### 4. Los posts no aparecen

**Problema**: Las publicaciones no se muestran
**Solución**:
- Verifica que los archivos estén en la carpeta `_posts`
- Asegúrate de que el nombre del archivo tenga el formato: `YYYY-MM-DD-titulo.markdown`
- Verifica que el front matter esté correcto

### 5. Para forzar la reconstrucción del sitio

1. Ve a tu repositorio en GitHub
2. Haz un pequeño cambio en cualquier archivo (por ejemplo, añadir un espacio)
3. Haz commit y push
4. Espera 2-3 minutos

### 6. Verificar que el build funciona localmente

```bash
bundle exec jekyll build
bundle exec jekyll serve
```

### 7. Configuración de dominio personalizado

En tu proveedor de DNS:
- Tipo A: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
- Tipo CNAME: `www` → `tu-usuario.github.io`

En GitHub Pages:
- Settings → Pages → Custom domain → `raquelneriz.com`
- ✓ Enforce HTTPS
