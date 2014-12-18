class Gestions::GestionPartenaires::Admin::PartenairesManagersController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionPartenaires.Pages.Index.titre")
    @partenaires = PartenaireG2.find(:all)
 end


 def new
     @partenaire = PartenaireG2.new
 end


  def create
    partenaire = PartenaireG2.new(params[:partenaire])
    partenaire.cmp_photo = CmpPhoto.new(params[:cmp_photo])

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    partenaire.cmp_photo.width_capture = config["width_capture"]
    partenaire.cmp_photo.height_capture = config["height_capture"]



    if partenaire.save
      flash[:notice] = t("GestionPartenaires.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionPartenaires.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @partenaire = PartenaireG2.find(params[:id])
    @partenaire.cmp_photo = CmpPhoto.new  if @partenaire.cmp_photo.nil?
  end

  def update
    @partenaire = PartenaireG2.find(params[:id])
    if @partenaire.cmp_photo.nil?
    @partenaire.cmp_photo = CmpPhoto.new
    @partenaire.save
    end
    
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @partenaire.cmp_photo.update_attributes(params[:cmp_photo])
    
    if @partenaire.update_attributes(params[:partenaire])
      flash[:notice] = t("GestionPartenaires.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      partenaire = PartenaireG2.find(params[:id])
      if partenaire.destroy
        flash[:notice] = t("GestionPartenaires.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionPartenaires.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
end
