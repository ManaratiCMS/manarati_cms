class DataUser < ActiveRecord::Migration
  def self.up
  # l'utilisateur Root
    user =  User.new
    user.nom = "root"
    user.prenom = "root"
    user.login = "root"
    user.password = "root"
    user.email = "email@email.com"
    user.roles= "super_admin"
    user.save(false)
    # Ajouter Droit d'acces
    user_role = UserRole.new
    user_role.user_id = user.id
    user_role.nom = "super_admin"
    user_role.save
  end

  def self.down
  end
end
