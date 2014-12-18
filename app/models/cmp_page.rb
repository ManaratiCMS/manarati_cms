class CmpPage < ActiveRecord::Base
  belongs_to :user
  has_many :cmp_articles  ,:dependent  => :destroy , :order=>"ordre"
  has_one  :cmp_menu

  # ??
  attr_accessor    :_cmp_articles 

  #Validateur
  validates_uniqueness_of :reference , :message => "The reference isn't unique."
  validates_presence_of :reference
#   validates_presence_of  :lien


  def initialize(attributes=nil)
    super(attributes)
  end

  # Chercher le Layaout de la page
  def get_cmp_layout
  # le la yaout est le premier composant de la page ( article)
  articles = self.cmp_articles
  unless articles.nil?
   return self.cmp_articles[0]
  else
    return nil
  end
  end


  # Redfinition de la méthode Save
  def save(perform_validation = true)
    
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre = CmpPage.count + 1
   end

   # Ajouter une "/" au début de lien s'il n'existe pas
   self.lien = "/" + self.lien if self.lien.chars.to_a[0] != "/"

  
   if super(perform_validation)
     p "save page"
    # Ajouter le routage Dynamique de la page
    CmpPage.map_routes
    return true
   else
        p "note save page"
     return false
   end
  end

  # Redifinition de la méthode update_attributes
  def update_attributes(atributs)


    self.attributes = atributs
    save(false)
    # Ajouter le routage Dynamique de la page
    CmpPage.map_routes

  end



  # Trouver les pages traduit
  def get_pages_langue
    # id page principale
    if self.ref_id.nil?
      id_page_principale = self.id
    else
    id_page_principale = self.ref_id
    end
    pages = CmpPage.find(:all,:conditions=>["(id = ? or ref_id = ?)",id_page_principale,id_page_principale])
#     pages = CmpPage.find(:all,:joins => :cmp_config_apps ,:conditions=>["(id = ? or ref_id = ?) and cmp_config_apps.nom = ? and cmp_config_apps.valeur_txt = langue",self.id,self.id,"langues_actives"])
     pages
  end

  # chercher la page traduit
  def get_page_traduit(ref_langue)
    page = CmpPage.find(:first,:conditions=>["langue = ? and ref_id = ?",ref_langue,self.id])
    page
  end


  # Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    page = CmpPage.find(id)
    # mise à jour les ordre
    pages =  CmpPage.find(:all,:conditions=>['ordre > ?',page.ordre])
     pages.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }
    # Suppresion des pages d'autre langues
    if CmpPage.delete_all(["ref_id = ?",id])
      super(id)
    else
      false
    end
  end


  def move_down
    if self.ordre < CmpPage.count()
      ordre_suivant = self.ordre  + 1
      element_suivant = CmpPage.find(:first,:conditions=>['ordre = ?',ordre_suivant])
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = CmpPage.find(:first,:conditions=>['ordre = ?',ordre_precedent])
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end

  # Cherche la page suivant
  def page_suivant
    ordre_suivant = self.ordre  + 1
    page = CmpPage.find(:first,:conditions=>['formation_id = ? and  ordre = ?',self.formation_id,ordre_suivant])
    page
  end
  def page_precedent
    ordre_precedent = self.ordre - 1
    page = CmpPage.find(:first,:conditions=>['formation_id = ? and  ordre = ?',self.formation_id,ordre_precedent])
    page
  end

  

  # Warning : l'ajout d'un nouveau routage ne supprimer pas les rougage existant que aprés le redémarage
  # de server
  # For dynamic routing "Update map:resource", all the routes from database is obtained and real mapping is done here.
  def self.map_routes()
    ActionController::Routing::Routes.draw do |map|

      record_array = CmpPage.find(:all)			# get records(route info) from Model
      if record_array.nil?							# if table is empty then
      raise Exception    						    # raise exception
      else
      for record in record_array				    # get record and eval with map connect
         eval "map.connect '#{record.lien}', :controller => 'system/articles', :action => 'afficher' ,:reference_page=>'#{record.reference}'"
      end
      end
      
     end
  end


end
