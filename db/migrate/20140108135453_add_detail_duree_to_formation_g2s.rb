class AddDetailDureeToFormationG2s < ActiveRecord::Migration
  def self.up
    add_column :formation_g2s,:detail_duree,:string
  end

  def self.down
  end
end
