class CreateFormationG2s < ActiveRecord::Migration
  def self.up
    create_table :formation_g2s do |t|
      t.string   "reference"
      t.text   "public_cible"
      t.integer   "tarif"
      t.string   "titre"
      t.text   "objectif"
      t.text   "prerequis"
      t.text   "travaux_pratiques"
      t.text   "plan_formation"
      t.integer   "duree"
      t.timestamps
    end
  end

  def self.down
    drop_table :formation_g2s
  end
end
