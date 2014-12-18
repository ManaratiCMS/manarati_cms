echo "Mise à jour la version Server \n"
echo "Mote de passe Mysql : "
mysqldump -u root -p system_db > sql_database/system_db.sql 
git add .
git commit -m"Mise a jour Local to Server"
echo "Mot de passe de Server :"
git push sites_membre master

