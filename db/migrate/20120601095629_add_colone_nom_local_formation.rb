class AddColoneNomLocalFormation < ActiveRecord::Migration
  def self.up
     add_column :local_formation_g2s,:nom,:string
  end

  def self.down
  end
end
