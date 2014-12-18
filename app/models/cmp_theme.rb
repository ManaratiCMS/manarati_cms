class CmpTheme < ActiveRecord::Base
   # Protection = 0 : private
   # Protection = 1 : public
   # package : on peut changer entrer les thèmes existant dans même package
   establish_connection "system_db"
   belongs_to :sys_cmp_photo,:dependent => :destroy
   def initialize(atributs=nil)
    super(atributs)
    self.sys_cmp_photo = SysCmpPhoto.new
  end


   # Retourn le Package de l'application
   def self.package
     cmp_config = CmpConfigApp.find(:first, :conditions=>["nom = ?","package"])
      if !cmp_config.nil?
        cmp_config.valeur_txt
     else
       "public"
     end
   end


   # Activer le thémes
   def activer
     config_theme = CmpConfigApp.find(:first,:conditions=>["nom = ?","theme"])
     if config_theme.nil?
       config_theme = CmpConfigApp.new
       config_theme.nom = "theme"
     end
     config_theme.valeur_txt = self.ref_theme
     config_theme.save
   end

 def self.theme_active
     cmp_config = CmpConfigApp.find(:first, :conditions=>["nom = ?","theme"])
     theme = nil
     if !cmp_config.nil?
       theme = CmpTheme.find_by_ref_theme(cmp_config.valeur_txt)
     end

     if theme.nil?
      theme =CmpTheme.new
      theme.ref_theme = "public_sys"
      theme.use_system_theme = 0
     
     end

   return  theme

   end

   def self.theme_layout_active
     cmp_config = CmpConfigApp.find(:first, :conditions=>["nom = ?","theme"])
     if cmp_config.nil?
       "public"
     else
       theme = CmpTheme.find(:first,:conditions=>["ref_theme = ?",cmp_config.valeur_txt])
       theme.layout
     end

   end

end
