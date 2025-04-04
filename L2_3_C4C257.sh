#!/bin/bash
directorio="/home/gabriela-a/Documentos"

monitoreo="/home/gabriela-a/Documentos/monitor_log.txt"
echo "$(date) : Servicio de monitoreo iniciado en $directorio" >> "$monitoreo"
inotifywait -m -e create -e modify -e delete --format "%T %W%f %e" --timefmt "%Y-%m-%d %H:%M:%S" "$directorio" >> "$monitoreo"

