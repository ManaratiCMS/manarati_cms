class Admin::ThemesManagerController < ApplicationControllerCoreAdmin
layout "admin"

 def index
   @page.titre =  t("GestionThemes.Pages.Index.titre")
   package = CmpTheme.package()
   if current_user.login == "root"
      @themes = CmpTheme.find(:all)
   else
       @themes = CmpTheme.find(:all,:conditions=>["protection = 1 and package = ?",package])
   end
    
    @theme_active = @skin_public
 end


 # Activer une theme
 def activer
    theme = CmpTheme.find(params[:id])
    theme.activer()
    redirect_to :action=>:index
 end

 def setpublic
   theme = CmpTheme.find(params[:id])
   theme.protection = 1
   theme.save
   redirect_to :action=>:index
 end
 def setprivate
   theme = CmpTheme.find(params[:id])
   theme.protection = 0
   theme.save
   redirect_to :action=>:index
 end

 def new
     @theme = CmpTheme.new
 end


  def create
    theme = CmpTheme.new(params[:theme])
    theme.sys_cmp_photo = SysCmpPhoto.new(params[:sys_cmp_photo])
    if theme.save
      flash[:notice] = t("GestionThemes.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionThemes.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @theme = CmpTheme.find(params[:id])
    @theme.sys_cmp_photo = SysCmpPhoto.new  if @theme.sys_cmp_photo.nil?
  end

  def update
    @theme = CmpTheme.find(params[:id])
    if @theme.sys_cmp_photo.nil?
    @theme.sys_cmp_photo = SysCmpPhoto.new
    @theme.save
    end
    @theme.sys_cmp_photo.update_attributes(params[:sys_cmp_photo])
    if @theme.update_attributes(params[:theme])
      flash[:notice] = t("GestionThemes.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      theme = CmpTheme.find(params[:id])
      if theme.destroy
        flash[:notice] = t("GestionThemes.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionThemes.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end



end
