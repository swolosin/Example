#!/bin/bash

# Not yet successful but feel I'm getting close. Look at bottom for other choices on the script to find all local files.
# Favorite possible solution is developer kMDItemFSOwnerUserID passed throught the mdfind. Would make for faster more reliable searches.

USERNAME=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; USERNAME = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; USERNAME = [USERNAME,""][USERNAME in [u"loginwindow", None, u""]]; sys.stdout.write(USERNAME + "\n");')


bigFiles=`find / -type f -size +2000M -user $USERNAME -print | xargs ls -sd | head -10`

# osascript -e "display dialog \"$bigFiles\""
"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -title "Top 10 Big Files" -heading "Big File Location" -alignHeading left -description "$bigFiles" -button1 Ok -defaultButton 0

----------

#!/bin/bash

#USERNAME=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; USERNAME = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; USERNAME = [USERNAME,""][USERNAME in [u"loginwindow", None, u""]]; sys.stdout.write(USERNAME + "\n");')

#bigFiles=$(find / -mount -type f -user $USERNAME -size +2000M -print | xargs -0 ls -S | head -n10)

#"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -title "Top 10 Big Files" -heading "Big File Location" -alignHeading left -description "$bigFiles" -button1 Ok -defaultButton 0

----------

#!/bin/bash

#USERNAME=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; USERNAME = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; USERNAME = [USERNAME,""][USERNAME in [u"loginwindow", None, u""]]; sys.stdout.write(USERNAME + "\n");')

#bigFiles=`find / -mount -D -type f -user $USERNAME -size +2000M -print | \ xargs ls -sS | head -n10`

#"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -title "Top 10 Big Files" -heading "Big File Location" -alignHeading left -description "$bigFiles" -button1 Ok -defaultButton 0

----------

#!/bin/bash

#mdfind -onlyin / 'kMDItemFSOwnerUserID = 502' 'kMDItemFSSize >= 1000000000' -0 | xargs -0 ls -S | head -10
