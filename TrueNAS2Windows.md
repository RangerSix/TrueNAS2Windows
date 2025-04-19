Below is a guide that walks you through setting up a direct connection between TrueNAS Scale and a Windows 11 PC without using a switch. This configuration is ideal for home lab environments where you want lightning-fast transfers, complete isolation from the Internet on your NAS connection, and overall network efficiency.

---

# Direct Connection from TrueNAS Scale to Windows 11 PC

This guide details the process of connecting a TrueNAS Scale system directly to a Windows 11 PC using two separate network interfaces. One NIC on your PC remains dedicated to your regular Internet connection, while the other is reserved for direct communication with your NAS device. The benefits? **Speed, isolation, and enhanced performance.**

---

## What You Need

- **Two NICs on your Windows 11 PC:**  
  - **NIC1:** For Internet access.  
  - **NIC2:** Dedicated for the TrueNAS Scale connection.

- **1 Ethernet Cable:**  
  - This cable should be long enough to connect your PC directly to the NAS device.

- **TrueNAS Scale Installation Media:**  
  - Ensure you’re using the latest stable version of TrueNAS Scale.

- **2.5Gb NICs (Recommended):**  
  - For transferring high-speed data and dramatically reducing the time to load ISOs or similar tasks.

---

## Step 1: Configuring TrueNAS Scale

### 1.1 Install TrueNAS Scale Without a Cable  
- Begin by installing TrueNAS Scale without connecting any Ethernet cable.  
- Once the installation completes, you’ll receive a message stating that the web interface cannot be configured.

### 1.2 Access the Linux Shell  
- At the command line interface (CLI), choose **Option 7: Open Linux Shell**.

### 1.3 Set a Static IP Address  
Since the automatic settings aren’t working for your direct connection, you must manually configure the network:
  
1. **Determine the Correct Interface Name:**  
   - Run the following command to list all network interfaces:
     ```
     ip a
     ```
   - Note the name of the interface you intend to use (for example, `eth0` or `eno1`).

2. **Edit the Network Configuration:**  
   - Open the interfaces file using the nano text editor:
     ```
     nano /etc/network/interfaces
     ```
   - Add the following lines (replace `eth0` with your actual interface name if different):
     ```
     auto eth0
     iface eth0 inet static
         address 192.168.100.10
         netmask 255.255.255.0
     ```
3. **Save and Exit:**  
   - Press `Ctrl+X`, then `Y`, and finally `Enter` to save the changes.

### 1.4 Restart TrueNAS  
- Reboot your NAS device.  
- After restarting, you should see that the web interface is available at `http://192.168.100.10`.

---

## Step 2: Configuring the Windows 11 PC

### 2.1 Identify the NICs  
- **NIC1:** Already set up for general Internet access—no changes required.  
- **NIC2:** This will be used exclusively for the connection to your TrueNAS device.

### 2.2 Configure the Dedicated NIC (NIC2)  
1. **Open Network Connections:**  
   - Press `Win + R`, then type:
     ```
     ncpa.cpl
     ```
   - Hit Enter.

2. **Adjust NIC2 Settings:**  
   - Right-click the NIC you plan to use for the direct connection and select **Properties**.
   - In the list, highlight **Internet Protocol Version 4 (TCP/IPv4)** and click **Properties**.
   - Choose **Use the following IP address** and enter:
     - **IP address:** `192.168.100.20`
     - **Subnet mask:** `255.255.255.0`
     - **Default gateway:** Leave this blank.
   - Skip DNS settings; this helps Windows treat this connection as a direct link rather than an Internet connection.

3. **Optional Steps:**  
   - You may rename this connection (for example, “NAS” or “HomeNAS”) for clarity.
   - Restart your PC to ensure that NIC2 retains these settings.

---

## Step 3: Establishing the Connection

1. **Connect the Ethernet Cable:**  
   - Plug the cable into both the TrueNAS device and the Windows PC's dedicated NIC (NIC2).  
   - Look for activity lights on both NIC ports, confirming that the devices are communicating.

2. **Access the TrueNAS Web Interface:**  
   - Open your preferred web browser on the Windows PC and navigate to:
     ```
     http://192.168.100.10
     ```
   - You should see the TrueNAS login screen, indicating a successful connection.

---

## Additional Steps: Security Setup

Once you’ve confirmed that the direct connection is working correctly, it’s a good idea to consider security enhancements. Isolate this connection further and establish a firewall route tailored to protect your NAS and the data it serves. For detailed instructions on security settings, you might want to refer to additional guides like “Let’s Talk Security.”

---

## Final Thoughts

This direct connection setup enables blazing-fast data transfers, making tasks such as deploying ISOs or managing large datasets much more efficient. It’s an ideal solution for home labs where security and speed are paramount. After you’ve mastered the basic connectivity, consider exploring advanced configurations such as VLAN isolation or integrating a dedicated firewall to further protect your NAS.

# Now Time For Security Setup. To isolate and firewall the connection. See the Let's Talk Security.md.
---







