class AddColoneOrdreToFormation < ActiveRecord::Migration
  def self.up

  add_column :formation_g2s,:ordre,:integer
  end

  def self.down

    
  end
end
