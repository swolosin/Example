#!/bin/bash

#Changes Site
apiURL=$4
apiUser=$5
apiPass=$6
newSite=$7
idSite=$8

#Getting the serial
computerserial="$(system_profiler SPHardwareDataType | grep 'Serial Number (system)' | awk '{print $NF}')"


#Change the Site
echo "<computer><general><site><id>$idSite</id><name>$newSite</name></site></general></computer>" | curl -X PUT -fku $apiUser:$apiPass -d @- $apiURL/JSSResource/computers/serialnumber/$computerserial/subset/general -H "Content-Type: application/xml"

exit 0