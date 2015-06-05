# Cumulus Workbench Demos

This is a set of scripts to help with bootstrapping the 4-switch Cumulus Networks Cumulus Workbench.

First look at the text file "script". 

Running every line will boot strap the CW including modifying the image to ONIE boot to 2.5.2 and downloading the other playbooks.

reprovision.yml - this issues a cl-img-select -if, wiping the current image and config + /mnt/persist and reboots the lab. This is the easy way to restart the entire CW

license.yml - this will apply the license on all 4 boxes and restart switchd

ports.yml - this will break out the appropiate 40GE ports on the leaf switches

interfaces.yml - this brings up all ports in the lab. Only loopback IPs are applied

quaggad.yml - this enables ospf and bgp within the daemons file and restarts the quagga service.