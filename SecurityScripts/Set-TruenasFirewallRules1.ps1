# --- Configuration Variables ---
$LocalIPAddress    = "192.168.100.20"    # Dedicated Windows NIC IP for the direct connection
$TrueNASIPAddress  = "192.168.100.10"    # Static IP of your TrueNAS
$SMBPort           = 445                 # TCP port for SMB
$Profile           = "Private"           # Network profile; adjust if needed (Domain, Private, Public)
$InterfaceAlias    = "HomeNAS"        # Adapter alias for your dedicated NIC (adjust as seen in "Network Connections")

# --- Clean-up Existing Rules ---
# Removes any existing rules with the specific display names to avoid duplicates.
Get-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Inbound)" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Outbound)" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

# --- Create Inbound Rule with Interface Alias Restriction ---
New-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Inbound)" `
    -Direction Inbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort $SMBPort `
    -LocalAddress $LocalIPAddress `
    -RemoteAddress $TrueNASIPAddress `
    -InterfaceAlias $InterfaceAlias `
    -Profile $Profile `
    -EdgeTraversalPolicy Block

# --- Create Outbound Rule with Interface Alias Restriction ---
New-NetFirewallRule -DisplayName "Allow SMB Traffic from TrueNAS (Outbound)" `
    -Direction Outbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort $SMBPort `
    -LocalAddress $LocalIPAddress `
    -RemoteAddress $TrueNASIPAddress `
    -InterfaceAlias $InterfaceAlias `
    -Profile $Profile `
    -EdgeTraversalPolicy Block

# --- Enable Firewall Logging on the Selected Profile ---
# This command enables logging of both allowed and blocked connections on your Private profile.
Set-NetFirewallProfile -Profile $Profile `
    -LogAllowed True `
    -LogBlocked True `
    -LogFileName "C:\Windows\System32\LogFiles\Firewall\pfirewall.log" `
    -LogMaxSizeKilobytes 16384

Write-Output "Enhanced firewall rules for SMB traffic have been created."
Write-Output "Rules apply to network adapter '$InterfaceAlias' with local IP $LocalIPAddress and restrict remote traffic to $TrueNASIPAddress."
Write-Output "Firewall logging is enabled on the $Profile profile. Check the log file at C:\Windows\System32\LogFiles\Firewall\pfirewall.log."