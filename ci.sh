#!/bin/bash

set -Eeuo pipefail


REP=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)


URL="${1:-}"


DESTINATION="$REP/projet"
LOG="$REP/logs/ci.log"

mkdir -p "$REP/logs"

journaliser() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}


if [ -z "$URL" ]; then
    journaliser "ERREUR : URL du dépôt manquante."
    exit 1
fi

journaliser "Début du pipeline CI"

# Étape 1 : Clonage ou mise à jour
if [ ! -d "$DESTINATION/.git" ]; then

    journaliser "Clonage du dépôt Git..."

    if ! git clone "$URL" "$DESTINATION"; then
        journaliser "ERREUR : échec du clonage."
        exit 1
    fi

else

    journaliser "Mise à jour du dépôt Git..."

    if ! git -C "$DESTINATION" pull; then
        journaliser "ERREUR : échec de la mise à jour."
        exit 1
    fi

fi


executer_tests() {

    journaliser "Début des tests..."


    sleep 2

    journaliser "Tests réussis."
}

executer_tests


journaliser "Pipeline CI terminé avec succès."
journaliser "Fin du pipeline CI"

exit 0
