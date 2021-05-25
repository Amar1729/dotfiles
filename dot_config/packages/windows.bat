REM install chocolatey:
Set-ExecutionPolicy Bypass -Scope Process -Force; `
>>   iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

REM (this is a comment)
REM consider running this for make:
REM choco install gnumake

REM install openssh server and enable port 22
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH SSH Server' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

Add-WindowsCapability -Online -Name OpenSSH.Server*

REM start this shit on boot
Set-Service -name sshd -StartupType Automatic

REM install some other helpful stuff:
choco install git

REM disable hyper-v if you want to run docker stuff
REM Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor 
REM check on this: might not be the one you want to install
REM choco install docker-toolbox
