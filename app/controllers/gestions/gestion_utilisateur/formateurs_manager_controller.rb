class Gestions::GestionUtilisateur::FormateursManagerController < ApplicationControllerCoreAdmin

 layout "admin"
 def index
    @page.titre =  t("GestionUtilisateurs.Pages.Index.titre")
    @utilisateurs = Formateur.find(:all)
 end


 def new
     @utilisateur = Formateur.new
 end


  def create
    utilisateur = Formateur.new(params[:utilisateur])
    utilisateur.cmp_photo = CmpPhoto.new(params[:cmp_photo])

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    utilisateur.cmp_photo.width_capture = config["width_capture"]
    utilisateur.cmp_photo.height_capture = config["height_capture"]



    if utilisateur.save
      flash[:notice] = t("GestionUtilisateurs.msg.ajouter_avec_succes")
      
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionUtilisateurs.msg.erreur_ajouter")
      new
      render :action => :new
    end
  end


  def edit
    @utilisateur = Formateur.find(params[:id])
    @utilisateur.cmp_photo = CmpPhoto.new  if @utilisateur.cmp_photo.nil?
  end

  def update
    @utilisateur = Formateur.find(params[:id])
    if @utilisateur.cmp_photo.nil?
    @utilisateur.cmp_photo = CmpPhoto.new
    @utilisateur.save
    end

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @utilisateur.cmp_photo.update_attributes(params[:cmp_photo])

    if @utilisateur.update_attributes(params[:utilisateur])
      flash[:notice] = t("GestionUtilisateurs.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      utilisateur = Formateur.find(params[:id])
      if utilisateur.destroy
        flash[:notice] = t("GestionUtilisateurs.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionUtilisateurs.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end


end
