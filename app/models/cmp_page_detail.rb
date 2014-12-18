class CmpPageDetail < ActiveRecord::Base

  has_many :cmp_articles  ,:dependent  => :destroy , :order=>"ordre"
  belongs_to :cmp_page_detail
  belongs_to :cmp_page


  #Validateur
  validates_uniqueness_of :reference , :message => "The reference isn't unique."
  validates_presence_of :reference, :lien,:type_objet


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
   self.ordre = CmpPageDetail.count + 1
   end

   # Ajouter une "/" au début de lien s'il n'existe pas
   self.lien = "/" + self.lien if self.lien.chars.to_a[0] != "/"


   if super(perform_validation)
     p "save page"
    # Ajouter le routage Dynamique de la page
    CmpPageDetail.map_routes
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
    CmpPageDetail.map_routes

  end



  # Trouver les pages traduit
  def get_pages_langue
    # id page principale
    if self.ref_id.nil?
      id_page_principale = self.id
    else
    id_page_principale = self.ref_id
    end
    pages = CmpPageDetail.find(:all,:conditions=>["(id = ? or ref_id = ?)",id_page_principale,id_page_principale])
#     pages = CmpPageDetail.find(:all,:joins => :cmp_config_apps ,:conditions=>["(id = ? or ref_id = ?) and cmp_config_apps.nom = ? and cmp_config_apps.valeur_txt = langue",self.id,self.id,"langues_actives"])
     pages
  end

  # chercher la page traduit
  def get_page_traduit(ref_langue)
    page = CmpPageDetail.find(:first,:conditions=>["langue = ? and ref_id = ?",ref_langue,self.id])
    page
  end


  # Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    page = CmpPageDetail.find(id)
    # mise à jour les ordre
    pages =  CmpPageDetail.find(:all,:conditions=>['ordre > ?',page.ordre])
     pages.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }
    # Suppresion des pages d'autre langues
    if CmpPageDetail.delete_all(["ref_id = ?",id])
      super(id)
    else
      false
    end
  end


  def move_down
    if self.ordre < CmpPageDetail.count()
      ordre_suivant = self.ordre  + 1
      element_suivant = CmpPageDetail.find(:first,:conditions=>['ordre = ?',ordre_suivant])
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = CmpPageDetail.find(:first,:conditions=>['ordre = ?',ordre_precedent])
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end



  # Warning : l'ajout d'un nouveau routage ne supprimer pas les rougage existant que aprés le redémarage
  # de server
  # For dynamic routing "Update map:resource", all the routes from database is obtained and real mapping is done here.
  def self.map_routes()
    ActionController::Routing::Routes.draw do |map|
      record_array = CmpPageDetail.find(:all)		
      for record in record_array
         eval "@liste_pages_detail = #{record.type_objet}.find(:all)"
         @liste_pages_detail.each { |objetd|

         if  !objetd.reference.nil?
         if objetd.reference.chars.to_a[0] != "/"
           eval "map.connect '#{record.lien}/#{objetd.reference}', :controller => 'system/page', :action => 'page_detail' ,:reference_page=>'#{record.reference}',:reference_objet=>'#{objetd.reference}',:type_objet=>'#{record.type_objet}'"
         else
           eval "map.connect '#{record.lien}#{objetd.reference}', :controller => 'system/page', :action => 'page_detail' ,:reference_page=>'#{record.reference}',:reference_objet=>'#{objetd.reference}',:type_objet=>'#{record.type_objet}'"
         end
         end
         }
      end
     end
  end
  
end
