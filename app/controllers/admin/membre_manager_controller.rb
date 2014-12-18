# Gestion des Membre : il n'est utilisé
class Admin::MembreManagerController < ApplicationControllerCoreAdmin
  layout "admin"

   # Affichage de Toutes les Formation
  def index
    @page = CmpPage.new(:titre=>t("GestionMembres.titre_de_gestion"))
    @membres = User.find(:all)
  end

  def new
     @membre = User.new
  end


  # Création de Membre
  def create
    formation = User.new(params[:formation])
    if formation.save
      flash[:notice] = t("GestionFormations.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionFormations.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def add
    if !params[:id].blank? and !params[:membre].nil?
        User.update(params[:id], params[:membre])
        else
          page = User.new(params[:membre])
          page.save
        end
        index
        render :action=>:index
  end

  def update
    params[:id] = params[:sender_id] if !params[:sender_id].nil?
    @membre = User.find(params[:id])
    render :action=>:new
  end


  def delete
      page = User.find(params[:id])
      page.delete
      index
      render :action=>:index
  end
  
end
