#! /bin/bash
checkIfhostExits()
{
pingError=$(ping -c 2 $1 &> /dev/null; echo $?)
if [ $pingError -eq 0 ]
 then
  var=0
 else
  var=1
fi
echo $var
}

getUsage()
{
 hostname=$1
 username=$2
 password=$3
 process=$4
 memUsage=$(ssh -n "$hostname" "(ps -ef | grep -v grep | grep  $process |  awk '{ print \$2 }' | /usr/bin/xargs pmap -x | tail -1 | awk '{ print \$3 }') 2> /dev/null") 
 #memUsage=$(sshpass -p $password ssh -n -o StrictHostKeyChecking=no  "$username"@"$hostname" "(ps -ef | grep -v grep | grep  $process |  awk '{ print \$2 }' | /usr/bin/xargs pmap -x | tail -1 | awk '{ print \$3 }') 2> /dev/null") 
 echo $memUsage
}

file="./hostlist"

while read  line
do
 hostname=$(echo $line |cut -d ' ' -f 1)
 username=$(echo $line |cut -d ' ' -f 2)
 password=$(echo $line |cut -d ' ' -f 3)
 process=$(echo $line |cut -d ' ' -f 4)
 Error=$(checkIfhostExits $hostname)
 if [ $Error -eq 0 ]
  then
   memUsage=$(getUsage $hostname $username $password $process)
   if [[ $memUsage == "" ]]
    then 
      memUsage="Process not found"
   fi
 else
  memUsage="Not able to ping host"
 fi 
 echo -n $hostname
 echo -n " : "
 echo -n $process
 echo -n " : "
 if [[ $memUsage == "Process not found" ]]
  then
    echo  $memUsage
  elif [[ $memUsage == "Not able to ping host" ]]
   then 
   echo $memUsage
  else
    echo -n $memUsage
    echo " KB"
 fi   
done < "$file"
