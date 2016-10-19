#Run the validation tests

Test-Cluster -Node Clusternode1.prosqladmin.com,Clusternode2.prosqladmin.com

#Create the cluster

New-Cluster -Node ClusterNode1.prosqladmin.com,ClusterNode2.prosqladmin.com -StaticAddress 192.168.0.20 -Name PROSQLADMIN-C
