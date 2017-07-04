#!/bin/sh
# deploy webpage if on cims server already
hugo


# fix permissions
find public/ -type d -exec chmod 0755 {} +
find public/ -type f -exec chmod 0644 {} +

if [ -d $HOME/public_html/ ]
then
    rsync  -avz --delete public/ ~/public_html
else
    rsync  -avz --delete public/ cims:~/public_html
fi
