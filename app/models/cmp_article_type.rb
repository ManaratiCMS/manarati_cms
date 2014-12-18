class CmpArticleType < ActiveRecord::Base
  establish_connection "system_db"
  has_many :cmp_composants  
  belongs_to :sys_cmp_photo,:dependent => :destroy
  has_many  :cmp_article_type_themes
  def initialize(attributes=nil)
    super(attributes)
        self.sys_cmp_photo = SysCmpPhoto.new
  end

  def save(perform_validation = true)
  # Calcule de l'ordre
  if self.ordre.nil? or self.ordre == 0
    self.ordre = CmpArticleType.count() + 1
  end
  super(perform_validation)
end


 def cmp_composants

    ar = Array.new
    eval("@obj = " + self.type_composant +  ".new")
    @obj.reference = self.reference
    @obj.width = self.width
    @obj.height = self.height
    ar << @obj

    return ar
    
 end


  # return une instance d'une composant représenter par l'article type
  def cmp_composant
    eval("@obj = " + self.type_composant +  ".new")
    @obj.reference = self.reference
    @obj.width = self.width
    @obj.height = self.height
    @obj
    return @obj

 end



def move_down
   if self.ordre < CmpArticle.count()
    ordre_suivant = self.ordre  + 1
    article_suivant = CmpArticleType.find(:first,:conditions=>['ordre = ?',ordre_suivant])
    self.ordre = self.ordre + 1
    article_suivant.ordre = article_suivant.ordre  - 1
    self.save
    article_suivant.save
  end
end

def move_up
  if self.ordre > 1
    ordre_precedent = self.ordre - 1
    article_precedent = CmpArticleType.find(:first,:conditions=>['ordre = ?',ordre_precedent])
    self.ordre = self.ordre - 1
    article_precedent.ordre = article_precedent.ordre  + 1
    self.save
    article_precedent.save
  end
end


def self.destroy(id)
  article = CmpArticleType.find(id)
  # mise à jour les ordre
  articles =  CmpArticleType.find(:all,:conditions=>['ordre > ?',article.ordre])
   articles.each { |item|
    item.ordre = item.ordre - 1
    item.save
   }
  super(id)
end
end
