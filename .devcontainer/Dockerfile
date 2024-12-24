FROM mcr.microsoft.com/windows/servercore:ltsc2025

SHELL ["powershell", "-Command"]

# Create a non-admin user
RUN New-LocalUser -Name "dev" -FullName "Development User" -Description "Non-admin user for container"; \
    Add-LocalGroupMember -Group "Users" -Member "dev"

# Install winget and required tools
RUN Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle; \
    Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle; \
    winget install -e --id Python.Python.3.11 --accept-source-agreements --accept-package-agreements; \
    winget install -e --id Rustlang.Rust --accept-source-agreements --accept-package-agreements; \
    Invoke-WebRequest -Uri https://pixi.sh/install.ps1 -OutFile install.ps1; \
    .\install.ps1; \
    Invoke-WebRequest -Uri https://mise.jdx.dev/install.ps1 -OutFile mise-install.ps1; \
    .\mise-install.ps1

# Initialize mise
RUN mise install

# Switch to the non-admin user
USER dev

ENTRYPOINT ["mise", "activate"]
CMD ["pwsh"]