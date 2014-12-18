class FormationG2AddLocalFk < ActiveRecord::Migration
  def self.up
    add_column :formation_g2s,:local_formation_g2_id,:integer
  end

  def self.down
  end
end
