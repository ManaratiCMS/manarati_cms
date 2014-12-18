class CreateLocalFormationG2s < ActiveRecord::Migration
  def self.up
    create_table :local_formation_g2s do |t|
    t.text   "adresse"
    t.string "telephone"
    t.text   "localisation"
    t.timestamps
    end
  end

  def self.down
    drop_table :local_formation_g2s
  end
end
