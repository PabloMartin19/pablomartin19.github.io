#!/bin/bash

# Configuración
REPO_DEPLOY="git@github.com:PabloMartin19/pablomartin19.github.io.git" # URL del repositorio de despliegue
DIR_SITE="_site" # Directorio generado por Jekyll

# Asegúrate de que el sitio esté actualizado
echo "Construyendo el sitio con Jekyll..."
jekyll build

# Ve al directorio _site
cd $DIR_SITE || { echo "Directorio $DIR_SITE no encontrado"; exit 1; }

# Inicializa el repositorio en el _site si no está inicializado
if [ ! -d ".git" ]; then
  echo "Inicializando el repositorio en $DIR_SITE..."
  git init
  git remote add origin $REPO_DEPLOY
fi

# Agregar y hacer commit de los cambios
echo "Añadiendo cambios al repositorio de despliegue..."
git add .
git commit -m "Actualización del sitio: $(date)"

# Subir los cambios
echo "Subiendo cambios al repositorio de despliegue..."
git push origin main --force

# Regresar al directorio principal
cd ..
