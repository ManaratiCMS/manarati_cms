class Gestions::GestionLivres::Admin::AuteursManagersController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionAuteurs.Pages.Index.titre")
    @auteurs = AuteurG1.find(:all)
 end


 def new
     @auteur = AuteurG1.new
 end


  def create
    auteur = AuteurG1.new(params[:auteur])
    auteur.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    if auteur.save
      flash[:notice] = t("GestionAuteurs.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionAuteurs.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @auteur = AuteurG1.find(params[:id])
    @auteur.cmp_photo = CmpPhoto.new  if @auteur.cmp_photo.nil?
  end

  def update
    @auteur = AuteurG1.find(params[:id])
    if @auteur.cmp_photo.nil?
    @auteur.cmp_photo = CmpPhoto.new
    @auteur.save
    end
    @auteur.cmp_photo.update_attributes(params[:cmp_photo])
    if @auteur.update_attributes(params[:auteur])
      flash[:notice] = t("GestionAuteurs.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      auteur = AuteurG1.find(params[:id])
      if auteur.destroy
        flash[:notice] = t("GestionAuteurs.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionAuteurs.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
end
