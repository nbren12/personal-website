#!/bin/sh
hugo
rsync  -avz --delete public/ cims:~/public_html
