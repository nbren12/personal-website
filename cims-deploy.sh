#!/bin/sh
# deploy webpage if on cims server already
hugo
rsync  -avz --delete public/ ~/public_html
