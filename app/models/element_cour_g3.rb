class ElementCourG3 < ActiveRecord::Base
  has_many :cmp_composants  ,:dependent => :destroy, :order=>"ordre"
  belongs_to :formation_g2
  has_one :plan_formation_g3
  #Validateur
  validates_uniqueness_of :reference , :message => "The reference isn't unique."
  validates_presence_of :reference

  def initialize(attributes=nil)
    super(attributes)
  end


  # Redfinition de la méthode Save
  def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre =  ElementCourG3.count(:conditions=>["formation_g2_id = ?", self.formation_g2_id]) + 1
   end
   # Ajouter une "/" au début de lien s'il n'existe pas
   self.lien = "/" + self.lien if self.lien.chars.to_a[0] != "/"
   return super(perform_validation)
  end



  # Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    page = ElementCourG3.find(id)
    # mise à jour les ordre
    pages =  ElementCourG3.find(:all,:conditions=>['ordre > ? and formation_g2_id = ?',page.ordre,page.formation_g2_id])
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
    if self.ordre < ElementCourG3.count(:conditions=>["formation_g2_id = ?", self.formation_g2_id])
      ordre_suivant = self.ordre  + 1
      element_suivant = ElementCourG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ? ',ordre_suivant,self.formation_g2_id])
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = ElementCourG3.find(:first,:conditions=>['ordre = ? and formation_g2_id = ?',ordre_precedent,self.formation_g2_id])
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end


  def  lien_suivant
    suivant = nil
    suivant = self.plan_formation_g3.suivant if !self.plan_formation_g3.nil?
    if suivant.nil?
      lien = ""
    else
      if suivant.element_cour_g3.nil?
        lien = ""
      else
        lien = suivant.element_cour_g3.lien
      end
    end

  end
 def  lien_precedent
   precedent = nil
   precedent = self.plan_formation_g3.precedent if !self.plan_formation_g3.nil?
   if precedent.nil?
      lien = ""
    else
      if precedent.element_cour_g3.nil?
        lien = ""
      else
        lien = precedent.element_cour_g3.lien
      end
    end

  end


end
