class Gestions::GestionCoursVideos::PlanFormationManagerController < ApplicationControllerCoreAdmin


layout "admin"
 def index
    @page.titre =  t("GestionPlanFormation.Pages.Index.titre")
    @id_formation = params[:id]
    @plan_formations = PlanFormationG3.find(:all,:order=>"ordre",:conditions=>["formation_g2_id = ?",@id_formation])
 end

 def init_ordre
   @id_formation = params[:id]
   PlanFormationG3.init_ordre(@id_formation)
   redirect_to :action=>:index,:id=>@id_formation
 end

 def new
     @id_formation = params[:id]
     @plan_formation = PlanFormationG3.new
     @element_cours = ElementCourG3.find(:all,:conditions=>["formation_g2_id = ?",@id_formation])
 end


  def create

    @id_formation = params[:id_formation]
    plan_formation = PlanFormationG3.new(params[:plan_formation])
    plan_formation.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    plan_formation.formation_g2_id = @id_formation
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    plan_formation.cmp_photo.width_capture = config["width_capture"]
    plan_formation.cmp_photo.height_capture = config["height_capture"]



    if plan_formation.save
      flash[:notice] = t("GestionPlanFormation.msg.ajouter_avec_succes")
      redirect_to :action=>:index, :id=>@id_formation
    else
      flash[:notice] = t("GestionPlanFormation.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @plan_formation = PlanFormationG3.find(params[:id])
    @id_formation = params[:id_formation]
    @plan_formation.cmp_photo = CmpPhoto.new  if @plan_formation.cmp_photo.nil?
    @element_cours = ElementCourG3.find(:all,:conditions=>["formation_g2_id = ?",@id_formation])
  end

  def update
    @id_formation = params[:id_formation]
    @plan_formation = PlanFormationG3.find(params[:id])
    if @plan_formation.cmp_photo.nil?
    @plan_formation.cmp_photo = CmpPhoto.new
    @plan_formation.save
    end

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @plan_formation.cmp_photo.update_attributes(params[:cmp_photo])

    if @plan_formation.update_attributes(params[:plan_formation])
      flash[:notice] = t("GestionPlanFormation.msg.editer_avec_succes")
      redirect_to :action=>:index,:id=>@id_formation
    else
      render :action => :edit
    end
  end

  def delete
      @id_formation = params[:id_formation]
      plan_formation = PlanFormationG3.find(params[:id])
      if plan_formation.destroy
        flash[:notice] = t("GestionPlanFormation.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionPlanFormation.msg.erreur de suppression")
      end
      redirect_to :action=>:index,:id=>@id_formation
  end


   def move_up
    plan_formation = PlanFormationG3.find(params[:id])
    plan_formation.move_up
    redirect_to :action=>:index,:id=> plan_formation.formation_g2_id
  end

  def move_down
    plan_formation = PlanFormationG3.find(params[:id])
    plan_formation.move_down
    redirect_to :action=>:index,:id=> plan_formation.formation_g2_id
  end
  
end
