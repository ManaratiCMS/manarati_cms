# To change this template, choose Tools | Templates
# and open the template in the editor.

class Article
  attr_accessor :id, :reference,:date_creation,:liste_elements_article,:ref_article_classe,:ref_pocesseur
 
  def initialize(atributs=nil)
    set_atributs(atributs)
    @liste_elements_article = []
#   Gestion des Exception
    if @reference.nil?
      raise "Il faut choisire une référecne de l'article"
    end
  end

 def get_atributs
   atributs = {}
   atributs[:reference] = @reference
   atributs[:id] = @id
   atributs[:ref_pocesseur] = @ref_pocesseur
   atributs
 end
 def set_atributs(atributs=nil)
   if !atributs.nil?
      @reference = atributs[:reference] if !atributs[:reference].nil?
      @id = atributs[:id] if !atributs[:id].nil?
      @date_creation = atributs[:date_creation] if !atributs[:date_creation].nil?
      @ref_pocesseur =  atributs[:ref_pocesseur] if !atributs[:ref_pocesseur].nil?
    end
 end
 
  def self.charger(reference_article,group=nil)
    if group.blank?
    SerialisationUtil.load("#{RAILS_ROOT}/data_yml/gestion_articles/articles/#{reference_article}.yml")
    else
    SerialisationUtil.load("#{RAILS_ROOT}/data_yml/gestion_articles/articles/#{group}/#{reference_article}.yml")
    end
  end
end
