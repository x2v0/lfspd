# STEP 1: Enable Virtual Machine Platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# STEP 2: Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# STEP 3: Restart Windows Machine

# STEP 4: To set the WSL default version to 2.
# Any distribution installed after this, would run on WSL 2
wsl --set-default-version 2
