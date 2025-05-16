#!/bin/bash

# Colores ANSI usando \e
ve='\e[1;32m'
azul='\e[1;34m'
rojo='\e[1;31m'
reset='\e[0m'



# Función para imprimir línea animada
animar_linea() {
    texto="$1"
    for ((i = 0; i < ${#texto}; i++)); do
        echo -ne "${texto:$i:1}"
        sleep 0.06
    done
    echo
}

clear

# Mostrar banner
echo -e "${azul}╔══════════════════════════════════════════════╗"
animar_linea   "║      BIENVENIDO AL SCRIPT DE NMAP            ║"
animar_linea   "║ Desarrollado por: Alfonso Company Rodriguez  ║"
echo -e "${azul}╚══════════════════════════════════════════════╝${reset}"

sleep 1
echo





sin_color='\033[0m'
rojo_luminoso='\033[1;31m'
cyan_luminoso='\033[1;36m'

# Para ingresar poner el comando ./nmap.sh



# Crea la funcion para la barra de progreso
mostrar_barra() {
    local duracion=$1
    local progreso=0
    local ancho=50

    while [ $progreso -le $duracion ]; do
        porcentaje=$(( 100 * progreso / duracion ))
        completado=$(( ancho * progreso / duracion ))
        restante=$(( ancho - completado ))

        barra=$(printf "%${completado}s" | tr ' ' '#')
        espacio=$(printf "%${restante}s" | tr ' ' '-')

        printf "\r[%s%s] %d%%" "$barra" "$espacio" "$porcentaje"

 	        sleep 1
       		 ((progreso++))
    		 done
    		 echo ""
		}


if [ $(id -u) -ne 0 ]; then
       	echo -e "${rojo_luminoso}  Debes ser usuario root para ejecutar el script${sin_color}"
	exit

	fi
test -f /usr/bin/nmap
if [ "$(echo $?)" == "0" ]; then
        
 echo "  (Formato 0.0.0.0)"
# animar_linea "INtroduce la IP a escanear:  "
# read -p ">>" ip
 

# COMPROBACION SI TENEMOS CONEXION
while true; do
    animar_linea "INtroduce la IP a escanear:  "
    read -p ">>" ip

    # Intentar ping con timeout
    if ping -c 1 -W 2 "$ip" >/dev/null 2>&1; then
        echo -e "${ve}✅ Conexión exitosa con $ip${sin_color} "
        break  # Salimos del bucle si hay conexión
    else
        echo -e "${rojo_luminoso}❌ Error: No se pudo establecer conexión con $ip${sin_color}"
        sleep 1  # Esperamos un segundo antes de volver a pedir
    fi
done



 echo "   (ejemplo: /home/kali/Escaners/)"
 

while true; do
    animar_linea "INtroduce el Directorio destino  " 
    read -p ">>" destino

    if [ -d "$destino" ]; then
        echo  -e "${ve}El directorio '$destino' existe.${sin_color}"
        break
    else
        echo -e "${rojo_luminoso}❌ El directorio no existe. Intenta de nuevo.${sin_color}"
        sleep 1
    fi
done


# COMPROBAR LOS EQUIPOS QUE ESTAN EN MI RED
# Nombre del archivo de salida
output_file=$destino"equipos_en_red.txt"

# Descubre la IP local y la subred
ip_local=$(hostname -I | awk '{print $1}')
subred=$(echo "$ip_local" | cut -d"." -f1-3)".0/24"

echo "Escaneando la red: $subred"
echo "Fecha del escaneo: $(date)" >> "$output_file"
echo "Red escaneada: $subred" >> "$output_file"
echo "-------------------------------" >> "$output_file"





 

           while true; do

echo -e "╔══════════════════════════════════════════════╗"
echo -e "║             MODELOS DE ESCANEOS              ║"
echo -e "║     (Escaneados prefijados s/necesidad)      ║"
echo -e "╚══════════════════════════════════════════════╝"
        
        echo -e "\n1) Equipos en red Local"
        echo "2) Escaneo rapido potente muy ruidoso"
        echo "3) Escaneo Normal"
        echo "4) Escaneo silencioso (Puede tardar un poco mas de lo normal)"
        echo "5) Escaneo de servicios y versiones"
        echo "6) Ver archibos Escaneados"        
        echo "7) SALIR"
        read -p "Selecciones una opcion: >>" opcion
        case $opcion in

    1) clear && nmap -sn "$subred" | tee -a "$output_file" && echo "Escaneo completado. Los equipos encontrados se han guardado en $output_file"
    
     ;;



  2)
     clear && echo -e "${cyan_luminoso}Escaneando..." && mostrar_barra 1 && 
     nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v $ip > escaneo_potente.txt &&
     echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_potente${sin_color}" && mv escaneo_potente.txt  $destino 
    
    ;;
  3) clear && echo -e "${cyan_luminoso}Escaneando..." && mostrar_barra 2 &&
    nmap -p- --open $ip > escaneo_normal.txt && 
    echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_normal${sin_color}" && mv escaneo_normal.txt  $destino 
    
    ;;
  
  4)
    clear && echo  -e "${cyan_luminoso}Escaneando..."  &&
    nmap -p- -T3 -sS -Pn -f $ip > escaneo_silencioso.txt && mostrar_barra 1 && 
     echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_silencios${sin_color}" && mv escaneo_silencioso.txt  $destino 
    
    ;;
  5)
    clear && echo  -e "${cyan_luminoso}Escaneando..."  && 
    nmap -sV -sC  $ip > escaneo_servicios.txt && mostrar_barra 3 &&
    echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_servicios${sin_color}" && mv escaneo_servicios.txt  $destino 
    
    ;;
 
  6) clear &&
     
       
   
        echo '============================================================'
        echo '                   ARCHIVOS ESCANEADOS             '
        echo '============================================================'

        echo -e "\n1) Escaneo rapido "
        echo "2) Escaneo Normal"
        echo "3) Escaneo silencioso "
        echo "4) Escaneo de servicios y versiones"
        echo "5) SALIR"
        read -p "Selecciones una opcion: >> " opcion
        
          if [ "$opcion" -eq 1 ]; then
            clear   
            cat $destino"escaneo_potente.txt"   
         fi
           if [ "$opcion" -eq 2 ]; then
            clear
            cat $destino"escaneo_normal.txt" 
         fi

          if [ "$opcion" -eq 3 ]; then
            clear
            cat $destino"escaneo_silencioso.txt" 
         fi 

          if [ "$opcion" -eq 4 ]; then
            clear
            cat $destino"escaneo_servicios.txt" 
         fi
         if [ "$opcion" -eq 5 ]; then
            clear
            
         fi
    ;;        
   7)
    break
    ;;


  *)
    echo -e "No se ha encontrado el parametro, introduce un valor correcto"
    ;;
     	 esac
  done
else

 	echo -e "\n[!] Hay que instalar dependencias" && apt update >/dev/null & apt install nmap -y >/dev/null && echo -e "\nDependencias instaladas"
fi
    


