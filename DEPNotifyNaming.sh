#!/bin/bash

#!/bin/bash

# Find the Building chosen in the original imaging process. This is located in /var/tmp
building=`grep -h "Building" /Library/PathTo.log | sed 's/.*to //'`

# Find the Asset tag orginally inputed during the imaging process. This is located in /var/tmp
assetTag=`grep -h "Tag" /Library/Pathto/depnotify.log | sed 's/.*to //'`

## Determine the type of machine being named - This will work as long as all portables are named MacBook...
theModel=`system_profiler SPHardwareDataType 2> /dev/null | grep "Model Name:" | awk '{print $3}'`

JAMF_BINARY="/usr/local/bin/jamf"
DEP_NOTIFY_LOG="/var/tmp/depdebug.log"

if [ "$theModel" == "MacBook" ]; then
	
	modelIdentifier="ml"
	
else

	modelIdentifier="mw"
	
fi

echo "$building$assetTag$theModel" > $DEP_NOTIFY_LOG

## Device Name Function
deriveName () {
	deviceName="$modelIdentifier$buildingCode-$assetTag"
}

## Renaming Function
renameMac () {
	"$JAMF_BINARY" setComputerName -name "$deviceName"
    "$JAMF_BINARY" recon
    #echo "aa $deviceName" >> $DEP_NOTIFY_LOG
}

## Determine Choices and Set Building Codes
if [ "$building" == "Company 1" ]; then

	buildingCode="0001"
	deriveName
	renameMac
	givesite="siteCompany1"
	
elif [ "$building" == "Company 2" ]; then

	buildingCode="0002"
	deriveName
	renameMac
	givesite="siteCompany2"
	
elif [ "$building" == "Company 3" ]; then

	buildingCode="0003"
	deriveName
	renameMac
	givesite="siteCompany3"

elif [ "$building" == "Company 4" ]; then

	buildingCode="0004"
	deriveName
	renameMac
	givesite="siteCompany4"

elif [ "$building" == "Company 5" ]; then

	buildingCode="0005"
	deriveName
	renameMac
	givesite="siteCompany5"

elif [ "$building" == "Company 6" ]; then

	buildingCode="0006"
	deriveName
	renameMac
	givesite="siteCompany6"

elif [ "$building" == "Company 7" ]; then

	buildingCode="0007"
	deriveName
	renameMac
	givesite="siteCompany7"

elif [ "$building" == "Company 8" ]; then

	buildingCode="0008"
	deriveName
	renameMac
	givesite="siteCompany8"

elif [ "$building" == "Company 9" ]; then

	buildingCode="0009"
	deriveName
	renameMac
	givesite="siteCompany9"
	
elif [ "$building" == "Company 10" ]; then

	buildingCode="0010"
	deriveName
	renameMac
	givesite="siteCompany10"

fi

"$JAMF_BINARY" policy -event $givesite


exit 0