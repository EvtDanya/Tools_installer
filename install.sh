#!/bin/bash

if (("$UID" != 0)); then
  echo "Relaunch with superuser!" >&2
  exit 1
fi

security_tools=("nmap" "metasploit")
network_tools=("curl" "netcat" "tcpdump" "wget" "wireshark")
web_tools=("sqlmap" "dirb" "gobuster" "nikto" "whatweb")
active_directory_tools=("enum4linux")
bruteforce_tools=("hashcat" "hydra" "hashid" "john")
wireless_attacks_tools=("aircrack" "wifite" \
"macchanger" "ettercap-graphical" "yersinia")
osint_tools=("recon-ng" "theharvester")

install_tools() {
  local tool_array=("$@")
  for tool in "${tool_array[@]}"; do
    if ! dpkg -l | grep -q "$tool"; then
      apt-get install -y "$tool"
    else
      echo "$tool already installed!"
    fi
  done
}

main() {
  printf "Made for kali linux!\n"
  printf "Its recommended to update" \
  "apt database before installing tools...\n";
  printf "To update use \'sudo apt-get update\'\n\n";
  select category in "security tools" "network tools" \
   "web tools" "active directory tools" "password attacks tools" \
   "wireless attacks tools" "osint tools"; do
    case $REPLY in
      1)
        printf "\nInstalling security tools...\n";
        install_tools "${security_tools[@]}";
        break;;
      2)
        printf "\nInstalling network tools...\n";
        install_tools "${network_tools[@]}";
        break;;
      3)
        printf "\nInstalling web tools...\n";
        install_tools "${web_tools[@]}";
        read -p "Install XSStrike tool from github (y/n): " choice
        if [ "$choice" == "y" ]; then
          printf "\nInstalling XSStrike tool..."
          apt-get install python3 python3-pip python3-dev libpcap-dev; 
          git clone https://github.com/s0md3v/XSStrike;
          cd XSStrike;
          pip3 install -r requirements.txt;
        fi
        break;;
      4)
        printf "\nInstalling active directory tools...\n";
        install_tools "${active_directory_tools[@]}";
        break;;
      5)
        printf "\nInstalling bruteforce tools...\n";
        install_tools "${bruteforce_tools[@]}";
        break;;
      6)
        printf "\nInstalling wireless attacks tools...\n";
        install_tools "${wireless_attacks_tools[@]}";
        break;;  
      7)
        printf "\nInstalling osint tools...\n";
        install_tools "${osint_tools[@]}";_
        read -p "Install Fast-Google-Dorks-Scan from github (y/n): " choice
        if [ "$choice" == "y" ]; then
          printf "\nInstalling Fast-Google-Dorks-Scan..."
          git clone https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan;
        fi
        break;;  
      *) 
        printf "\nIncorrect category number!\n";;
    esac
  done
}

main
