# Auto-file-duplicator
This scirpt is made for linux - it will sync files from one folder to another folder locally



Instuctions:



```
sudo apt update
sudo apt upgrade
sudo apt install inotify-tools rsync
```

The .sh file goes /usr/local/bin/ 

The .service file goes /etc/systemd/system/

```
sudo chmod +x /usr/local/bin/watch-vault.sh
sudo systemctl daemon-reload
sudo systemctl enable --now watch-vault.service
```

watch-vault.sh should be added to path so you can run it anywhere in the terminal. Don't for get to reload your systemd daemon and enable the service

If you want to confirm you scirpt is running:
`systemctl status watch-vault.service`
