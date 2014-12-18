class Gestions::GestionLivres::Admin::LivresManagersController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionLivres.Pages.Index.titre")
    @livres = LivreG1.find(:all)
 end


 def new
     @livre = LivreG1.new
     @auteurs = AuteurG1.find(:all)
 end


  def create
    livre = LivreG1.new(params[:livre])
    livre.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    if livre.save
      flash[:notice] = t("GestionLivres.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionLivres.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @livre = LivreG1.find(params[:id])
    @livre.cmp_photo = CmpPhoto.new  if @livre.cmp_photo.nil?
    @auteurs = AuteurG1.find(:all)
  end

  def update
    @livre = LivreG1.find(params[:id])
    if @livre.cmp_photo.nil?
    @livre.cmp_photo = CmpPhoto.new
    @livre.save
    end
    @livre.cmp_photo.update_attributes(params[:cmp_photo])
    if @livre.update_attributes(params[:livre])
      flash[:notice] = t("GestionLivres.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      livre = LivreG1.find(params[:id])
      if livre.destroy
        flash[:notice] = t("GestionLivres.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionLivres.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
end
