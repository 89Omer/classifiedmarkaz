# markaz_classified
Advance classified application

To start take clone of this repo under htdocs folder, then do the following

To setup virtual host follow following steps
1) Go to xampp/apache/conf/extra/httpd-vhosts.conf
2) Add the following code at EOF

<VirtualHost *:80>
    ServerAdmin superadmin@markaz.com
    DocumentRoot "D:/projects/Projects/opensource/htdocs/classifiedmarkazapp" (Your project location like this)
    ServerName classifiedmarkazapp.ae
</VirtualHost>


3) Go to C:/Windows/System32/drivers/etc
4) Run as administrator hosts file
5) Add the following line at EOF
	127.0.0.1		classifiedmarkazapp.ae
	
6) Restart your xampp server
7) Now you can access your project as "classifiedmarkazapp.ae" in browser

For Database:
1) Use datadb.sql file in custom_db folder

Use Admin credentials as below
Username: superadmin@markaz.com
Password: password

For UserPost Database seed commad
php artisan db:seed --class=UserPostTableSeeder





