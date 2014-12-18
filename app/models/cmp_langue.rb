class CmpLangue < ActiveRecord::Base
   # Protection = 0 : private
   # Protection = 1 : public
   establish_connection "system_db"
   belongs_to :sys_cmp_photo,:dependent => :destroy
   def initialize(atributs=nil)
    super(atributs)
    self.sys_cmp_photo = SysCmpPhoto.new
  end

    # Activer le thémes
   def activer
     confi_langue = CmpConfigApp.find(:first,:conditions=>["nom = ?","langue_principal"])
     if confi_langue.nil?
       confi_langue = CmpConfigApp.new
       confi_langue.nom = "langue_principal"
     end
     confi_langue.valeur_txt = self.reference
     confi_langue.save
   end


   def self.langue_principal
     langue = nil
     cmp_config = CmpConfigApp.find(:first, :conditions=>["nom = ?","langue_principal"])
     if !cmp_config.nil?
       langue = CmpLangue.find_by_reference(cmp_config.valeur_txt)
     end
     
      if  !langue.nil?
        langue
      else
        langue = CmpLangue.find_by_reference("fr")
        langue = CmpLangue.new if langue.nil?
        langue.reference = "fr"
        langue.nom = "Français"
        langue
      end


   end

   def self.langues_actives
     langues = Array.new
     cmp_config = CmpConfigApp.find(:all, :conditions=>["nom = ?","langues_actives"])
     if !cmp_config.nil?
      cmp_config.each { |item|
         langues <<  item.valeur_txt
       }
      langues
     else
       langues
     end
   end

   def self.liste_objt_langues_actives
     langues = Array.new
     cmp_config = CmpConfigApp.find(:all, :conditions=>["nom = ?","langues_actives"])
     if !cmp_config.nil?
      cmp_config.each { |item|
        langues <<  CmpLangue.find_by_reference( item.valeur_txt)
       }
      langues
     else
       langues
     end
   end



   def activer_langue
     confi_langue = CmpConfigApp.find(:first,:conditions=>["nom = ? and valeur_txt = ?","langues_actives",self.reference])
     if confi_langue.nil?
       confi_langue = CmpConfigApp.new
       confi_langue.nom = "langues_actives"
       confi_langue.valeur_txt = self.reference
       confi_langue.save
     end
   end

   def desactiver_langue
     confi_langue = CmpConfigApp.find(:first,:conditions=>["nom = ? and valeur_txt = ?","langues_actives",self.reference])
     if !confi_langue.nil?
       confi_langue.delete
     end
   end

   
end
