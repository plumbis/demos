<#

This script will pull the output of /proc/net/dev
and collect the "swp" interfaces.

After this that list will be written to /etc/network/interfaces.
This assumes that eth0 is a dhcp interface

This provides a simple method to populate the inital interfaces file
for a new Cumulus Linux device.
#>

# get the output of /proc/net/dev
$proc_dev = (get-content /proc/net/dev)
$iface_array = @()

# loop over /proc/net/dev ouput and put interfaces
# starting with "swp" into iface_array
foreach($line in $proc_dev){
 $temp = $line.split("\:")[0].Trim()

 if($temp.contains("swp")){
  $iface_array += $temp
 }
}

# Sort the iface_array so swp1 comes before swp2
$iface_array = $iface_array | sort-object

# Create the output with default lo and eth0
$output_array = @()
$output_array += "Configured by Powershell"
$output_array += "auto lo"
$output_array += "iface lo"
$output_array += ""
$output_array += "auto eth0"
$output_array += "iface eth0 inet dhcp"
$output_array += ""

foreach($swp in $iface_array){
    $output_array += "auto $swp"
    $output_array += "iface $swp"
    $output_array += ""
}

# -encoding must be defined or special characters
# will be written out at the beginning of the file
Write-Output $output_array | Out-File -encoding ASCII /etc/network/interfaces
