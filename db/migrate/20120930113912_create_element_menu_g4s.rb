class CreateElementMenuG4s < ActiveRecord::Migration
  def self.up
    create_table :element_menu_g4s do |t|
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
      t.timestamps
    end
  end

  def self.down
    drop_table :element_menu_g4s
  end
end
