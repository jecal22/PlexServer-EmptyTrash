#! /bin/bash

# Set script variables:
PLEX_URL=http://127.0.0.1:32400
PLEX_TOKEN=PLEX_SERVER_TOKEN_HERE
MOVIE_SECTION_ID=4
MOVIE_MOUNT_TEST="/path/to/media/Movies/.test.txt"
SHOWS_SECTION_ID=5
SHOWS_MOUNT_TEST="/path/to/media/TV Shows/.test.txt"
ERROR=0 # Set ERROR to 0 starting out. Will flip to 1 if any tests fail.  Use at the end of the script to set the correct exit code.

# TEST IF MOVIE MOUNT IS READABLE BY CHECKING FOR THE FILE SPECIFIED ABOVE
if [ -f "$MOVIE_MOUNT_TEST" ]
then
  echo "Movies share is mounted, proceeding with emptying trash from  Movies library..."
  curl -k -X PUT -H "X-Plex-Token: $PLEX_TOKEN" $PLEX_URL/library/sections/$MOVIE_SECTION_ID/emptyTrash
  echo "Waiting 5 seconds to proceed."
  ping -i 1 -c 5 127.0.0.1 >/dev/null 2>&1
else
  echo "Movies share is not mounted, skipping emptying trash from Movies Library."
  ERROR=1
fi

# TEST IF SHOWS MOUNT IS READABLE BY CHECKING FOR THE FILE SPECIFIED ABOVE
if [ -f "$SHOWS_MOUNT_TEST" ]
then
  echo "Shows share is mounted, proceeding with emptying trash from Shows library..."
  curl -k -X PUT -H "X-Plex-Token: $PLEX_TOKEN" $PLEX_URL/library/sections/$SHOWS_SECTION_ID/emptyTrash
  echo "Waiting 5 seconds to proceed."
  ping -i 1 -c 5 127.0.0.1 >/dev/null 2>&1
  echo "done."
else
  echo "Shows share is not mounted, skipping emptying trash from Shows library..."
  ERROR=1
fi

case $ERROR in
  0)
    MESSAGE="Script completed succesfully."
    ;;
  1)
    MESSAGE="Script compelted with errors. At least one library folder was unreadable."
    ;;
esac

echo "$MESSAGE"
exit $ERROR
