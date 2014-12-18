class AjouterColonneFormationIdAFormationG2 < ActiveRecord::Migration
  def self.up
    add_column :formation_g2s,:formateur_id,:integer
  end

  def self.down
  end
end
