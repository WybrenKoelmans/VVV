echo "Creating database 'wordpress-skydreams' (if it does not exist)..."

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS \`wordpress-skydreams\`"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON \`wordpress-skydreams\`.* TO skydev@localhost IDENTIFIED BY 'skydev';"

plugins=(
    advanced-code-editor
    advanced-custom-fields
    akismet
    better-wordpress-showhide-elements
    disqus-comment-system
    envira-gallery
    orbisius-child-theme-creator
    raw-html
    shareaholic
    tablepress
    tinymce-advanced
    wordpress-faq-manager
    wordpress-importer
    wordpress-mu-domain-mapping
    wordpress-seo
    wp-mail-smtp
    wp-native-dashboard
    redirection
)

if [ ! -d "htdocs" ]; then
	echo 'Installing WordPress (release version) in wordpress-skydreams/htdocs...'
	mkdir ./htdocs
cd ./htdocs
	wp core download --allow-root
	wp core config --dbname="wordpress-skydreams" --dbuser=skydev --dbpass=skydev --dbhost="localhost" --allow-root
	wp core multisite-install --url=wordpress.skydreams.com.dev --title="wordpress-skydreams" --admin_user=skydev --admin_password=skydev --admin_email=test@skydreams.com --allow-root

	echo 'Install required plugins'

    for plugin in "${plugins[@]}"
    do
	if ! wp plugin is-installed $plugin; then
        wp plugin install $plugin --activate-network
	fi
	done

	echo 'Copy sunrise.php to correct location and adjust our wp-config to support domain mapping'
    cp wp-content/plugins/wordpress-mu-domain-mapping/sunrise.php wp-content/sunrise.php

    sed -i "/define('BLOG_ID_CURRENT_SITE', 1);/ a\
	define('SUNRISE', true);\
	define('PARTNER_URL', 'http://partners.skydreams.com.dev');
	define('SKYAPI_URL', 'http://skyapi.net.dev');
    " wp-config.php

	echo 'Add skydev user'
	wp user create skydev test@skydreams.com --user_pass=skydev --role=administrator
	wp super-admin add test@skydreams.com

	cd -
else
	echo 'Updating WordPress in wordpress-skydreams/htdocs...'
	wp core update --allow-root
	wp core update-db --allow-root

	echo 'Install required plugins'

	for plugin in "${plugins[@]}"
	do
	if ! wp plugin is-installed $plugin; then
		wp plugin install $plugin --activate-network
	fi
	done
	
	echo 'Updating Plugins'
	wp plugin update --all
fi
