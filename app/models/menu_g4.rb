class MenuG4 < ActiveRecord::Base

  has_many :element_menu_g4 , :order => "ordre"

  def initialize(atributs=nil)
    super(atributs)
  end


  def save(perform_validation = true)
   # Calcule de l'ordre
   if self.ordre.nil? or self.ordre == 0
   self.ordre =  MenuG4.count() + 1
   end
   return super(perform_validation)
  end


# Supprimer la page et ses pages traduit,Update Ordre
  def self.destroy(id)
    menu = MenuG4.find(id)
    # mise à jour les ordre
    menus =  MenuG4.find(:all,:conditions=>['ordre > ?',menu.ordre])
     menus.each { |item|
      item.ordre = item.ordre - 1
      item.save
     }
    super(id)
  end

   def move_down
    MenuG4.init_ordre if self.ordre.nil?
    if self.ordre < MenuG4.count()
      ordre_suivant = self.ordre  + 1
      element_suivant = MenuG4.find(:first,:conditions=>['ordre = ?',ordre_suivant])
      MenuG4.init_ordre if element_suivant.nil?
      self.ordre = self.ordre + 1
      element_suivant.ordre = element_suivant.ordre  - 1
      self.save
      element_suivant.save
    end
  end

  def move_up
    MenuG4.init_ordre if self.ordre.nil?
    if self.ordre > 1
      ordre_precedent = self.ordre - 1
      element_precedent = MenuG4.find(:first,:conditions=>['ordre = ?',ordre_precedent])
      MenuG4.init_ordre if element_precedent.nil?
      self.ordre = self.ordre - 1
      element_precedent.ordre = element_precedent.ordre  + 1
      self.save
      element_precedent.save
    end
  end

  def self.init_ordre
    menus = MenuG4.find(:all)
    menus.each_with_index { |menu,i|
      menu.ordre = i + 1
      menu.save
    }
  end



end
