# To change this template, choose Tools | Templates
# and open the template in the editor.

class ArticleManager
  def initialize

  
  end

  # Ajouter
  def self.ajouter(objet)
    cmp_article = CmpArticle.new(objet.get_atributs)
    if(cmp_article.save)
      objet.reference = cmp_article.id.to_s
      objet.id = cmp_article.id.to_s
      SerialisationUtil.save(ArticleManager.chemin_fichier_yml(objet.reference),objet)
      return objet
    else
      return nil
    end
  end
  # Supprimer
  def self.supprimer(objet)
  end
  def self.supprimer_par_id(id)
     article = CmpArticle.find(id)
     if(article.delete)
          SerialisationUtil.supprimer(ArticleManager.chemin_fichier_yml(id))
     end
  end

  def self.update(objet)
    cmp_article = CmpArticle.find(objet.get_atributs[:id].to_i)
    if(CmpArticle.update(objet.get_atributs[:id],objet.get_atributs))
      SerialisationUtil.save(ArticleManager.chemin_fichier_yml(objet.id),objet)
      return objet
    else
      return nil
    end
  end

  def self.get_par_reference(reference)
    SerialisationUtil.load(ArticleManager.chemin_fichier_yml(reference ))
  end

  def self.get_tous
    Dir.foreach("#{RAILS_ROOT}/data_yml/gestion_articles/articles") { |filename|
      p   filename
    }
  end

  private
  def self.chemin_fichier_yml(reference)
   chemin = "#{RAILS_ROOT}/data_yml/gestion_articles/articles/" + reference + ".yml"
   chemin
  end

end
