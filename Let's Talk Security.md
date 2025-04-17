Securing and isolating the connection between your Windows 11 PC and TrueNAS Scale involves both logical and physical measures so that only your chosen devices can access the storage and no unwanted traffic leaks between your broader network and the dedicated link. Here’s how you can accomplish that:

---

### 1. **Physical and Network Segmentation**

- **Dedicated NIC with No Gateway:**  
  You’ve already set up a dual-NIC configuration on your Windows 11 machine. For the NIC directly connected to TrueNAS, ensure you have manually configured its IP without a default gateway. This prevents Windows from trying to route any non-local traffic via that connection, keeping the TrueNAS link fully isolated from the internet.

- **Direct or Isolated Connection:**  
  When connecting with a direct cable or through an isolated switch (or a dedicated VLAN on your router/switch), you guarantee that traffic on this segment is kept separate from your primary network. If you have managed switches, consider creating a dedicated VLAN for your TrueNAS connection and assign it only to those ports associated with your TrueNAS device and trusted PC.

---

### 2. **Windows 11 Firewall Configuration**

- **Interface-Specific Rules:**  
  In Windows Defender Firewall, you can create inbound and outbound rules that apply specifically to your dedicated NIC’s IP subnet (for example, the 192.168.100.x range). This way, you can allow only the necessary traffic—such as SMB or HTTPS (if accessing the TrueNAS web UI)—from the TrueNAS IP and block any other unsolicited traffic.
  
  **Example:**  
  Open **Windows Defender Firewall with Advanced Security** and create a new **Inbound Rule** that allows traffic on specific ports (like port 445 for SMB) only from the TrueNAS IP (e.g., 192.168.100.10). Similarly, create an **Outbound Rule** if you want to restrict traffic initiated from the PC over that NIC.

- **Disable Network Discovery:**  
  For the dedicated NIC, you might want to turn off network discovery. This reduces the chance that other devices (if accidentally connected to the same switch/VLAN) can see or interact with your TrueNAS share.

---

### 3. **TrueNAS Scale Security Best Practices**

- **SMB Share Permissions and Encryption:**  
  When setting up your SMB share:
  - **User Authentication:** Limit access by creating and using dedicated usernames and strong passwords. Adjust dataset permissions so that only authorized users (your Windows account) can read or write data.
  - **SMB Encryption:** If your TrueNAS Scale version and SMB protocol support it (SMB 3.x features), enable encryption on the SMB share. This encrypts the data in transit between the PC and TrueNAS, even over a direct link.

- **Local Firewall or IP Filtering on TrueNAS:**  
  Although TrueNAS Scale traditionally operates with an open network interface for management, you can add extra layers of security:
  - Use a firewall utility (such as configuring iptables or nftables if you’re comfortable on the command line) to restrict connections on the dedicated management interface so that only your Windows PC IP (or the 192.168.100.x subnet) is allowed.
  - Some configurations let you apply access control lists (ACLs) at the service level (for example, limiting allowed hosts for the SMB service).

- **SSL/HTTPS for Web Access:**  
  Make sure that access to the TrueNAS web interface is secured via HTTPS. Check that you use a proper certificate if available, or at the very least a self-signed certificate with warnings appropriately managed. That ensures that administrative sessions are encrypted.

---

### 4. **Additional Measures for Isolation and Monitoring**

- **Route Metrics and Network Profiles:**  
  Verify that Windows uses the intended NIC for internet traffic and doesn’t inadvertently route any sensitive administrative traffic through the direct link. You can adjust interface metrics via the network adapter properties if needed.

- **Regular Auditing and Updates:**  
  Regularly check your TrueNAS and Windows logs for unauthorized access attempts. Keep both systems updated with the latest security patches to minimize vulnerabilities.

---

Each of these measures adds a layer of protection, ensuring that your direct connection is maximally isolated and secure against intrusion. 