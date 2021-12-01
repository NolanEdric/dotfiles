& "C:\Program Files\Docker\Docker\Docker Desktop.exe" -Autostart

sleep 10

wsl -d arch --cd ~ -- ipconfig.exe

if (!$?) {
    wsl --shutdown
}
