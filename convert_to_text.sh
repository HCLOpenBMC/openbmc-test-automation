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
       if [  "$tests" ]
       then
           testcase=$( echo $tests | grep -o "Tests")
           openbmc=$( echo $tests | grep -o "Test Openbmc Setup")

           if [ ! -n "$testcase" ] && [ ! -n "$openbmc" ]
           then
#               printf "$tests"
#               printf "::"
               printf "$tests"  >> ${now}.txt
               printf ","  >> ${now}.txt
           fi
       fi

       if [ ! -n "$testcase" ] && [ ! -n "$openbmc" ]
       then
           pass=$( echo "$line" | grep -o "PASS")
           if [ "$pass" ]
           then
               echo $pass  >> ${now}.txt
#               echo $pass
           fi

           fail=$(echo $line | grep -o "FAIL" )
           if [ "$fail" ]
           then
               echo $fail  >> ${now}.txt
#               echo $fail
           fi
        fi
   done < $file
done

cat ${now}.txt | column -t -s ","
