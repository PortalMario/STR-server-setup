#!/bin/bash
USER=$(whoami)
if [ "$USER" != "root" ]; then
    echo "You need to be root."
    exit 1
fi

# System Update
if apt update && apt upgrade -y && apt autoremove -y; then
    echo "System Update Complete!"
else
    echo "System Update Failed!"
    exit 2
fi

gameserver_setup () {
    # Install Docker, set permissions, create paths.
    echo "Please enter your primary username: (not root)"
    read -r username

    mkdir -p /opt/docker/skyrimserver/{config,Data,logs} 
    chown -R "$username":"$username" /opt/docker 

    apt install -y apt-transport-https ca-certificates curl software-properties-common || exit 3
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update

    if apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin; then
        echo "Docker installation done."
    else
        echo "Docker installation failed!"
        exit 90
    fi
    usermod -aG docker "$username"
}

configure_gameserver () {
    # Open Firewall.
    docker stop skyrimserver
    ufw allow 10578

    echo "You can now configure the port forwarding on your router."
    echo "Internal Server IP-Address: $(hostname -I | sed -s 's/\s//g' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -n1)"

    echo "After you started the server again, friends can connect to the server via: "
    echo "External Server IP-Address: $(curl -4 icanhazip.com):10578" 
}

if gameserver_setup; then
    echo "gameserver installation is done."
    echo "Starting server..."
    sudo -u "$username" docker run -d -it --name skyrimserver -p 10578:10578/udp -v /opt/docker/skyrimserver/config:/home/server/config -v /opt/docker/skyrimserver/Data:/home/server/Data -v /opt/docker/skyrimserver/logs:/home/server/logs tiltedphoques/st-reborn-server:latest
    configure_gameserver
else
    echo "ERROR: gameserver installation failed!"
fi