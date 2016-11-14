#!/usr/bin/env bash

# Creates archives of the dynamic CMS data (uploads, plugins, database) in the /tmp/ directory. Should be run on prod server
echo "Moving WP database backups to /tmp/ directory.."
sudo cp /var/spool/holland/default/newest/backup_data/wordpress.sql.gz /tmp/
sudo cp /var/spool/holland/default/newest/backup_data/wordpress_homedeal.sql.gz /tmp/
sudo chown skyadmin /tmp/wordpress.sql.gz /tmp/wordpress_homedeal.sql.gz

echo "Creating archive for weetjes upload directory.."
tar -czf /tmp/wordpress_plugins.tar.gz \
    -C /var/www/app/default/wordpress/wp-content \
    plugins

echo "Creating archive for weetjes upload directory.."
tar -czf /tmp/wordpress_uploads.tar.gz \
    -C /var/www/app/default/wordpress/wp-content \
    uploads

echo "Creating archive for homedeal uploads directory.."
tar -czf /tmp/wordpress_homedeal_plugins.tar.gz \
    -C /var/www/app/homedeal/wp-content \
    plugins

echo "Creating archive for homedeal uploads directory.."
tar -czf /tmp/wordpress_homedeal_uploads.tar.gz \
    -C /var/www/app/homedeal/wp-content \
    uploads
