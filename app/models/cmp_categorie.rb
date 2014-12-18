class CmpCategorie < ActiveRecord::Base
  belongs_to :cmp_categorie,:dependent => :destroy
end
