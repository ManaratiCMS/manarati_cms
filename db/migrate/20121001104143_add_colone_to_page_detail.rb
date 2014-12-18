class AddColoneToPageDetail < ActiveRecord::Migration
  def self.up
    add_column :cmp_page_details,:cmp_page_id,:integer
    add_column :cmp_page_details,:cmp_page_detail_id,:integer
  end

  def self.down
  end
end
