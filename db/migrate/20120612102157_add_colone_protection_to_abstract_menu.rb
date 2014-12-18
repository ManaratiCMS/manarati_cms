class AddColoneProtectionToAbstractMenu < ActiveRecord::Migration
  def self.up
      add_column :cmp_menu_abstracts,:protection,:integer,{:default => 0}
  end

  def self.down
  end
end
