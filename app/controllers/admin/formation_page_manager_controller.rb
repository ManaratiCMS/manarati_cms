# Gestion des Pages de formation
class Admin::FormationPageManagerController < ApplicationControllerCoreAdmin
 layout "admin"


 filter_access_to [:create,:update] ,:model=>:formation,:attribute_check=>true,:load_method => lambda { Formation.find(params[:cmp_page][:formation_id]) }
 filter_access_to [:delete,:edit,:move_page_up,:move_page_down] ,:model=>:formation,:attribute_check=>true,:load_method => lambda { CmpPage.find(params[:id]).formation }
 


  def move_page_up
    page = CmpPage.find(params[:id])
    page.move_page_formation_up
    redirect_to "/admin/formation_manager/edit/#{page.formation_id}"
  end

  def move_page_down
    page = CmpPage.find(params[:id])
    page.move_page_formation_down
    redirect_to "/admin/formation_manager/edit/#{page.formation_id}"
  end

  # Ajouter une page la formation
  def new
     @formation = Formation.find(params[:id_formation])
     @cmp_page = CmpPage.new
     @cmp_page.reference = @formation.reference + "_"
     @cmp_page.lien = "/" + @formation.reference + "/"
     @cmp_page.formation_id = @formation.id
  end

   # Ajouter une page à la formation 
  def create
    page = CmpPage.new(params[:cmp_page])
    page.formation = Formation.find(page.formation_id)
    page.user_id = current_user.id # L'utilisateur Créateur de la page 
    if page.save
      flash[:notice] = t("GestionPages.msg.page_ajouter_avec_succes")
      redirect_to "/admin/formation_manager/edit/#{page.formation_id}"
    else
      flash[:notice] = t("GestionPages.msg.erreur_ajouter_page")
      redirect_to "/admin/formation_page_manager/new?id_formation=#{page.formation_id}"
      
    end
  end

  def delete
      page = CmpPage.find(params[:id])
      id_formation = page.formation_id
      if CmpPage.destroy(page.id)
        flash[:notice] = t("GestionPages.msg.page_supprimer_avec_succes")
      else
        flash[:notice] = t("GestionPages.msg.erreur de suppression")
      end
      redirect_to "/admin/formation_manager/edit/#{id_formation}"

  end
  
  # Mise à jour de la page
  def update
    @cmp_page = CmpPage.find(params[:id])
    if @cmp_page.update_attributes(params[:cmp_page])
      flash[:notice] = t("GestionPages.msg.page_editer_avec_succes")
      redirect_to "/admin/formation_manager/edit/#{@cmp_page.formation_id}"
    else
      render :action => :edit
    end
  end

  # Editer une page de laformation
  def edit
      @cmp_page = CmpPage.find(params[:id])
      @formation = Formation.find(@cmp_page.formation_id)
  end

end
