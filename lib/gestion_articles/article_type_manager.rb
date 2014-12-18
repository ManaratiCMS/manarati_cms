## To change this template, choose Tools | Templates
## and open the template in the editor.
#
#class ArticleTypeManager
#  def initialize
#
#
#  end
#
#  # Ajouter
#  def self.ajouter(objet)
#
#  end
#  # Supprimer
#  def self.supprimer(objet)
#
#  end
#
#  def self.update(objet)
#
#  end
#
#  def self.get_par_reference(reference)
#     article_type = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/gestion_articles/articles_types/" +reference + ".yml" )
#     if article_type.nil?
#       raise "l'article type #{params[:ref_art]} n'existe pas"
#     end
#     article_type
#  end
#
#  # Cherche Tous les Article type
#  def self.get_tous
#    liste_article_type = Array.new
#    Dir.new("#{RAILS_ROOT}/data_yml/gestion_articles/articles_types").grep(/.yml/).each { |item|
#      liste_article_type << get_par_reference(item.split(".yml")[0])
#    }
#    liste_article_type
#  end
#
#end
