class ElementMenuG4 < ActiveRecord::Base

    belongs_to :cmp_photo,:dependent => :destroy
    belongs_to :menu_g4
    

  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end




 # Redfinition de la méthode Save
  def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre =  ElementMenuG4.count(:conditions=>["menu_g4_id = ?", self.menu_g4_id]) + 1
   end
   # Ajouter une "/" au début de lien s'il n'existe pas
   self.lien = "/" + self.lien if self.lien.chars.to_a[0] != "/"
   return super(perform_validation)
  end



  # Supprimer la element_menu et ses element_menus traduit,Update Ordre
  def self.destroy(id)
    element_menu = ElementMenuG4.find(id)
    # mise à jour les ordre
    element_menus =  ElementMenuG4.find(:all,:conditions=>['ordre > ? and menu_g4_id = ?',element_menu.ordre,element_menu.menu_g4_id])
     element_menus.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }
    # Suppresion des element_menus d'autre langues
    if ElementMenuG4.delete_all(["ref_id = ?",id])
      super(id)
    else
      false
    end
  end



   def move_down
    if self.ordre < ElementMenuG4.count(:conditions=>["menu_g4_id = ?", self.menu_g4_id])
      ordre_suivant = self.ordre  + 1
      element_suivant = ElementMenuG4.find(:first,:conditions=>['ordre = ? and menu_g4_id = ? ',ordre_suivant,self.menu_g4_id])
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = ElementMenuG4.find(:first,:conditions=>['ordre = ? and menu_g4_id = ?',ordre_precedent,self.menu_g4_id])
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end

end
