$proc_dev = (get-content /proc/net/dev)
$iface_array = @()

foreach($line in $proc_dev){
 $temp = $line.split("\:")[0].Trim()

 if($temp.contains("swp")){
  $iface_array += $temp
 }
}

$iface_array = $iface_array | sort-object

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

Write-Output $output_array | Out-File -encoding ASCII /etc/network/interfaces

