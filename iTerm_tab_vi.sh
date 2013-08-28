#!/bin/bash

#CD_CMD="cd "\\\"$(pwd)\\\"" && clear"
CD_CMD="cd "\\\"$(pwd)\\\"" && clear"
VERSION=$(sw_vers -productVersion)

if (( $(expr $VERSION '<' 10.7) )); then
	RUNNING=$(osascript<<END
	tell application "System Events"
	    count(processes whose name is "iTerm")
	end tell
END
)
else
	RUNNING=1
fi

if (( $RUNNING )); then
	osascript<<END


	tell application "iTerm"

	    tell the current terminal
	        activate current session
	        launch session "Default Session"
	        tell the last session
	    		write text "$CD_CMD"

			set name to "subl"
			set foreground color to "red"
			# set background color to "blue"
			set transparency to "0.1"

	        end tell
	    end tell

	    # ---this is new window solution
		# activate
		# set term to (make new terminal)
		# tell term
		# 	set sess to (launch session "Default Session")
		# 	tell sess
		# 		write text "$CD_CMD"
		# 	end tell
		# end tell


	end tell
END
else

	osascript<<END
	tell application "iTerm"

		activate
		set sess to the first session of the first terminal
		tell sess
			write text "$CD_CMD"
		end tell

	end tell
END
fi