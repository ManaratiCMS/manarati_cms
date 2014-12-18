# Affichage des Page
# il y a deus type de page :
# - page normale
# - page formation

class System::ArticlesController < ApplicationControllerCore
  
  caches_page :afficher,:afficher_page_formation

  def afficher
    @page = CmpPage.find_by_reference(params[:reference_page])
    # Calcule du chemin de la page
    @chemin_page = []
    @chemin_page << {:nom=>( (@page.cmp_menu.nil?)? @page.titre : @page.cmp_menu.nom ),:lien=>@page.lien}
  end
  
  def afficher_page_site_web
     @page = CmpPage.find_by_reference(params[:reference_page])
     render :layout=>"public_site"
  end
 
  def afficher_page_formation
    @page = CmpPage.find_by_reference(params[:reference_page])
  end

 
end
