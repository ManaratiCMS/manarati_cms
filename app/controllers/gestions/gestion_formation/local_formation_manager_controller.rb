class Gestions::GestionFormation::LocalFormationManagerController < ApplicationControllerCoreAdmin

 layout "admin"
 def index
    @page.titre =  t("GestionLocalFormationsG2.Pages.Index.titre")
    @local_formations = LocalFormationG2.find(:all)
 end


 def new
     @local_formation = LocalFormationG2.new
 end


  def create
    local_formation = LocalFormationG2.new(params[:local_formation])
    local_formation.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    local_formation.cmp_photo.width_capture = config["width_capture"]
    local_formation.cmp_photo.height_capture = config["height_capture"]



    if local_formation.save
      flash[:notice] = t("GestionLocalFormationsG2.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionLocalFormationsG2.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @local_formation = LocalFormationG2.find(params[:id])
    @local_formation.cmp_photo = CmpPhoto.new  if @local_formation.cmp_photo.nil?
  end

  def update
    @local_formation = LocalFormationG2.find(params[:id])
    if @local_formation.cmp_photo.nil?
    @local_formation.cmp_photo = CmpPhoto.new
    @local_formation.save
    end

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @local_formation.cmp_photo.update_attributes(params[:cmp_photo])

    if @local_formation.update_attributes(params[:local_formation])
      flash[:notice] = t("GestionLocalFormationsG2.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      local_formation = LocalFormationG2.find(params[:id])
      if local_formation.destroy
        flash[:notice] = t("GestionLocalFormationsG2.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionLocalFormationsG2.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
end
