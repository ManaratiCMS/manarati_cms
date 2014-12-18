class ApplicationControllerCoreAdmin < ApplicationController
  # Importer tous les Helpers
  helper :all
 

  # Configuration : Theme , Url en cours
  before_filter :config_application
 

  private

  # Configuration  : Thème 
  def config_application
   # Initailisation de l'objet Page si la page n'existe pas dans la base de données
   @page = CmpPage.new # Initialisation de l'objet @page représentant la page en cours
   # il y a deux type de page : Page Public et Page Admin
   # la page public est défini par une referecne_page


 


   @theme = CmpTheme.theme_active
   @obj_langue_principale =  CmpLangue.langue_principal
   @langue_active =@obj_langue_principale.reference
   @langue_principale = @langue_active
   
    



   @skin_public = @theme.ref_theme
   @skin = "theme1_admin"
   @skin_admin = "theme1_admin"



   if request.xhr?
       @appel_ajax = true
   else
       @appel_ajax = false
   end



  end



 


end
