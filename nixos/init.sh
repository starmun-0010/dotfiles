sudo systemctl mask systemd-networkd-wait-online.service
sudo apt install xorg

           
sudo groupadd uinput
sudo groupadd input

sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/kanata

sudo modprobe uinput

