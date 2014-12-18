# la classe formation , il représebte une formation dans la gestion des formation, exemple le site PiloteDev
class FormationG2 < ActiveRecord::Base
    belongs_to :cmp_photo,:dependent => :destroy
    belongs_to :cmp_animation_flash,:dependent => :destroy
    belongs_to :local_formation_g2
    has_many :session_g2
    belongs_to :menu_g4
    belongs_to :formateur

  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
    self.cmp_animation_flash = CmpAnimationFlash.new
  
  end


  def prochaine_session
    SessionG2.find(:first,:conditions=>["formation_g2_id = ?",self.id])
    
  end

  # Enregistrer une formation et map le routage le page
  def save(perform_validation = true)

   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre =  FormationG2.count() + 1
   end


   if super(perform_validation)
    CmpPageDetail.map_routes
    return true
   else

     return false
   end
  end


# Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    formation = FormationG2.find(id)
    # mise à jour les ordre
    formations =  FormationG2.find(:all,:conditions=>['ordre > ?',formation.ordre])
     formations.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }

    super(id)

  end

  def self.get_liste_obj_data_source

    liste_data_source = Array.new
    formations  = FormationG2.find(:all)
    formations.each { |item|
     data_source  = ObjSourceData.new
     data_source.titre = item.titre
     data_source.contenue = item.objectif
     
      liste_data_source <<  data_source

    }

    liste_data_source
  end


   def move_down
    FormationG2.init_ordre if self.ordre.nil?
    if self.ordre < FormationG2.count()
      ordre_suivant = self.ordre  + 1
      element_suivant = FormationG2.find(:first,:conditions=>['ordre = ?',ordre_suivant])
      FormationG2.init_ordre if element_suivant.nil?
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    FormationG2.init_ordre if self.ordre.nil?
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = FormationG2.find(:first,:conditions=>['ordre = ?',ordre_precedent])
      FormationG2.init_ordre if element_precedent.nil?
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end

  # Mettre la formation   Public
  def set_public
    # set l'element de menu ansi que ses element traduit en public
    FormationG2.update_all("protection = 1",["id = ?",self.id])
  end
  def set_private
    # set l'element de menu ansi que ses element traduit en public
    FormationG2.update_all("protection = 0",["id = ?",self.id])
  end
  

  def self.init_ordre

    formations = FormationG2.find(:all)
    formations.each_with_index { |formation,i|
      formation.ordre = i + 1
      formation.save 
    }


  end

  
end
