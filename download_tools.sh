#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Banner
clear
echo -e "${GREEN}CTF & Pentesting Install Script${NC}"
echo "Select the tools you want to install:"
echo "1) Install All"
echo "2) Select Specific Tools"
read -p "Choose an option (1 or 2): " choice

tools=(
    "nmap" "masscan" "rustscan" "amass" "subfinder" "dirsearch" "feroxbuster"
    "sqlmap" "wfuzz" "xsstrike" "commix" "paramspider" "nuclei" "ffuf" "xray"
    "impacket" "bloodhound-python" "crackmapexec" "ldapdomaindump" "nishang"
    "powersploit" "smbmap" "enum4linux-ng" "evil-winrm" "bloodyAD" "PowerShell Empire"
    "linpeas" "winpeas" "pspy" "GTFOBins" "pwnkit" "DirtyPipe" "kernel-exploits"
    "john" "hashcat" "kerbrute" "hydra" "cewl" "wordlistctl" "rsmangler" "hash-identifier"
    "volatility3" "autopsy" "foremost" "exiftool" "strings" "bulk_extractor" "ghex"
    "theharvester" "metagoofil" "maltego"
    "gdb" "gef" "pwndbg" "radare2" "binwalk" "ghidra" "ROPgadget" "angr" "pwntools"
    "aircrack-ng" "bettercap" "hcxdumptool" "reaver" "pixiewps" "wifite"
)

tools_pip=(
    "bloodhound-python" "impacket" "pwntools" "angr"
)

if [ "$choice" == "1" ]; then
    echo -e "${GREEN}Installing all tools...${NC}"
    sudo apt update && sudo apt upgrade -y
    for tool in "${tools[@]}"; do
        sudo apt install -y $tool
    done
    for pip_tool in "${tools_pip[@]}"; do
        pip3 install --upgrade $pip_tool
    done
    echo -e "${GREEN}Installation complete!${NC}"
    exit 0
fi

if [ "$choice" == "2" ]; then
    echo "Choose tools to install (separate numbers with spaces):"
    count=1
    for tool in "${tools[@]}"; do
        echo "$count) $tool"
        ((count++))
    done
    read -p "Enter numbers: " selection
    echo -e "${GREEN}Installing selected tools...${NC}"
    sudo apt update && sudo apt upgrade -y
    for index in $selection; do
        tool=${tools[$((index-1))]}
        sudo apt install -y $tool
    done
    echo -e "${GREEN}Installation complete!${NC}"
    exit 0
fi

echo -e "${RED}Invalid selection. Exiting.${NC}"
