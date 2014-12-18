class CreateCmpPageDetails < ActiveRecord::Migration
 def self.up

  create_table "cmp_page_details", :force => true do |t|
    t.string   "reference"
    t.string   "type_objet"
    t.string   "titre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",                 :null => false
    t.string   "lien",                        :null => false
    t.string   "mots_cle",                    :null => false
    t.integer  "ordre",        :default => 0, :null => false
    t.integer  "user_id"
    t.integer  "ref_id"
    t.string   "role"
    t.string   "langue",                      :null => false
  end


  end

  def self.down
    drop_table :cmp_page_details
  end
end
