#!/bin/sh
# deploy webpage if on cims server already
hugo


# fix permissions
find public/ -type d -exec chmod 0755 {} +
find public/ -type f -exec chmod 0644 {} +

if [ -d  $HOME/tmp/webapp/public_html/ ]
then
    rsync  -avz --delete public/ nbren12@noahbrenowitz.com:~/webapp/public_html/personal
else
    rsync  -avz --delete public/ olympus:~/public_html/personal
fi
