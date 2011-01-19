#!/bin/sh

SITE=$1
echo "upstream $SITE {
	server unix:/var/run/php5-fpm/$SITE.sock;
}
server {
	listen 80;
	server_name $SITE;
	server_tokens off;
	server_name_in_redirect  off;

	access_log /var/www/$SITE/logs/nginx.access.log;
	error_log /var/www/$SITE/logs/nginx.error.log warn;

	gzip off;
	charset utf-8;
	client_max_body_size 10m;
	fastcgi_intercept_errors on;
	root /var/www/$SITE/www;
	index index.php index.html index.htm;

	fastcgi_read_timeout 6000;

	location ~ /(.ht|.git)
	{
		deny all;
	}

	location ~ /(protected|themes/[^/]+/views)/ {
		deny all;
	}

	location ~ /(assets|css|themes/new/css)/ {
		expires 7d;
	}

	location / {
		try_files \$uri \$uri/ /index.php?\$request_uri&\$args;
	}

	location ~ \.php\$ {
		fastcgi_pass $SITE;
		include fastcgi_params;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	}
}" > /etc/nginx/sites-available/$SITE

ln -s /etc/nginx/sites-available/$SITE /etc/nginx/sites-enabled/$SITE
#cp -R /var/www/{etalon,$SITE}
cp -R /var/www/etalon /var/www/$SITE
