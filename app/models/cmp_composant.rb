class CmpComposant < ActiveRecord::Base

belongs_to :element_cour_g3

#var boolean oui ou non
attr_accessor :traduction
# ref de langue à traduir
attr_accessor :ref_langue
#using_access_control
belongs_to :cmp_article
belongs_to :cmp_article_type
  before_destroy { |record|
    p "Destroy Composant" + record.id.to_s
#    CmpMedia.destroy_all "cmp_composant_id = #{record.id}"
  }

# renvoi le composant traduit
def composant_traduit_principal
  cmp = CmpArticle.find(self.cmp_article.ref_id).cmp_composants[0]
  cmp
end


  
end
