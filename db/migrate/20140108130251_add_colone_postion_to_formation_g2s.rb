class AddColonePostionToFormationG2s < ActiveRecord::Migration
  def self.up
    add_column :formation_g2s,:protection,:integer,{:default => 0}
  end

  def self.down
  end
end
