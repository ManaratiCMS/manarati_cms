git pull
mysql -u root -p system_db < sql_database/system_db.sql
rake db:migrate RAILS_ENV=production
sudo /etc/init.d/apache2 reload

