#!/bin/sh 

if [ $# -eq 0 ] ; then
   echo "USAGE: $(basename $0) file1 file2 file3 ..."
   exit 1
fi

now=`date +"%d-%m-%Y"`

#echo "TESTCASES,RESULT" >> ${now}.txt

for file in $*
do
   echo $file
   while IFS= read -r line
   do
       tests=$( echo $line | grep -oP '.*(?= ::)')
       test2=$( echo $line | grep -oP '(?<=:: ).*')
       if [  "$tests" ] || [ "$test2" ]
       then
           testcase=$( echo $tests | grep -o "Tests")
           openbmc=$( echo $tests | grep -o "Test Openbmc Setup")
           ipmi=$( echo $tests | grep -o "Ipmi.Test")
           redfish=$( echo $tests | grep -o "Redfish.Managers")
           redfish1=$( echo $tests | grep -o "Test Firmware Inventory")
           redfish2=$( echo $test2 | grep -o "Get system")

           if [ ! -n "$testcase" ] && [ ! -n "$openbmc" ] && [ ! -n "$ipmi" ] &&[ ! -n "$redfish" ]&&[ ! -n "$redfish1" ]&&[ ! -n "$redfish2" ]
           then
               printf "$tests"  >> ${now}.txt
               printf ","  >> ${now}.txt
           fi
       fi

       if [ ! -n "$testcase" ] && [ ! -n "$openbmc" ] && [ ! -n "$ipmi" ] && [ ! -n "$redfish" ] && [ ! -n "$redfish1" ] &&[ ! -n "$redfish2" ]
       then
           pass=$( echo "$line" | grep -o "PASS")
           if [ "$pass" ]
           then
               echo $pass  >> ${now}.txt
           fi 

           fail=$(echo $line | grep -o "FAIL" )
           if [ "$fail" ]
           then
               echo $fail  >> ${now}.txt
           fi
        fi
   done < $file
done

cat ${now}.txt | column -t -s ","

