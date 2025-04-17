# Windows 11 to TrueNAS Scale: Direct Connection.
No switch required. 
This is for home labs that don't need remote access.
---
First: You need 2 NICs on your windows pc. One for your internet access and one for the connection to the NAS.
And of course a ethernet cable that will reach your nas machine.
---
Why?! 1. SPEED. 2. Isolation from Web (well,mostly). 3. SPEED.
You will get great speed using 2.5Gbs NICs. ISOs that took mins now take seconds.
---
Lets start with the NAS: 
    I am using the latest stable version of TrueNAS Scale.
Intall TrueNAS: Install without Ethernet cable hooked up.
After install it should say, not able configure web interface.
At the CLi choose option 7, Open Linux Shell. I tried using static routes and network interfaces but it would never work.
   Now in the Linux Shell, we want to edit the /etc/network/interfaces file.
   
   But first we need the name of the correct interface (e.g.,eth0 or eno1).
   To get this type:
   
         ip a
         
   This should give you the interface name of your NIC.

   Now we use nano to edit the interfaces file:
   
         nano /etc/network/interfaces  
   
Now in the file, add the following lines:

         auto eth0
         iface eth0 inet static
             address 192.168.100.10
             netmask 255.255.255.0
             
Make sure to replace eth0 with the interface name you got earlier. 

Save the file:

         Ctrl+X, then Y, then enter.

Restart NAS.
After restart you should see Web Interface is at : 192.168.100.10.

At this point we are done with the NAS.
---
Now lets configure our Windows PC:
For now we will call NIC1 is the Web Access card. NIC2 will be the Direct Connection to NAS.
You shouldn't need to change anything with NIC1 (Web Access NIC).

We need to configure NIC2.
On the windows pc press Win+R then type

     ncpa.cpl

hit enter. This should open a window with your NICs listed. We want to Right-click on the NIC we are going to use for direct connection and select "Properties".
In the new window select Internet Protocol Version 4 (TCP/IPv4) and click "Properties"
Choose "Use the following IP address" and set:

    IP address: 192.168.100.20
    Subnet mask: 255.255.255.0
    Default gateway: (Leave this Blank)
    
Skip DNS settings. This helps with windows not seeing this connection as a web connection.
Save settings.
You can also rename the connection if you want to, like NAS or HomeNas.

Ok now at this point we have TrueNAS with a static address of 192.168.100.10.
Windows NIC2 with a static address of 192.168.100.20.

You may want to restart windows to make sure the changes we made to NIC2 hold.

Now lets connect TrueNAS device to Windows PC. As soon as you connect the two you should see them talking (if you will) with the activity lights on your NICs if they have them.

Open your favorite browser on your windows pc and type the address you gave TrueNAS.
 192.168.100.10
You should be greeted at the TrueNAS login screen.  

# Now Time For Security Setup. To isolate and firewall the connection.
---







