# Auto-file-duplicator
This scirpt is made for linux - it will sync files from one folder to another folder locally



Instuctions:

sudo apt install inotify-tools rsync


The .sh file goes /usr/local/bin/
the .service file goes /etc/systemd/system/watch-vault.service


sudo chmod +x /usr/local/bin/watch-vault.sh
sudo systemctl daemon-reload
sudo systemctl enable --now watch-vault.service
