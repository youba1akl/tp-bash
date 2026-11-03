#!/bin/bash


set -Eeuo pipefail


DOSSIER="$1"


DESTINATION="./backups"


if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas." >&2
    exit 1
fi


mkdir -p "$DESTINATION"


DATE=$(date +%Y-%m-%d_%H-%M-%S)


NOM=$(basename "$DOSSIER")


ARCHIVE="$DESTINATION/${NOM}_${DATE}.tar.gz"

tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde créée : $ARCHIVE"


for fichier in "$DESTINATION"/*.tar.gz; do

    
    [ -e "$fichier" ] || continue

    
    find "$fichier" -mtime +7 -exec rm {} \;

done

echo "Nettoyage terminé."
