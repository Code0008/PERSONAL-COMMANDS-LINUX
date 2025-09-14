#!/bin/bash

# Script: vpnconnect
# Descripción: Selecciona e inicia una conexión VPN, luego sale automáticamente

VPN_DIR="/home/kali/vpns"
LOG_FILE="/tmp/vpn_connection.log"

# Colores para la interfaz
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Detener todas las conexiones VPN activas
stop_vpn() {
    sudo pkill openvpn >/dev/null 2>&1
    for tun in $(ip tuntap show 2>/dev/null | grep -oP 'tun\d+'); do
        sudo ip tuntap del mode tun dev $tun >/dev/null 2>&1
    done
    > "$LOG_FILE"
}

# Mostrar menú de VPN disponibles
show_menu() {
    clear
    echo -e "\n${YELLOW}=== CONFIGURACIONES VPN DISPONIBLES ===${NC}"
    
    local i=1
    for vpn in "$VPN_DIR"/*.ovpn; do
        echo "[$i] $(basename "$vpn" .ovpn)"
        ((i++))
    done
    
    echo -e "\n[0] Salir"
    echo -e "${YELLOW}======================================${NC}"
}

# Función principal
main() {
    # Verificar requisitos básicos
    if ! command -v openvpn &> /dev/null; then
        echo -e "${YELLOW}Error: OpenVPN no está instalado.${NC}" >&2
        exit 1
    fi

    if [ ! -d "$VPN_DIR" ] || [ -z "$(ls "$VPN_DIR"/*.ovpn 2>/dev/null)" ]; then
        echo -e "${YELLOW}Error: No se encontraron configuraciones VPN.${NC}" >&2
        exit 1
    fi

    show_menu
    read -p "Selecciona una VPN [0-$(ls "$VPN_DIR"/*.ovpn | wc -l)]: " choice
    
    if [[ $choice == 0 ]]; then
        echo -e "${YELLOW}Saliendo sin conectar...${NC}" >&2
        exit 0
    elif [[ $choice =~ ^[0-9]+$ ]] && [ $choice -le $(ls "$VPN_DIR"/*.ovpn | wc -l) ]; then
        selected_vpn=$(ls "$VPN_DIR"/*.ovpn | sed -n "${choice}p")
        echo -e "${GREEN}Iniciando $(basename "$selected_vpn" .ovpn)...${NC}" >&2
        
        stop_vpn
        
        # Iniciar conexión VPN silenciosamente
        sudo openvpn --config "$selected_vpn" --daemon --log "$LOG_FILE" >/dev/null 2>&1
        
        echo -e "${GREEN}Conexión iniciada. Saliendo del programa.${NC}" >&2
        exit 0
    else
        echo -e "${YELLOW}Opción inválida. Saliendo.${NC}" >&2
        exit 1
    fi
}

main
