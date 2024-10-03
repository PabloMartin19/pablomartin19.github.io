#!/bin/bash

# Define variables
DEV_REPO_PATH="/home/pavlo/web/jekyll-theme-chirpy"  # Cambia esto a la ruta de tu repositorio de desarrollo
DEPLOY_REPO_PATH="/home/pavlo/github/pablomartin19.github.io"  # Cambia esto a la ruta de tu repositorio de despliegue
BRANCH="main"  # Cambia esto si tu rama principal tiene otro nombre

# Cambia al directorio del repositorio de desarrollo
cd "$DEV_REPO_PATH" || exit

# Construye el sitio Jekyll
bundle exec jekyll build

# Cambia al directorio del repositorio de despliegue
cd "$DEPLOY_REPO_PATH" || exit

# Limpia el contenido del repositorio de despliegue
rm -rf *

# Copia el contenido de _site del repositorio de desarrollo al repositorio de despliegue
cp -r "$DEV_REPO_PATH/_site/"* .

# Agrega los cambios al repositorio de despliegue
git add .
git commit -m "Deploy updated site"
git push origin "$BRANCH"
