  #! /bin/bash

    if [ $# -eq 0 ] ; then
       echo "USAGE: $(basename $0) file1 file2 file3 ..."
       exit 1
    fi

    for file in $* ; do
       html=$(echo $file | sed 's/\.txt$/\.html/i')

       echo "<html>" >> $html
       echo "<style type="text/css">
            table, th, td {
            border: 1px solid black;
            }
            </style>" >> $html
       echo "   <body>" >> $html
       echo '<table>' >> $html
       echo '<th>TEST CASES</th>' >> $html
       echo '<th>RESULT</th>' >> $html
#       echo '<th>LOGS</th>' >> $html
       while IFS=',' read -ra line ; do
        echo "<tr>" >> $html
        for i in "${line[@]}"; do
#           echo $i
           text=$( echo $i | grep -o "txt")
           if [ "$text" ]
           then
                echo script
#               echo '<td><a href="29-01-2021_tests_log.html"<div style="height:100%;width:100%">log</div></a></td>' >> $html
#               echo '<td><button onclick="document.location='$i'">LOGS</button></td>' >> $html
           else
               echo "<td>$i</td>" >> $html
           fi
         # echo "<td>$i</td>" >> $html
        done
        echo "</tr>" >> $html
       done < $file
       echo '</table>'
       echo "</body>" >> $html
       echo "</html>" >> $html
    done	
