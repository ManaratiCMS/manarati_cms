class Gestions::GestionFormation::SessionFormationManagerController < ApplicationControllerCoreAdmin

 layout "admin"
 def index
    @page.titre =  t("GestionSessionFormationG2.Pages.Index.titre")
    @session_formations = SessionG2.find(:all)
 end


 def new
     @session_formation = SessionG2.new
     @locaux = LocalFormationG2.find(:all)
     @formations = FormationG2.find(:all)
 end


  def create
    session_formation = SessionG2.new(params[:session_formation])

    if session_formation.save
      flash[:notice] = t("GestionSessionFormationG2.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionSessionFormationG2.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @session_formation = SessionG2.find(params[:id])
    @locaux = LocalFormationG2.find(:all)
    @formations = FormationG2.find(:all)
  end

  def update
    @session_formation = SessionG2.find(params[:id])
    if @session_formation.update_attributes(params[:session_formation])
      flash[:notice] = t("GestionSessionFormationG2.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      session_formation = SessionG2.find(params[:id])
      if session_formation.destroy
        flash[:notice] = t("GestionSessionFormationG2.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionSessionFormationG2.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
end
