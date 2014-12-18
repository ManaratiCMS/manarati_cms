class AddCategorieToFormation < ActiveRecord::Migration
  def self.up
     add_column :formation_g2s,:menu_g4_id,:integer
  end

  def self.down
  end
end
