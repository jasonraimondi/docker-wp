#!/bin/bash

cd /var/www/html

find . -exec chown www-data:www-data {} \;
find . -type d -exec chmod 775 {} \;
find . -type f -exec chmod 664 {} \;

# allow wordpress to manage wp-config.php (but prevent world access)
chgrp www-data ./wp-config.php
chmod 660 ./wp-config.php

# allow wordpress to manage .htaccess
touch ./.htaccess
chgrp www-data ./.htaccess
chmod 664 ./.htaccess

# allow wordpress to manage wp-content
find ./wp-content -exec chgrp www-data {} \;
find ./wp-content -type d -exec chmod 775 {} \;
find ./wp-content -type f -exec chmod 664 {} \;

/usr/bin/supervisord -n -c /etc/supervisord.conf

