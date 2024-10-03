#!/bin/bash

# Configuración
REPO_DEPLOY="git@github.com:PabloMartin19/pablomartin19.github.io.git" # URL del repositorio de despliegue
DIR_SITE="_site" # Directorio generado por Jekyll

# Asegúrate de que el sitio esté actualizado
echo "Construyendo el sitio con Jekyll..."
jekyll build

# Clonar el repositorio de despliegue en una carpeta temporal
TEMP_DIR=$(mktemp -d)
git clone $REPO_DEPLOY $TEMP_DIR

# Copiar los archivos del _site al repositorio de despliegue
rsync -av --delete $DIR_SITE/ $TEMP_DIR/

# Cambiar al directorio temporal
cd $TEMP_DIR

# Agregar y hacer commit de los cambios
echo "Añadiendo cambios al repositorio de despliegue..."
git add .
git commit -m "Actualización del sitio: $(date)"

# Subir los cambios
echo "Subiendo cambios al repositorio de despliegue..."
git push origin main --force

# Limpiar el directorio temporal
rm -rf $TEMP_DIR

# Regresar al directorio principal
cd ..
