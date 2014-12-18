class CmpMenuCmpPageAssociation < ActiveRecord::Migration
  def self.up
    add_column :cmp_menu_abstracts,:cmp_page_id,:integer
 
  end

  def self.down
    remove_column :cmp_menu_abstracts,:cmp_page_id
  end
end
