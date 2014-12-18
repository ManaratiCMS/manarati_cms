class AddColoneElementCours < ActiveRecord::Migration
  def self.up
     add_column :element_cour_g3s,:formation_g2_id,:integer
  end

  def self.down
  end
end
