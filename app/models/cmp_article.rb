class CmpArticle < ActiveRecord::Base
#  using_access_control
has_many :cmp_composants  ,:dependent => :destroy
belongs_to :cmp_page
belongs_to :cmp_page_detail
belongs_to :cmp_article; 
has_many :cmp_articles ,:dependent => :destroy,:order => "ordre"

belongs_to :cmp_article_type, :primary_key => "reference", :foreign_key => "ref_article_classe"
 
def initialize(attributes=nil)
  super(attributes)
end

# Normalement un article représent un seul composant
def cmp_composant
  if !cmp_composants.nil? 
  return self.cmp_composants[0]
  else
    return nil
  end
end

# Trouver l'article trduit d'une article
def article_traduit(ref_langue)
  CmpArticle.find(:first,:conditions=>["langue = ? and ref_id = ?",ref_langue,self.id])
end

#
# Ajouter un article dans une page sans formulaire
#
# - Ajouter un layout dans une page
#
def self.add_article_to_page(reference_article_type,id_page,ref_id=nil,ref_langue="fr")
      article_type = CmpArticleType.find_last_by_reference(reference_article_type)
      
      article = CmpArticle.new()
      article.ref_article_classe = article_type.reference
      article.fichier_css = article_type.fichier_css
      article.fichier_js = article_type.fichier_js
      article.libs_css = article_type.libs_css
      article.libs_js = article_type.libs_js
      article.cmp_page_id = id_page
      article.ref_id = ref_id
      article.langue = ref_langue


      article_type.cmp_composants.each { |composant|
        # Instantiation de l'objet Composant en conaissant sont type 
        cmp_composant = CmpComposantAtomiqueManager.getCmpParType(composant.type)
        cmp_composant.reference = composant.reference
        cmp_composant.label_form = composant.label_form
        article.cmp_composants << cmp_composant
       }


      if  article.save_parent()
       return true
      else
       return false
      end

end
def self.add_article_to_page_detail(reference_article_type,id_page,ref_id=nil,ref_langue="fr")
      article_type = CmpArticleType.find_last_by_reference(reference_article_type)

      article = CmpArticle.new()
      article.ref_article_classe = article_type.reference
      article.fichier_css = article_type.fichier_css
      article.fichier_js = article_type.fichier_js
      article.libs_css = article_type.libs_css
      article.libs_js = article_type.libs_js
      article.cmp_page_detail_id = id_page
      article.ref_id = ref_id
      article.langue = ref_langue


      article_type.cmp_composants.each { |composant|
        # Instantiation de l'objet Composant en conaissant sont type
        cmp_composant = CmpComposantAtomiqueManager.getCmpParType(composant.type)
        cmp_composant.reference = composant.reference
        cmp_composant.label_form = composant.label_form
        article.cmp_composants << cmp_composant
       }


      if  article.save_parent()
       return true
      else
       return false
      end

end


def self.add_article_type_to_liste_article(ref_langue,ref_article_type,id_article_langue_principale,id_article_patent,zone)

      article_langue_principal = CmpArticle.find(id_article_langue_principale)
      article_type = CmpArticleType.find_last_by_reference(ref_article_type)
      article = CmpArticle.new
      article.ref_article_classe = article_type.reference
      article.fichier_css = article_type.fichier_css
      article.fichier_js = article_type.fichier_js
      article.libs_css = article_type.libs_css
      article.libs_js = article_type.libs_js
      article.cmp_article_id = id_article_patent
      article.nom_zone =  zone
      article.langue = ref_langue
      article.ref_id = id_article_langue_principale if !ref_langue.nil?
      article.ordre = article_langue_principal.ordre
      
      
     article_type.cmp_composants.each { |composant|
        cmp_composant = CmpComposantAtomiqueManager.getCmpParType(composant.type)
        cmp_composant.reference = composant.reference
        cmp_composant.label_form = composant.label_form
        cmp_composant.width = article_langue_principal.cmp_composant.width
        cmp_composant.height = article_langue_principal.cmp_composant.height
        article.cmp_composants << cmp_composant
      }
      article.save_fils()
