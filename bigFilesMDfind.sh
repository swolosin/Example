#!/bin/bash

# Written by Steve Wolosin Feb 07, 2020
# Lightly tested on 10.15.2
# Please use this script in a lab environment as complete testing has not been completed


# Quick way to locate largest files on logged in users ~/
# With macOS Catalina, you can no longer store files or data in the read-only system volume, nor 
# can you write to the "root" directory ( / ) from the command line, such as with Terminal. 
# https://support.apple.com/en-us/HT210650
# Because of this, I've ignored the rest of the hard drive. this was done to increase performance.
# It's also much easier :)

# Use the mdfind linux function and print out top 10 
bigFiles=`mdfind -onlyin ~/ 'kMDItemFSSize >= 1000000000' -0 | xargs -0 ls -S | head -10`


# Print message for end user to see their top 10 largest files
osascript -e "display dialog \"$bigFiles\""