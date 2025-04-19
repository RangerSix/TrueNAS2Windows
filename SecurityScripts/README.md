# USE AT OWN RISK.
---
Below is a guide that documents how to use both PowerShell scripts for adding and enhancing Windows Defender Firewall rules to secure your TrueNAS connection on Windows 11.

---

# Windows Firewall Scripts for Securing TrueNAS SMB Connection

This repository contains two PowerShell scripts that help you configure Windows Defender Firewall rules to securely and specifically allow SMB traffic between your Windows 11 PC and your TrueNAS device.

- **Basic Script**: `Set-TruenasFirewallRules.ps1`  
  Creates inbound and outbound firewall rules to allow SMB (TCP port 445) traffic between your dedicated NIC and your TrueNAS IP address.

- **Enhanced Script**: `Set-TruenasFirewallRules1.ps1`  
  Adds additional customizations by restricting the rules to a specific network adapter (via its alias) and enabling firewall logging on the defined network profile.

---

## Prerequisites

- **Operating System**: Windows 11 (or Windows 10 with support for Windows Defender Firewall Advanced Security).
- **Permissions**: You must run these scripts as an Administrator.
- **PowerShell Version**: Use at least PowerShell 5.1 (included by default in Windows 11).
- **Configuration Details**:  
  - IP Address of the dedicated NIC on your Windows 11 PC (e.g., `192.168.100.20`).
  - Static IP address assigned to your TrueNAS device (e.g., `192.168.100.10`).
  - (For the enhanced script) The network adapter alias used for your dedicated NIC (e.g., `Ethernet 2`).

Before you run the scripts, update any variables in the header to reflect your specific network configuration if necessary.

---

## Repository Structure

- `Set-TruenasFirewallRules.ps1`  
  Basic firewall script that creates inbound and outbound rules targeting SMB traffic.

- `Set-TruenasFirewallRules1.ps1`  
  Enhanced version of the script which also restricts the rules to a specific network adapter alias and configures firewall logging.

---

## How to Use the Scripts:

### 2. Open PowerShell as Administrator

- Click on **Start**, type **PowerShell**.
- Right-click on **Windows PowerShell** and select **Run as administrator**.

### 3. Set the Execution Policy (If Necessary)

To allow running scripts, you may need to adjust the execution policy. (You can reset the policy after you’re finished.)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 4. Run the Basic Script

Navigate to the scripts folder in your elevated PowerShell window:
```powershell
cd path\to\scripts folder
```
Run the basic firewall script:
```powershell
.\Set-TruenasFirewallRules.ps1
```
You should see confirmation output indicating that the firewall rules for SMB traffic between your dedicated NIC (`192.168.100.20`) and the TrueNAS device (`192.168.100.10`) have been created.

### 5. Run the Enhanced Script

If you wish to include additional restrictions and logging, run the enhanced script:
```powershell
.\Set-TruenasFirewallRules1.ps1
```
This script will:
- Build inbound and outbound rules limited to the adapter alias you have specified (for example, `"Ethernet 2"`).
- Enable firewall logging on the defined network profile (by default, **Private**) and output logs to `C:\Windows\System32\LogFiles\Firewall\pfirewall.log`.

You will receive console messages confirming the creation of the enhanced firewall rules and the location of the log file.

---

## Customization

Both scripts have configurable sections at the top. Edit the following variables to suit your environment:

- **For Both Scripts:**
  - `$LocalIPAddress`: Your dedicated NIC's IP address (e.g., `"192.168.100.20"`).
  - `$TrueNASIPAddress`: Your TrueNAS device’s static IP (e.g., `"192.168.100.10"`).
  - `$SMBPort`: The port used for SMB (defaults to `445`).
  - `$Profile`: The network profile to apply the rules (commonly `"Private"`).

- **Enhanced Script Only:**
  - `$InterfaceAlias`: The network adapter alias used for your dedicated NIC (e.g., `"Ethernet 2"`).

After adjusting these variables in your preferred text editor, save the changes and re-run the scripts as described.

---

## Verification and Troubleshooting

- **Verifying Firewall Rules**  
  Open **Windows Defender Firewall with Advanced Security** (`wf.msc`) to review the newly created rules under **Inbound Rules** and **Outbound Rules**.

- **Testing Connectivity**  
  Attempt to access your TrueNAS SMB share via File Explorer using its IP address. For example:
  ```
  \\192.168.100.10\YourShareName
  ```

- **Checking Logs (Enhanced Script Users)**  
  Open the log file at `C:\Windows\System32\LogFiles\Firewall\pfirewall.log` to check for recorded firewall events. You can filter for port 445 or the relevant IP addresses.

- **Execution Policy Reminders**  
  If you encounter errors running the script, verify that the execution policy is set correctly and that you are operating with administrative privileges.

---

## Contributing

Contributions are welcome! If you have ideas to further enhance these scripts—such as more advanced logging configurations or additional protocol rules—feel free to open an issue or submit a pull request.

---

## License

This project is licensed under the MIT License. See `LICENSE` for details.
```

---

## Final Notes

Let me know if you'd like to add any further sections or details to the guide!
