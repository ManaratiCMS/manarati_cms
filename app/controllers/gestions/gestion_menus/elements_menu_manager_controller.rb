class Gestions::GestionMenus::ElementsMenuManagerController < ApplicationControllerCoreAdmin

 layout "admin"
 def index
    @id_menu = params[:id]
    @page.titre =  t("GestionElementMenuG4.Pages.Index.titre")
    @element_menus = ElementMenuG4.find(:all,:conditions=>["menu_g4_id = ?",@id_menu],:order=>"ordre")
 end


 def new
     @menu = MenuG4.find(params[:id])
     @element_menu = ElementMenuG4.new
 end


  def create
    element_menu = ElementMenuG4.new(params[:element_menu])
    element_menu.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    element_menu.langue = "fr"
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    element_menu.cmp_photo.width_capture = config["width_capture"]
    element_menu.cmp_photo.height_capture = config["height_capture"]



    if element_menu.save
      flash[:notice] = t("GestionFormationsG2.msg.ajouter_avec_succes")
      redirect_to :action=>:index ,:id=> element_menu.menu_g4_id
    else
      flash[:notice] = t("GestionFormationsG2.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @element_menu = ElementMenuG4.find(params[:id])
    @menu = @element_menu.menu_g4
    @element_menu.cmp_photo = CmpPhoto.new  if @element_menu.cmp_photo.nil?
  end

  def update
    @element_menu = ElementMenuG4.find(params[:id])
    if @element_menu.cmp_photo.nil?
    @element_menu.cmp_photo = CmpPhoto.new
    @element_menu.save
    end

    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @element_menu.cmp_photo.update_attributes(params[:cmp_photo])

    if @element_menu.update_attributes(params[:element_menu])
      flash[:notice] = t("Gestions.msg.editer_avec_succes")
      redirect_to :action=>:index,:id=> @element_menu.menu_g4_id
    else
      render :action => :edit
    end
  end

  def delete
      element_menu = ElementMenuG4.find(params[:id])
       if  ElementMenuG4.destroy(params[:id])
        flash[:notice] = t("Gestions.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("Gestions.msg.erreur de suppression")
      end
      redirect_to :action=>:index,:id=> element_menu.menu_g4_id
  end



   def move_up
    element_menu = ElementMenuG4.find(params[:id])
    element_menu.move_up
    redirect_to :action=>:index,:id=> element_menu.menu_g4_id
  end

  def move_down
    element_menu = ElementMenuG4.find(params[:id])
    element_menu.move_down
    redirect_to :action=>:index,:id=> element_menu.menu_g4_id
  end



end
