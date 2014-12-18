class CmpMenuAdmin < CmpMenuAbstract
  
establish_connection "system_db"
def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre = CmpMenuAdmin.count() + 1
   end
   super(perform_validation)
 end
 def self.destroy(id)
  menu = CmpMenuAdmin.find(id)
  # mise à jour les ordres
   menus =  CmpMenuAdmin.find(:all,:conditions=>['ordre > ?',menu.ordre])
   menus.each { |item|
    item.ordre = item.ordre - 1
    item.save
   }
  super(id)
end

 def move_down
  if self.ordre < CmpMenuAdmin.count()
    ordre_suivant = self.ordre  + 1
    element_suivant = CmpMenuAdmin.find(:first,:conditions=>['ordre = ?',ordre_suivant])
    self.ordre = self.ordre + 1
    element_suivant.ordre = element_suivant.ordre  - 1
    self.save
    element_suivant.save
  end
end

def move_up
  if self.ordre > 1
    ordre_precedent = self.ordre - 1
    element_precedent = CmpMenuAdmin.find(:first,:conditions=>['ordre = ?',ordre_precedent])
    self.ordre = self.ordre - 1
    element_precedent.ordre = element_precedent.ordre  + 1
    self.save
    element_precedent.save
  end
end
end
