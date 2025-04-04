#!/bin/bash
#Recibo el nombre del proceso y lo ejecuto
proceso=$1
$1 &
sleep 1
PID=$(pidof -s "$proceso")
#Archivo log
archivo="log_registro.txt"
"TIEMPO CPU MEMORIA" > $archivo
#Monitoreo del proceso
while ps aux | awk '{print $2}' | grep -x "$PID" ; do
 TIEMPO=$(date +%S)
 USO_MEMORIA=$(ps -p $PID -o %cpu,%mem --no-headers) 
 echo "Ejecutando"
 CPU=$(echo $USO_MEMORIA | awk '{print $1}' )
 MEMORIA=$(echo $USO_MEMORIA | awk '{print $2}')
#Mando los datos al log
echo "$TIEMPO $CPU $MEMORIA" >> $archivo
 sleep 1
done
echo "Generando gráfico"
#Generacion del grafico
GRAFICO="plot.gp"
echo "
set title 'Consumo de CPU y de Memoria' 
set xlabel 'Tiempo (segundos)'
set ylabel 'Consumo(%)'
plot '$archivo' using 1:2 with lines title 'CPU', \
     '$archivo' using 1:3 with lines title  'MEMORIA' " > $GRAFICO
if [ -s "$archivo" ]; then
 gnuplot -persist $GRAFICO
else 
 echo "no hay datos"
fi


 
