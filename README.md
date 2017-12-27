# Shadowsocks-Client-Start-Scrpit

##Who needs this:
  People who constantly facing the issue "Shadowsocks Error: Port Already in Use" when using Shadowsocks Windows GUI client

##What it does:
  The script gets the local proxy port from gui-config.json in the same folder
  Or use default 1080 port if no config file or it failed to do so
 
  It force kills whatever process that uses Shadowsocks client local proxy port
  Unless the process is called "Shadowsocks.exe"
  Then it starts shadowsocks for you

##How to use:
  Put this batch script in the SAME FOLDER of Shadowsocks.exe and run it as admin 
