class Admin::ComposantsExistantManagerController < ApplicationControllerCoreAdmin
   layout "admin"
 def index
    @page.titre =  t("GestionComposantsExistant.Pages.Index.titre")
    @cmp_composants_existants = CmpComposantsExistant.find(:all)
 end

 def new
     @cmp_composants_existant = CmpComposantsExistant.new
 end


  def create
    composant = CmpComposantsExistant.new(params[:cmp_composants_existant])

    if composant.save
      flash[:notice] = t("GestionComposantsExistant.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionComposantsExistant.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @cmp_composants_existant = CmpComposantsExistant.find(params[:id])

  end

  def update
    @composant = CmpComposantsExistant.find(params[:id])

     
    if @composant.update_attributes(params[:cmp_composants_existant])
      flash[:notice] = t("GestionComposantsExistant.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      composant = CmpComposantsExistant.find(params[:id])
      if composant.destroy
        flash[:notice] = t("GestionComposantsExistant.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionComposantsExistant.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
end
