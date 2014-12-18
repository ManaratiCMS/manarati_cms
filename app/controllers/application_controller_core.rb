class ApplicationControllerCore < ApplicationController

  layout :choix_layout
  protect_from_forgery
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

   # Chargement de la page
   page = nil

   @theme = CmpTheme.theme_active
   @skin =  @theme.ref_theme
   @skin_public = @skin
#   flash[:notice] = nil # initialisation de message
   @langue_active = CmpLangue.langue_principal.reference
      


   if request.xhr?
       @appel_ajax = true
   else
       @appel_ajax = false
   end
   
  end

  # Détermination de Layout Générale de Théme Active
  def choix_layout
     CmpTheme.theme_layout_active
  end




end
