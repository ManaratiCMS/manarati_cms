class Admin::CategoriesManagerController < ApplicationControllerCoreAdmin
 layout "admin"

 def index
   @page.titre =  t("GestionCategories.Pages.Index.titre")
   @categories = CmpCategorie.find(:all)
 end

 def new
     @categorie = CmpCategorie.new
     @categories_parent = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is NULL",])
 end


  def create
    categorie = CmpCategorie.new(params[:categorie])
    if categorie.save
      flash[:notice] = t("GestionCategories.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionCategories.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @categorie = CmpCategorie.find(params[:id])
     @categories_parent = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is NULL",])
  end

  def update
    @categorie = CmpCategorie.find(params[:id])
    if @categorie.update_attributes(params[:categorie])
      flash[:notice] = t("GestionCategories.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      categorie = CmpCategorie.find(params[:id])
      if categorie.destroy
        flash[:notice] = t("GestionCategories.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionCategories.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
  
  def setpublic
   categorie = CmpCategorie.find(params[:id])
   categorie.protection = 1
   categorie.save
   redirect_to :action=>:index
 end
 def setprivate
   categorie = CmpCategorie.find(params[:id])
   categorie.protection = 0
   categorie.save
   redirect_to :action=>:index
 end

end
