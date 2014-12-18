class CmpArticleTypeTheme < ActiveRecord::Base
  establish_connection "system_db"
  belongs_to :cmp_article_type
end
