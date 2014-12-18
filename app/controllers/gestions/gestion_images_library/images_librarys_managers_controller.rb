class Gestions::GestionImagesLibrary::ImagesLibrarysManagersController < ApplicationControllerCoreAdmin
 layout "admin"
 
 def index
    @page.titre =  t("GestionImagesLibrarys.Pages.Index.titre")
    @images = ImageLibrary.find(:all)
 end


 def new
     @image = ImageLibrary.new
     @categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is null"])
     @sous_categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is not null"])

 end


  def create
    image = ImageLibrary.new(params[:image])
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    image.width_capture = config["width_capture"]
    image.height_capture = config["height_capture"]
    if image.save
      flash[:notice] = t("GestionImagesLibrarys.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionImagesLibrarys.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @image = ImageLibrary.find(params[:id])
    @categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is null"])
    @sous_categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is not null"])
  end

  def update
    @image = ImageLibrary.find(params[:id])


    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:image][:width_capture] = config["width_capture"]
    params[:image][:height_capture] = config["height_capture"]

    if @image.update_attributes(params[:image])
      flash[:notice] = t("GestionImagesLibrarys.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      image = ImageLibrary.find(params[:id])
      if image.destroy
        flash[:notice] = t("GestionImagesLibrarys.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionImagesLibrarys.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
end
