class CreateElementCourG3s < ActiveRecord::Migration
  def self.up
    create_table :element_cour_g3s do |t|
    t.string   "reference"
    t.string   "titre"
    t.string   "description"
    t.string   "lien"
    t.string   "mots_cle"
    t.integer  "ordre",        :default => 0, :null => false
    t.integer  "ref_id"
    t.string   "langue",                      :null => false
    t.timestamps
    end
  end

  def self.down
    drop_table :element_cour_g3s
  end
end
