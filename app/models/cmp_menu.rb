class CmpMenu < CmpMenuAbstract
  belongs_to :cmp_page


  def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0 
      ref_langue = CmpLangue.langue_principal.reference
      self.ordre = CmpMenu.count(:conditions=>["ref_langue = ?",ref_langue]) + 1
   end
   super(perform_validation)
 end



  # Redifinition de la méthode update_attributes
  def update_attributes(atributs)
    self.attributes = atributs
    returned = save(false)

    # mettre à jour la page des element de menu traduit
    if self.ref_langue == CmpLangue.langue_principal.reference
       langues_active = CmpLangue.langues_actives
       langues_active.each { |item|
         element_menu_lg = CmpMenu.find(:first,:conditions=>["ref_id = ? and ref_langue = ?",self.id,item])
         unless element_menu_lg.nil?
           element_menu_lg.cmp_page_id = self.cmp_page.get_page_traduit(item).id
           element_menu_lg.save
         end
       }
    end
   returned
  end

  # Mettre le lien de menu en Public
  def set_public
    # set l'element de menu ansi que ses element traduit en public 
    CmpMenu.update_all("protection = 1",["ref_id = ? or id = ?",self.id,self.id])
  end
  def set_private
    # set l'element de menu ansi que ses element traduit en public
    CmpMenu.update_all("protection = 0",["ref_id = ? or id = ?",self.id,self.id])
  end

 # Calculer le lien de la page
 def lien_page
   if self.cmp_page.nil?
     return "#"
   else
     return self.cmp_page.lien
   end

 end

def self.destroy(id)
  menu = CmpMenu.find(id)
  # mise à jour les ordres 
   menus =  CmpMenu.find(:all,:conditions=>['ordre > ?',menu.ordre])
   menus.each { |item|
    item.ordre = item.ordre - 1
    item.save
   }

  # Suppresion des objet Traduit 
  if CmpMenu.delete_all(["ref_id = ?",id])
    super(id)
  else
    false
  end
end






 def move_down
  if self.ordre < CmpMenu.count()
    ordre_suivant = self.ordre  + 1
    ref_langue = CmpLangue.langue_principal.reference
    element_suivant = CmpMenu.find(:first,:conditions=>['ref_langue = ? and ordre = ?',ref_langue,ordre_suivant])
    self.ordre = self.ordre + 1
    element_suivant.ordre = element_suivant.ordre  - 1
    self.save
    element_suivant.save
  end
end

def move_up
  if self.ordre > 1
    ordre_precedent = self.ordre - 1
    ref_langue = CmpLangue.langue_principal.reference
    element_precedent = CmpMenu.find(:first,:conditions=>['ref_langue = ? and ordre = ?',ref_langue,ordre_precedent])
    self.ordre = self.ordre - 1
    element_precedent.ordre = element_precedent.ordre  + 1
    self.save
    element_precedent.save
  end
end
end
