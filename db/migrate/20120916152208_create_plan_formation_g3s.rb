class CreatePlanFormationG3s < ActiveRecord::Migration
  def self.up
    create_table :plan_formation_g3s do |t|
    t.string   "titre"
    t.integer   "niveau"
    t.integer   "element_cour_g3_id"
    t.integer   "formation_g2_id"
    t.integer   "ordre"
    t.string    "nom_ordre"
    t.string   "description"
      t.timestamps
    end
  end

  def self.down
    drop_table :plan_formation_g3s
  end
end
