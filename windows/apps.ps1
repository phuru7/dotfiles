﻿# Create temporary folder
$tempFolder = "c:\tmp\"
if (-not (Test-Path -Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

# Configure TLS 1.2 once
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Function to download and install applications
function Install-Application {
    param (
        [string]$Name,
        [string]$Url,
        [string]$Filename,
        [string]$Arguments = '',
        [bool]$IsMsi = $false
    )
    
    Write-Host "Installing $Name..."
    $path = Join-Path -Path $tempFolder -ChildPath $Filename
    
    try {
        # Download
        Invoke-WebRequest -Uri $Url -OutFile $path
        
        # Install
        if ($IsMsi) {
            $processArgs = "/i `"$path`" $Arguments"
            Start-Process -FilePath "msiexec.exe" -ArgumentList $processArgs -Wait
        } else {
            if ($Arguments) {
                Start-Process -FilePath $path -ArgumentList $Arguments -Wait
            } else {
                Start-Process -FilePath $path -Wait
            }
        }
        
        Write-Host "✓ $Name successfully installed" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Error installing $Name: $_" -ForegroundColor Red
    }
}

# List of applications to install
$applications = @(
    @{
        Name = "Brave Browser"
        Url = "https://laptop-updates.brave.com/latest/winx64"
        Filename = "brave.exe"
        Arguments = "/silent /install"
    },
    @{
        Name = "1Password"
        Url = "https://downloads.1password.com/win/1PasswordSetup-latest.exe"
        Filename = "1PasswordSetup.exe"
        Arguments = "--silent"
    },
    @{
        Name = "Notion"
        Url = "https://www.notion.so/desktop/windows/download"
        Filename = "notion.exe"
        Arguments = "/S"
    },
    @{
        Name = "JBL Quantum ENGINE"
        Url = "https://storage.harman.com/downloads/JBL_QuantumENGINE_1.6.0.1053_x64.exe"
        Filename = "jbl.exe"
        Arguments = "/S"
    },
    @{
        Name = "Logitech G HUB"
        Url = "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe"
        Filename = "logitechub.exe"
        Arguments = "/S"
    },
    @{
        Name = "Logitech Options+"
        Url = "https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.exe"
        Filename = "logioptions.exe"
        Arguments = "/quiet"
    },
    @{
        Name = "Corsair iCUE"
        Url = "https://downloads.corsair.com/Files/CUE/iCUESetup_4.13.223_release.msi"
        Filename = "corsair.msi"
        Arguments = "/quiet"
        IsMsi = $true
    },
    @{
        Name = "Dropbox"
        Url = "https://www.dropbox.com/download?os=win"
        Filename = "dropbox.exe"
        Arguments = "/S"
    },
    @{
        Name = "7-Zip"
        Url = "https://www.7-zip.org/a/7z2408-x64.exe"
        Filename = "7zip.exe"
        Arguments = "/S"
    },
    @{
        Name = "Lightshot"
        Url = "https://app.prntscr.com/build/setup-lightshot.exe"
        Filename = "lightshot.exe"
        Arguments = "/S"
    },
    @{
        Name = "Microsoft Teams"
        Url = "https://go.microsoft.com/fwlink/p/?LinkID=869426&culture=es-mx&country=WW&lm=deeplink&lmsrc=groupChatMarketingPageWeb&cmpid=directDownloadWin64"
        Filename = "teams.exe"
        Arguments = "--silent"
    },
    @{
        Name = "Zoom"
        Url = "https://zoom.us/client/5.7.1.543/ZoomInstaller.exe?archType=x64"
        Filename = "zoom.exe"
        Arguments = "/silent"
    },
    @{
        Name = "Todoist"
        Url = "https://todoist.com/windows_app"
        Filename = "todoist.exe"
        Arguments = "/S"
    },
    @{
        Name = "Telegram"
        Url = "https://telegram.org/dl/desktop/win64"
        Filename = "telegram.exe"
        Arguments = "/VERYSILENT"
    },
    @{
        Name = "VLC Media Player"
        Url = "https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe"
        Filename = "vlc.exe"
        Arguments = "/S"
    },
    @{
        Name = "Spotify"
        Url = "https://download.scdn.co/SpotifySetup.exe"
        Filename = "spotify.exe"
        Arguments = "/silent"
    }
)

# Install each application
foreach ($app in $applications) {
    Install-Application -Name $app.Name -Url $app.Url -Filename $app.Filename -Arguments $app.Arguments -IsMsi ($app.IsMsi -eq $true)
}

# Delete temporary folder
if (Test-Path -Path $tempFolder) {
    Remove-Item -LiteralPath $tempFolder -Force -Recurse
    Write-Host "✓ Temporary folder removed" -ForegroundColor Green
}

Write-Host "All installations completed." -ForegroundColor Cyan