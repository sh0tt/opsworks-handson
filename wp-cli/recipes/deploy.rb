require "net/http"
require "uri"

wpdir = "/srv/www/wordpress/current"
dbname = node[:deploy][:wordpress][:database][:database]
dbuser = node[:deploy][:wordpress][:database][:username]
dbpass = node[:deploy][:wordpress][:database][:password]
dbhost = node[:deploy][:wordpress][:database][:host]
wp_admin_email = node[:deploy][:wordpress][:wp_admin_email]

execute "wp configure" do
   command "wp core config --dbname=#{dbname} --dbuser=#{dbuser} --dbpass=#{dbpass} --dbhost=#{dbhost}"
   cwd "#{wpdir}"
   user "deploy"
   not_if { File.exists?("#{wpdir}/wp-config.php") }
   action :run
end
