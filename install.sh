#!/bin/bash
if [ '$EUID' -ne 0 ]; then
  echo 'Relaunch with superuser!' >&2
  exit 1
fi

security_tools=('nmap' 'wireshark' 'nikto' 'hydra' 'metasploit')
network_tools=('curl' 'netcat' 'tcpdump' 'wget')
web_tools=('sqlmap' 'dirb' 'gobuster')

install_tools() {
  local tool_array=('$@')
  for tool in '${tool_array[@]}'; do
    if ! dpkg -l | grep -q '$tool'; then
      apt-get install -y '$tool'
      echo '$tool installed succesfully!'
    else
      echo '$tool already installed.'
    fi
  done
}

main() {
    echo 'Choose category to install:'
    echo '1. security tools'
    echo '2. network tools'
    echo '3. web tools'
    read -p 'Enter a number (1/2/3): ' category

    case '$category' in
        1)
            echo 'Installing security tools...' 
            install_tools '${security_tools[@]}'
            ;;
        2)
            echo 'Installing network tools...'
            install_tools '${network_tools[@]}'
            ;;
        3)
            echo 'Installing web tools...'
            install_tools '${web_tools[@]}'
            ;;
        *)
            echo 'Incorrect category number.'
            ;;
    esac
}

main()