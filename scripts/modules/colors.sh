#!/bin/bash
# -----------------------
#   Bash Colors Module
# -----------------------
# Descrizione   : Definizione delle costanti di colore per l'output su terminale
# Autore        : Vincenzo Bonura
# Data          : 2025-03-17
# Aggiornato    : 2025-06-19
# Versione      : 0.1.2
# -----------------------

# Reset
if [[ -z "${NC:-}" ]]; then readonly NC='\033[0m'; fi

# Colori standard
if [[ -z "${BLACK:-}" ]]; then readonly BLACK='\033[0;30m'; fi
if [[ -z "${RED:-}" ]]; then readonly RED='\033[0;31m'; fi
if [[ -z "${GREEN:-}" ]]; then readonly GREEN='\033[0;32m'; fi
if [[ -z "${YELLOW:-}" ]]; then readonly YELLOW='\033[0;33m'; fi
if [[ -z "${BLUE:-}" ]]; then readonly BLUE='\033[0;34m'; fi
if [[ -z "${PURPLE:-}" ]]; then readonly PURPLE='\033[0;35m'; fi
if [[ -z "${CYAN:-}" ]]; then readonly CYAN='\033[0;36m'; fi
if [[ -z "${LIGHTGRAY:-}" ]]; then readonly LIGHTGRAY='\033[0;37m'; fi

# Colori scuri
if [[ -z "${DARKGRAY:-}" ]]; then readonly DARKGRAY='\033[0;90m'; fi
if [[ -z "${LIGHTRED:-}" ]]; then readonly LIGHTRED='\033[0;91m'; fi
if [[ -z "${LIGHTGREEN:-}" ]]; then readonly LIGHTGREEN='\033[0;92m'; fi
if [[ -z "${LIGHTYELLOW:-}" ]]; then readonly LIGHTYELLOW='\033[0;93m'; fi
if [[ -z "${LIGHTBLUE:-}" ]]; then readonly LIGHTBLUE='\033[0;94m'; fi
if [[ -z "${LIGHTPURPLE:-}" ]]; then readonly LIGHTPURPLE='\033[0;95m'; fi
if [[ -z "${LIGHTCYAN:-}" ]]; then readonly LIGHTCYAN='\033[0;96m'; fi
if [[ -z "${WHITE:-}" ]]; then readonly WHITE='\033[0;97m'; fi

# Background
if [[ -z "${BGBLACK:-}" ]]; then readonly BGBLACK='\033[40m'; fi
if [[ -z "${BGRED:-}" ]]; then readonly BGRED='\033[41m'; fi
if [[ -z "${BGGREEN:-}" ]]; then readonly BGGREEN='\033[42m'; fi
if [[ -z "${BGYELLOW:-}" ]]; then readonly BGYELLOW='\033[43m'; fi
if [[ -z "${BGBLUE:-}" ]]; then readonly BGBLUE='\033[44m'; fi
if [[ -z "${BGPURPLE:-}" ]]; then readonly BGPURPLE='\033[45m'; fi
if [[ -z "${BGCYAN:-}" ]]; then readonly BGCYAN='\033[46m'; fi
if [[ -z "${BGLIGHTGRAY:-}" ]]; then readonly BGLIGHTGRAY='\033[47m'; fi

if [[ -z "${BGDARKGRAY:-}" ]]; then readonly BGDARKGRAY='\033[100m'; fi
if [[ -z "${BGLIGHTRED:-}" ]]; then readonly BGLIGHTRED='\033[101m'; fi
if [[ -z "${BGLIGHTGREEN:-}" ]]; then readonly BGLIGHTGREEN='\033[102m'; fi
if [[ -z "${BGLIGHTYELLOW:-}" ]]; then readonly BGLIGHTYELLOW='\033[103m'; fi
if [[ -z "${BGLIGHTBLUE:-}" ]]; then readonly BGLIGHTBLUE='\033[104m'; fi
if [[ -z "${BGLIGHTPURPLE:-}" ]]; then readonly BGLIGHTPURPLE='\033[105m'; fi
if [[ -z "${BGLIGHTCYAN:-}" ]]; then readonly BGLIGHTCYAN='\033[106m'; fi
if [[ -z "${BGWHITE:-}" ]]; then readonly BGWHITE='\033[107m'; fi

# Stili di testo
if [[ -z "${BOLD:-}" ]]; then readonly BOLD='\033[1m'; fi
if [[ -z "${UNDERLINE:-}" ]]; then readonly UNDERLINE='\033[4m'; fi
if [[ -z "${BLINK:-}" ]]; then readonly BLINK='\033[5m'; fi
if [[ -z "${REVERSE:-}" ]]; then readonly REVERSE='\033[7m'; fi

# Helper per testo colorato
print_color() {
    local no_newline=false
    local color
    local text
    
    # Controlla se il primo parametro è -n
    if [[ "$1" == "-n" ]]; then
        no_newline=true
        color="$2"
        text="$3"
    else
        color="$1"
        text="$2"
    fi
    
    # Stampa con o senza newline
    if [[ "$no_newline" == true ]]; then
        echo -n -e "${color}${text}${NC}"
    else
        echo -e "${color}${text}${NC}"
    fi
}

# Helper per stili comuni
print_info() {
    print_color "$CYAN" "$1"
}

print_success() {
    print_color "$GREEN" "$1"
}

print_warning() {
    print_color "$YELLOW" "$1"
}

print_error() {
    print_color "$RED" "$1"
}

print_debug() {
    print_color "$DARKGRAY" "$1"
}

# Test di verifica del modulo, se non è incluso con source
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "---"
    echo "Test del modulo colors.sh"
    echo ""
    echo -e "${RED}Rosso${NC} ${GREEN}Verde${NC} ${YELLOW}Giallo${NC}"
    echo -e "${BLUE}Blu${NC} ${PURPLE}Viola${NC} ${CYAN}Ciano${NC}"
    echo -e "${DARKGRAY}Grigio scuro${NC} ${LIGHTGRAY}Grigio chiaro${NC}"
    echo -e "${BOLD}Grassetto${NC} ${UNDERLINE}Sottolineato${NC}"
    echo "---"
    print_info "Messaggio informativo"
    print_success "Operazione riuscita"
    print_warning "Attenzione"
    print_error "Errore"
    print_debug "Debug"
    echo "---"
fi 