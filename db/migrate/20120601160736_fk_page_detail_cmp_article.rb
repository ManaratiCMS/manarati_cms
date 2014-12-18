class FkPageDetailCmpArticle < ActiveRecord::Migration
  def self.up
      add_column :cmp_articles,:cmp_page_detail_id,:integer
  end

  def self.down
  end
end
