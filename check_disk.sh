
#!/bin/bash

SEUIL="${1:-80}"

VAR=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$VAR" -ge "$SEUIL" ]; then
    echo "Alerte : disque utilisé à ${VAR}%"
    exit 1
else
    echo "OK : disque utilisé à ${VAR}%"
    exit 0
fi

