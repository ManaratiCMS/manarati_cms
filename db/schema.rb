# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140207212218) do

  create_table "cmp_articles", :force => true do |t|
    t.string   "reference"
    t.string   "group"
    t.string   "sous_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref_article_classe", :limit => 200,                :null => false
    t.date     "date_creation"
    t.text     "description"
    t.string   "fichier_css",        :limit => 100
    t.string   "fichier_js",         :limit => 100
    t.integer  "cmp_page_id"
    t.integer  "ordre",                             :default => 0, :null => false
    t.text     "libs_css"
    t.text     "libs_js"
    t.integer  "cmp_article_id"
    t.string   "nom_zone"
    t.integer  "ref_id"
    t.string   "langue"
    t.integer  "cmp_page_detail_id"
  end

  add_index "cmp_articles", ["cmp_page_id"], :name => "cmp_page_fk_constraint"

  create_table "cmp_categories", :force => true do |t|
    t.string   "reference_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom",              :limit => 200
    t.string   "reference",        :limit => 200
    t.integer  "cmp_categorie_id"
    t.text     "description"
    t.integer  "protection",                      :default => 0, :null => false
  end

  create_table "cmp_composants", :force => true do |t|
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                :limit => 200,                :null => false
    t.text     "texte"
    t.integer  "cmp_article_id"
    t.string   "nom",                 :limit => 200
    t.string   "label_form"
    t.string   "titre"
    t.string   "text_alt"
    t.integer  "width"
    t.integer  "height"
    t.integer  "categorie"
    t.integer  "sous_categorie"
    t.string   "type_langage",        :limit => 100
    t.integer  "cmp_article_type_id"
    t.integer  "use_original",                       :default => 0, :null => false
    t.string   "font"
    t.integer  "element_cour_g3_id"
    t.string   "fichier_css"
    t.string   "fichier_js"
    t.integer  "ordre",                              :default => 0
    t.string   "libs_css"
    t.string   "libs_js"
    t.integer  "ref_id"
    t.string   "langue"
    t.string   "nom_zone"
    t.string   "type_contenu"
  end

  add_index "cmp_composants", ["cmp_article_id"], :name => "cmp_article_fk_constraint"

  create_table "cmp_composants_existants", :force => true do |t|
    t.string   "nom"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmp_config_apps", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom",        :limit => 200
    t.string   "valeur_txt"
    t.integer  "valeur_int"
  end

  create_table "cmp_menu_abstracts", :force => true do |t|
    t.string   "lien"
    t.string   "titre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordre",                      :default => 0, :null => false
    t.integer  "user_id"
    t.string   "nom"
    t.string   "ref_langue"
    t.integer  "ref_id"
    t.string   "type",        :limit => 200,                :null => false
    t.string   "role"
    t.integer  "cmp_page_id"
    t.integer  "protection",                 :default => 0
  end

  create_table "cmp_menus", :force => true do |t|
    t.string   "lien"
    t.string   "titre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordre",      :default => 0, :null => false
    t.integer  "user_id"
    t.string   "nom"
    t.string   "ref_langue"
    t.integer  "ref_id"
  end

  create_table "cmp_page_details", :force => true do |t|
    t.string   "reference"
    t.string   "type_objet"
    t.string   "titre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",                       :null => false
    t.string   "lien",                              :null => false
    t.string   "mots_cle",                          :null => false
    t.integer  "ordre",              :default => 0, :null => false
    t.integer  "user_id"
    t.integer  "ref_id"
    t.string   "role"
    t.string   "langue",                            :null => false
    t.integer  "cmp_page_id"
    t.integer  "cmp_page_detail_id"
  end

  create_table "cmp_pages", :force => true do |t|
    t.string   "reference"
    t.string   "titre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",                 :null => false
    t.string   "lien",                        :null => false
    t.string   "mots_cle",                    :null => false
    t.integer  "formation_id"
    t.integer  "ordre",        :default => 0, :null => false
    t.integer  "user_id"
    t.integer  "ref_id"
    t.string   "langue",                      :null => false
  end

  add_index "cmp_pages", ["formation_id"], :name => "formation_fk_constraint"

  create_table "cmp_sites", :force => true do |t|
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_creation"
    t.datetime "date_fin_abonement"
    t.string   "nom",                :limit => 200
    t.string   "titre"
    t.string   "site_site"
    t.integer  "user_id"
    t.integer  "solde"
    t.text     "description"
  end

  create_table "contacts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom",        :limit => 200
    t.string   "prenom",     :limit => 200
    t.string   "email",      :limit => 200
    t.string   "objet",      :limit => 200
    t.text     "message"
  end

  create_table "element_cour_g3s", :force => true do |t|
    t.string   "reference"
    t.string   "titre"
    t.string   "description"
    t.string   "lien"
    t.string   "mots_cle"
    t.integer  "ordre",           :default => 0, :null => false
    t.integer  "ref_id"
    t.string   "langue",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "formation_g2_id"
  end

  create_table "element_menu_g4s", :force => true do |t|
    t.string   "reference"
    t.string   "titre"
    t.string   "description"
    t.string   "lien"
    t.string   "titre_lien"
    t.integer  "cmp_photo_id"
    t.integer  "menu_g4_id"
    t.integer  "ordre",        :default => 0, :null => false
    t.integer  "ref_id"
    t.string   "langue",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formation_g2s", :force => true do |t|
    t.string   "reference"
    t.text     "public_cible"
    t.integer  "tarif"
    t.string   "titre"
    t.text     "objectif"
    t.text     "prerequis"
    t.text     "travaux_pratiques"
    t.text     "plan_formation"
    t.integer  "duree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cmp_photo_id"
    t.integer  "local_formation_g2_id"
    t.integer  "ordre"
    t.integer  "cmp_animation_flash_id"
    t.integer  "menu_g4_id"
    t.integer  "protection",             :default => 0
    t.string   "detail_duree"
    t.integer  "formateur_id"
  end

  create_table "formations", :force => true do |t|
    t.string   "designation",                                :null => false
    t.text     "description"
    t.integer  "prix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "plan"
    t.string   "professeur",   :limit => 200
    t.string   "reference",    :limit => 200,                :null => false
    t.integer  "cmp_photo_id"
    t.integer  "ordre",                       :default => 0, :null => false
    t.integer  "user_id"
  end

  add_index "formations", ["cmp_photo_id"], :name => "cmp_photo_fk_constraint"

  create_table "local_formation_g2s", :force => true do |t|
    t.text     "adresse"
    t.string   "telephone"
    t.text     "localisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cmp_photo_id"
    t.string   "nom"
  end

  create_table "media_sys", :force => true do |t|
    t.string   "nom"
    t.string   "titre"
    t.string   "text_alt"
    t.integer  "width"
    t.integer  "hight"
    t.string   "categorie"
    t.string   "sous_categorie"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_g4s", :force => true do |t|
    t.string   "reference"
    t.string   "nom"
    t.string   "description"
    t.integer  "ordre",       :default => 0, :null => false
    t.integer  "ref_id"
    t.string   "langue",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partenaire_g2s", :force => true do |t|
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom",          :limit => 200
    t.string   "pays"
    t.text     "description"
    t.integer  "cmp_photo_id",                :null => false
  end

  create_table "plan_formation_g3s", :force => true do |t|
    t.string   "titre"
    t.integer  "niveau"
    t.integer  "element_cour_g3_id"
    t.integer  "formation_g2_id"
    t.integer  "ordre"
    t.string   "nom_ordre"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_g2s", :force => true do |t|
    t.date     "Dates_Debut_Inscription"
    t.date     "Date_Fin_Inscription"
    t.integer  "formation_g2_id"
    t.integer  "local_formation_g2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_roles", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "roles"
    t.string   "nom",                               :null => false
    t.string   "prenom",                            :null => false
    t.string   "email",                             :null => false
    t.string   "nom_site"
    t.string   "ref_site"
    t.text     "description_site"
    t.string   "theme_site"
    t.integer  "cmp_photo_id"
    t.integer  "is_site_principale"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "utilisateurs", :force => true do |t|
    t.text     "login",                  :null => false
    t.text     "password",               :null => false
    t.text     "nom",                    :null => false
    t.text     "prenom"
    t.text     "adresse"
    t.text     "email"
    t.text     "gsm"
    t.text     "tel"
    t.text     "siteweb"
    t.text     "ville"
    t.text     "pays"
    t.text     "langue"
    t.text     "facebook"
    t.text     "twiter"
    t.integer  "cmp_photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "password_reset_token"
    t.datetime "password_expires_after"
  end

end
