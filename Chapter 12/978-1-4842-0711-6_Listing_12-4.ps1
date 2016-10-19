#Create the Role

Add-ClusterServerRole -Name PROSQLMSDTC-C -Storage "Cluster Disk 4" -StaticAddress 192.168.0.21

#Create the DTC Resource

Add-ClusterResource -Name MSDTC-PROSQLMSDTC-C -ResourceType "Distributed Transaction Coordinator" -Group PROSQLMSDTC-C

#Create the dependencies

Add-ClusterResourceDependency MSDTC-PROSQLMSDTC-C PROSQLMSDTC-C

Add-ClusterResourceDependency MSDTC-PROSQLMSDTC-C "Cluster Disk 4"

#Bring the Role online

Start-ClusterGroup PROSQLMSDTC-C
