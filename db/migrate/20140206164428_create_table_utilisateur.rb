class CreateTableUtilisateur < ActiveRecord::Migration
  def self.up
    create_table :utilisateurs do |t|
    t.text   "login",:null => false
    t.text   "password",:null => false
    t.text   "nom",:null => false
    t.text   "prenom"
    t.text   "adresse"
    t.text   "email"
    t.text   "gsm"
    t.text   "tel"
    t.text   "siteweb"
    t.text   "ville"
    t.text   "pays"
    t.text   "langue"
    t.text   "facebook"
    t.text   "twiter"
    t.integer "cmp_photo_id"
    t.string   "type",                :limit => 200   
    t.timestamps
    end
  end

  def self.down
    drop_table :utilisateurs
  end
end
