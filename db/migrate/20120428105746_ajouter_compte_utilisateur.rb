class AjouterCompteUtilisateur < ActiveRecord::Migration
  def self.up
     # l'utilisateur Root
    user =  User.new
    user.nom = ""
    user.prenom = "admin"
    user.login = "admin"
    user.password = "admin"
    user.email = "admin@gmail.com"
    user.save(false)

    # Ajouter Droit Administrateur
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "administrateur"
    user_role.save
    # Ajouter Droit Visiteur
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "guest"
    user_role.save

    # Ajouter Packs Gestion de Pages
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "gestion_page"
    user_role.save

    # Ajouter Pack Gestion de Menu
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "gestion_menu"
    user_role.save

    # Ajouter Pack Gestion des themes
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "gestion_themes"
    user_role.save

   


  end
  

  def self.down
  end
end
