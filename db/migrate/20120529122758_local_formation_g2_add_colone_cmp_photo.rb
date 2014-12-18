class LocalFormationG2AddColoneCmpPhoto < ActiveRecord::Migration
  def self.up
     add_column :local_formation_g2s,:cmp_photo_id,:integer
  end

  def self.down
  end
end
