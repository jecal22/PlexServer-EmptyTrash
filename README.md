# PlexServer-EmptyTrash
Simple script to safely empty trash in Plex Media Server library sections only when media shares are mounted.

When emptying tash in Plex Media Server, references to missing files.  If this leaves an item in your library with no source files, then the item is also removed from the database.

Unfortunately, the built in "Empty Trash" feature in Plex doesn't check to see if the media sources are mounted or not.  This means, for example, if your media library is stored on an external drive, or a network share, which becomes disconnected from the Plex server and the empty trash task is run, it will potentially empty your entire media library as it will assume all of your files are missing/deleted.

I wrote this simple script so I can have the empty trash task run on a regular schedule, but only when my media libraries are actually mounted.

The script works by checking the root of the library folder for a file named '.test.txt'.  The content of the file are irrelevant.  The script simply checks to see if the .test.txt file exist.  If not, then it is assumed the mount is missing and skips the empty trash task.

If the .test.txt file is found, then this confirms the mount is valid and the empty trash task can be run.

The Empty Trash task is performed on a per library basis, i.e. TV Shows, Movies, etc.  So this script checks each library source for a .test.txt file and executes the Empty Trash task only on libraries that are currently mounted and skipping those that are not.

If all libraries are mounted and the Empty Trash task runs, then the script will exit with a '0' status indicating success.

If any one library is unmounted and the Empty Trash task is skipped, the script will exit with a '1' status indicating an error.

This script should work on any Linux server running Plex Media Server using any mount type (USB, SSHFS, SMB, NFS, etc.) as it is only checking for the presence of a file, not whether a mount is present.