end


def save_parent(perform_validation = true)
  # ordre = 1 , le premier article de la page c'est le layaout
  self.save
end


def move_down
   if self.ordre < CmpArticle.count(:conditions=>"cmp_page_id = #{self.cmp_page_id}")
    ordre_suivant = self.ordre  + 1
    article_suivant = CmpArticle.find(:first,:conditions=>['cmp_page_id = ? and  ordre = ?',self.cmp_page_id,ordre_suivant])
    self.ordre = self.ordre + 1
    article_suivant.ordre = article_suivant.ordre  - 1
    self.save
    article_suivant.save
  end
end

def move_up
  if self.ordre > 1
    ordre_precedent = self.ordre - 1
    article_precedent = CmpArticle.find(:first,:conditions=>['cmp_page_id = ? and  ordre = ?',self.cmp_page_id,ordre_precedent])
    self.ordre = self.ordre - 1
    article_precedent.ordre = article_precedent.ordre  + 1
    self.save
    article_precedent.save
  end
end


def self.destroy_parent(id)
  article = CmpArticle.find(id)
  # mise à jour les ordre
   articles =  CmpArticle.find(:all,:conditions=>['cmp_page_id = ? and ordre > ?',article.cmp_page_id,article.ordre])
   articles.each { |item|
    item.ordre = item.ordre - 1
    item.save
   }
   self.destroy(id)
end

# Suppresion de Composant de Layout
def self.destroy_fils(id)
  article = CmpArticle.find(id)

  # Suppression des Composant Traduit s'il existe
   CmpArticle.delete_all(["ref_id = ?",id])


  # Supprimer les le Composant et Recalculer les ordres des composants
   articles =  CmpArticle.find(:all,:conditions=>['cmp_article_id = ? and ordre > ? and nom_zone = ?',article.cmp_article_id,article.ordre,article.nom_zone])
   articles.each { |item|
    # l'ordre de l'article
    item.ordre = item.ordre - 1
    item.save
    # l'ordre de l'article traduit
    articles_traduit =  CmpArticle.find(:all,:conditions=>[' ordre > ? and nom_zone = ? and ref_id = ?',article.ordre,article.nom_zone,article.id])
    articles_traduit.each { |pt|
      pt.ordre = pt.ordre - 1
      pt.save
    }

   }
  self.destroy(id)


end

 # Gestion ArticleFils

def save_fils(perform_validation = true)
  # Calcule de l'ordre
  if self.ordre.nil? or self.ordre == 0
  self.ordre = CmpArticle.count(:conditions=>"cmp_article_id = #{self.cmp_article_id} and nom_zone = '#{self.nom_zone}'") + 1
  end
   self.save
end

def move_down_fils
   if self.ordre < CmpArticle.count(:conditions=>"cmp_article_id = #{self.cmp_article_id} and nom_zone = '#{self.nom_zone}'")
    ordre_suivant = self.ordre  + 1
    article_suivant = CmpArticle.find(:first,:conditions=>['cmp_article_id = ? and  ordre = ?  and nom_zone = ?',self.cmp_article_id,ordre_suivant,self.nom_zone])
    self.ordre = self.ordre + 1
    article_suivant.ordre = article_suivant.ordre  - 1
    self.save
    article_suivant.save
  end
end

def move_up_fils
  if self.ordre > 1
    ordre_precedent = self.ordre - 1
    article_precedent = CmpArticle.find(:first,:conditions=>['cmp_article_id = ? and  ordre = ? and nom_zone = ? ',self.cmp_article_id,ordre_precedent,self.nom_zone])
    self.ordre = self.ordre - 1
    article_precedent.ordre = article_precedent.ordre  + 1
    self.save
    article_precedent.save
  end
end





end
