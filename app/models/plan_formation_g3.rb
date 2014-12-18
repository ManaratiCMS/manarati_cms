class PlanFormationG3 < ActiveRecord::Base

 belongs_to :formation_g2
 belongs_to :element_cour_g3
 belongs_to :cmp_photo,:dependent => :destroy
 def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end



  # Redfinition de la méthode Save
  def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre =  PlanFormationG3.count(:conditions=>["formation_g2_id = ?", self.formation_g2_id]) + 1
   end
   
   super(perform_validation)
  end


   # Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    page = PlanFormationG3.find(id)
    # mise à jour les ordre
    pages =  PlanFormationG3.find(:all,:conditions=>['ordre > ? and formation_g2_id = ?',page.ordre,page.formation_g2_id])
     pages.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }

      super(id)
    
  end

  def suivant


    ordre_suivant = self.ordre + 1
    suiv = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',(ordre_suivant),self.formation_g2_id])
    
    while !suiv.nil? and suiv.element_cour_g3.nil?
    ordre_suivant += 1
    suiv = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',(ordre_suivant),self.formation_g2_id])
    end
    
    suiv
    
    

  end
  def precedent
    ordre_precedent = self.ordre - 1
    preced = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',ordre_precedent,self.formation_g2_id])

    while !preced.nil? and preced.element_cour_g3.nil?
    ordre_precedent  = ordre_precedent - 1
    preced = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',ordre_precedent,self.formation_g2_id])
    end
    preced
  end


   def move_down
      PlanFormationG3.init_ordre(self.formation_g2_id) if self.ordre.nil?
    if self.ordre < PlanFormationG3.count(:conditions=>["formation_g2_id = ?", self.formation_g2_id])
      ordre_suivant = self.ordre  + 1
      element_suivant = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ? ',ordre_suivant,self.formation_g2_id])
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
     PlanFormationG3.init_ordre(self.formation_g2_id) if self.ordre.nil?
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = PlanFormationG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',ordre_precedent,self.formation_g2_id])
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end

  def self.init_ordre(formation_id)

    objs = PlanFormationG3.find(:all,:conditions=>['formation_g2_id = ?',formation_id])
    objs.each_with_index { |obj,i|
      obj.ordre = i + 1
      obj.save
    }


  end
  
end
