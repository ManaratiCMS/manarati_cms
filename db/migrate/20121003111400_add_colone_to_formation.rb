class AddColoneToFormation < ActiveRecord::Migration
  def self.up
     add_column :formation_g2s,:cmp_animation_flash_id,:integer
  end

  def self.down
  end
end
