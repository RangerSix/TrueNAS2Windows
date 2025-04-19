# Configuration
$LocalIPAddress   = "192.168.100.20"  # Your dedicated Windows NIC IP
$TrueNASIPAddress = "192.168.100.10"  # The static IP of your TrueNAS
$SMBPort          = 445               # SMB uses TCP port 445
$Profile          = "Private"         # Change as needed (Domain, Private, Public)

# Remove any existing rules with the same display names to avoid duplicates
Get-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Inbound)" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Outbound)" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

# Create an Inbound rule for SMB traffic from TrueNAS
New-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Inbound)" `
    -Direction Inbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort $SMBPort `
    -LocalAddress $LocalIPAddress `
    -RemoteAddress $TrueNASIPAddress `
    -Profile $Profile `
    -EdgeTraversalPolicy Block

# Create an Outbound rule for SMB traffic to TrueNAS
New-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Outbound)" `
    -Direction Outbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort $SMBPort `
    -LocalAddress $LocalIPAddress `
    -RemoteAddress $TrueNASIPAddress `
    -Profile $Profile `
    -EdgeTraversalPolicy Block

Write-Output "Firewall rules for SMB between $LocalIPAddress and $TrueNASIPAddress have been created."