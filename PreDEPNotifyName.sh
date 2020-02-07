#!/bin/bash


##########################################################################################################
##                                                                                                      ##
## Created by Steve Wolosin, Aug 21, 2018.                                                              ##
## Creates UI to prompt technician to define the device name based on unified naming                    ##
## The fleet as of early 2018 is represented by at least 4 naming conventions, causing confusion,       ##
## inconsistancy, and disorganization.  This scripts begins an effort to align naming across all        ##
## concepts and all services.  This includes the local device, AD, ePO, JAMF, and any other service.    ##
## The goal is to make this easy enough for an end user.  At initial creation, IT will be implementing. ##
##                                                                                                      ##
## This script does a number of actions and has some dependencies.  First, the actions:                 ##
##      >> First action is to get a list of buildings from the JSS.  Building = Concept Codes           ##
##      >> Once the building names are parsed, they are presented to the end user via dialogs           ##
##      >> The user then enters the Asset Tag number into the next field                                ##
##      >> The answers provided are used to construct the new device name and then set it globally      ##
##                                                                                                      ##
## Next, the dependencies:                                                                              ##
##      >> Setting Building Codes is not dynamic and must be changed when new buildings are added       ##
##      >> There is currently no validation checking.  For example, the Asset Tag should be tested for  ##
##      >> character length and to ensure that the entry is numbers only.                               ##
##      >> Until further notice, naming is still vital for the device, AD, ePO naming cycle             ##
##                                                                                                      ##
##########################################################################################################

## Get list of buildings using API Scripting and limited access user
getBuildings=`curl -H "Accept: text/xml" -s https://yourcomany.jamfcloud.com/JSSResource/buildings --user "apiuser"`

## Parse the results and build into an array that AppleScript can understand - lazy trim of extra , at end
result=$( echo $getBuildings | xmllint --xpath "//name" - | sed -e 's/<name>/"/g' -e 's/<\/name>/", /g' )
buildingList=`echo $result | sed 's/.$//'`

## Present Dialogs to the user to choose Building from a list and then manually enter the Asset Tag
theBuilding="$(/usr/bin/osascript -e 'set theBuildingChoices to {'"$buildingList"'}' -e 'set theBuilding to choose from list theBuildingChoices with prompt "Select Building:"')"
assetTag="$(/usr/bin/osascript -e 'set theAssetTag to text returned of (display dialog "Enter your Asset Tag Number" default answer "")')"

## Determine the type of machine being named - This will work as long as all portables are named MacBook...
theModel=`system_profiler SPHardwareDataType 2> /dev/null | grep "Model Name:" | awk '{print $3}'`

if [ "$theModel" == "MacBook" ]; then
	
	modelIdentifier="ml"
	
else

	modelIdentifier="mw"
	
fi

## Renaming Function
renameMac () {
	scutil --set ComputerName $deviceName
	scutil --set LocalHostName $deviceName
	scutil --set HostName $deviceName
	defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName $deviceName
	jamf recon -assetTag $assetTag
}

## Device Name Function
deriveName () {
	deviceName="$modelIdentifier$buildingCode-$assetTag"
}

## Determine Choices and Set Building Codes
if [ "$building" == "Company 1" ]; then

	buildingCode="0001"
	deriveName
	renameMac
	
elif [ "$building" == "Company 2" ]; then

	buildingCode="0002"
	deriveName
	renameMac
	
elif [ "$building" == "Company 3" ]; then

	buildingCode="0003"
	deriveName
	renameMac

elif [ "$building" == "Company 4" ]; then

	buildingCode="0004"
	deriveName
	renameMac

elif [ "$building" == "Company 5" ]; then

	buildingCode="0005"
	deriveName
	renameMac

elif [ "$building" == "Company 6" ]; then

	buildingCode="0006"
	deriveName
	renameMac

elif [ "$building" == "Company 7" ]; then

	buildingCode="0007"
	deriveName
	renameMac

elif [ "$building" == "Company 8" ]; then

	buildingCode="0008"
	deriveName
	renameMac

elif [ "$building" == "Company 9" ]; then

	buildingCode="0009"
	deriveName
	renameMac
	
elif [ "$building" == "Company 10" ]; then

	buildingCode="0010"
	deriveName
	renameMac

fi