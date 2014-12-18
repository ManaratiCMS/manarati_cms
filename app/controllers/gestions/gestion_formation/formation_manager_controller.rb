class Gestions::GestionFormation::FormationManagerController < ApplicationControllerCoreAdmin

 layout "admin"
 def index
    @page.titre =  t("GestionFormationsG2.Pages.Index.titre")
    @formations = FormationG2.find(:all,:order=>"ordre")
 end


 def new
     @formation = FormationG2.new
     @locaux = LocalFormationG2.find(:all)
     @categories = MenuG4.find(:all)
     @formateurs = Formateur.find(:all)
 end


  def create
    formation = FormationG2.new(params[:formation])
    formation.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    formation.cmp_animation_flash = CmpAnimationFlash.new(params[:cmp_animation_flash])
    
    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    formation.cmp_photo.width_capture = config["width_capture"]
    formation.cmp_photo.height_capture = config["height_capture"]



    if formation.save
      flash[:notice] = t("GestionFormationsG2.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionFormationsG2.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @formation = FormationG2.find(params[:id])
    @formation.cmp_photo = CmpPhoto.new  if @formation.cmp_photo.nil?
    @formation.cmp_animation_flash = CmpAnimationFlash.new  if @formation.cmp_animation_flash.nil?
    @locaux = LocalFormationG2.find(:all)
    @categories = MenuG4.find(:all)
    @formateurs = Formateur.find(:all)
  end

  def update
    @formation = FormationG2.find(params[:id])
    if @formation.cmp_photo.nil?
    @formation.cmp_photo = CmpPhoto.new
    @formation.save
    end
    if @formation.cmp_animation_flash.nil?
      @formation.cmp_animation_flash = CmpAnimationFlash.new
    @formation.save
    end


    nom_fichier = "config_images_library.yml"
    config = YAML::load(File.open("#{RAILS_ROOT}/app/controllers/gestions/gestion_images_library/config/#{nom_fichier}", "r"))
    params[:cmp_photo][:width_capture] = config["width_capture"]
    params[:cmp_photo][:height_capture]= config["height_capture"]
    @formation.cmp_photo.update_attributes(params[:cmp_photo])
    @formation.cmp_animation_flash.update_attributes(params[:cmp_flash])

    if @formation.update_attributes(params[:formation])
      flash[:notice] = t("GestionFormationsG2.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      formation = FormationG2.find(params[:id])
       if  FormationG2.destroy(params[:id])
        flash[:notice] = t("GestionFormationsG2.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionFormationsG2.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end



   def move_up
    formation = FormationG2.find(params[:id])
    formation.move_up
    redirect_to :action=>:index
  end

  def move_down
    formation = FormationG2.find(params[:id])
    formation.move_down
    redirect_to :action=>:index
  end

 def setpublic
   formation = FormationG2.find(params[:id])
   formation.set_public
   redirect_to :action=>:index
 end
 def setprivate
   formation = FormationG2.find(params[:id])
   formation.set_private
   redirect_to :action=>:index
 end


  
end
